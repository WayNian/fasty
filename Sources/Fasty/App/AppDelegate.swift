import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            for window in NSApp.windows where window.isVisible {
                window.makeKeyAndOrderFront(nil)
                window.level = .normal
                window.makeFirstResponder(window.contentView)
                // Enable window dragging by background
                window.isMovableByWindowBackground = true
            }
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateNow
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        for window in NSApp.windows where window.isVisible {
            window.makeKeyAndOrderFront(nil)
        }
        NSApp.activate(ignoringOtherApps: true)
        return true
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        for window in NSApp.windows where window.isVisible {
            window.makeKeyAndOrderFront(nil)
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
