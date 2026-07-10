import SwiftUI
import GhosttyTerminal

struct TerminalView: View {
    @StateObject private var viewModel: TerminalViewModel
    @EnvironmentObject var settings: SettingsViewModel

    init(session: PTYSession) {
        _viewModel = StateObject(wrappedValue: TerminalViewModel(session: session))
    }

    var body: some View {
        ZStack {
            if viewModel.isReady {
                TerminalSurfaceView(context: viewModel.terminalState)
                    .navigationTitle(viewModel.title)
                    .background(settings.currentColorScheme.background)
            } else {
                ProgressView("Loading terminal...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(settings.currentColorScheme.background)
            }
        }
        .onAppear {
            viewModel.setup()
        }
        .onReceive(NotificationCenter.default.publisher(for: .themeDidChange)) { notification in
            if let themeName = notification.userInfo?["theme"] as? String {
                viewModel.updateTheme(TerminalColorScheme.from(themeName: themeName))
            }
        }
    }
}
