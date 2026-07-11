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
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }
        .defaultSize(width: 900, height: 600)
        .windowStyle(.hiddenTitleBar)
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
}
