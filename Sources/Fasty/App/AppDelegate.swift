import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set activation policy to make it a regular app (not background)
        NSApp.setActivationPolicy(.regular)

        // Activate and bring to front
        NSApp.activate(ignoringOtherApps: true)

        // Ensure window becomes key after launch
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.bringWindowsToFront()
        }
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateNow
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationSupportsRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        bringWindowsToFront()
        return true
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        bringWindowsToFront()
    }

    private func bringWindowsToFront() {
        for window in NSApp.windows where window.isVisible {
            window.makeKeyAndOrderFront(nil)
            window.level = .normal
            window.makeFirstResponder(window.contentView)
        }
        NSApp.activate(ignoringOtherApps: true)
    }

    @IBAction func newWindow(_ sender: Any) {
        NotificationCenter.default.post(name: .newWindow, object: nil)
    }
}

extension Notification.Name {
    static let newWindow = Notification.Name("com.fasty.newWindow")
    static let themeDidChange = Notification.Name("com.fasty.themeDidChange")
}
