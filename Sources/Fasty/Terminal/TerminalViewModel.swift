import SwiftUI
import GhosttyTerminal

@MainActor
class TerminalViewModel: ObservableObject {
    @Published var title = "Fasty"
    @Published var isReady = false
    @Published var currentTheme: TerminalColorScheme

    let terminalState = TerminalViewState()
    let session: PTYSession

    private var inMemorySession: InMemoryTerminalSession?

    init(session: PTYSession) {
        self.session = session
        self.currentTheme = .catppuccinMocha
    }

    func setup() {
        let inMemory = InMemoryTerminalSession(
            write: { [weak self] data in
                self?.session.write(data)
            },
            resize: { [weak self] viewport in
                self?.session.resize(cols: UInt32(viewport.columns), rows: UInt32(viewport.rows))
            }
        )
        self.inMemorySession = inMemory

        terminalState.configuration = TerminalSurfaceOptions(
            backend: .inMemory(inMemory)
        )

        session.onOutput = { [weak self] data in
            self?.inMemorySession?.receive(data)
        }

        session.onExit = { [weak self] _ in
            Task { @MainActor in
                self?.title = "Fasty (Exited)"
            }
        }

        session.start(cols: 80, rows: 24)

        isReady = true
    }

    func updateTheme(_ theme: TerminalColorScheme) {
        currentTheme = theme
    }
}
