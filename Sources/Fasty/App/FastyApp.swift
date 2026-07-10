import SwiftUI
import GhosttyTerminal

@main
struct FastyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var settings = SettingsViewModel()
    @State private var currentSession = PTYSession()

    var body: some Scene {
        WindowGroup {
            TerminalView(session: currentSession)
                .environmentObject(settings)
                .frame(minWidth: 600, minHeight: 400)
                .onAppear {
                    configureAppearance()
                }
        }
        .defaultSize(width: 900, height: 600)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified(showsTitle: true))
        .commands {
            CommandGroup(replacing: .newItem) { }
            CommandGroup(after: .pasteboard) {
                Button("Clear Buffer") {
                    // TODO: Clear terminal buffer
                }
                .keyboardShortcut("k", modifiers: [.command])
            }
        }

        Settings {
            SettingsView()
                .environmentObject(settings)
        }
    }

    private func configureAppearance() {
        NSWindow.allowsAutomaticWindowTabbing = false

        // Aggressive window activation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            NSApp.activate(ignoringOtherApps: true)
            for window in NSApp.windows where window.isVisible {
                window.makeKeyAndOrderFront(nil)
                window.makeFirstResponder(window.contentView)
                break
            }
        }
    }
}
