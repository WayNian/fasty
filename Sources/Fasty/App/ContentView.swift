import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State private var currentSession = PTYSession()

    var body: some View {
        TerminalView(session: currentSession)
    }
}
