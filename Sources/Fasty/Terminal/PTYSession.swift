import Foundation
import CBridge

class PTYSession: ObservableObject {
    @Published var isRunning = false

    private var masterFd: Int32 = -1
    private var childPid: pid_t = -1
    private var readSource: DispatchSourceRead?

    let id = UUID()
    let shell: String

    var onOutput: ((Data) -> Void)?
    var onExit: ((Int32) -> Void)?

    init(shell: String = ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/zsh") {
        self.shell = shell
    }

    func start(cols: UInt32, rows: UInt32) {
        var master: Int32 = 0

        var winsize = winsize(ws_row: UInt16(rows), ws_col: UInt16(cols), ws_xpixel: 0, ws_ypixel: 0)

        // Use forkpty to create a new pseudo-terminal and fork
        let pid = fasty_forkpty(&master, nil, nil, &winsize)

        guard pid >= 0 else {
            return
        }

        self.masterFd = master
        self.childPid = pid

        if pid == 0 {
            // Child process - exec shell
            _ = fasty_exec_shell(shell)
            _exit(1)
        }

        // Parent process
        DispatchQueue.main.async { self.isRunning = true }

        let readQueue = DispatchQueue(label: "com.fasty.pty.\(id.uuidString)")
        readSource = DispatchSource.makeReadSource(fileDescriptor: master, queue: readQueue)
        readSource?.setEventHandler { [weak self] in
            var buffer = [UInt8](repeating: 0, count: 65536)
            let bytesRead = Darwin.read(master, &buffer, buffer.count)
            if bytesRead > 0 {
                self?.onOutput?(Data(bytes: buffer, count: bytesRead))
            }
        }
        readSource?.setCancelHandler { [weak self] in
            close(master)
            self?.onExit?(0)
        }
        readSource?.resume()
    }

    func write(_ data: Data) {
        data.withUnsafeBytes { ptr in
            _ = Darwin.write(masterFd, ptr.baseAddress!, data.count)
        }
    }

    func resize(cols: UInt32, rows: UInt32) {
        var winsize = winsize(ws_row: UInt16(rows), ws_col: UInt16(cols), ws_xpixel: 0, ws_ypixel: 0)
        _ = ioctl(masterFd, UInt(TIOCSWINSZ), &winsize)
    }

    func terminate() {
        if childPid > 0 {
            kill(childPid, SIGTERM)
        }
        readSource?.cancel()
    }

    deinit {
        terminate()
    }
}
