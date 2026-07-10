import SwiftUI
import GhosttyTerminal

struct TerminalView: View {
    @StateObject private var viewModel: TerminalViewModel
    @EnvironmentObject var settings: SettingsViewModel
    @State private var backgroundColor: Color = .black

    init(session: PTYSession) {
        _viewModel = StateObject(wrappedValue: TerminalViewModel(session: session))
    }

    var body: some View {
        ZStack {
            // Background layer
            backgroundColor
                .ignoresSafeArea()

            // Terminal layer
            if viewModel.isReady {
                TerminalSurfaceView(context: viewModel.terminalState)
                    .navigationTitle(viewModel.title)
            } else {
                ProgressView("Loading terminal...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            backgroundColor = settings.currentColorScheme.background
            viewModel.setup()
        }
        .onChange(of: settings.themeName) { _, newValue in
            let newTheme = TerminalColorScheme.from(themeName: newValue)
            backgroundColor = newTheme.background
            viewModel.updateTheme(newTheme)
        }
    }
}
