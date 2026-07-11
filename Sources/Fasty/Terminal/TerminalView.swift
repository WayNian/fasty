import SwiftUI
import GhosttyTerminal

struct TerminalView: View {
    @StateObject private var viewModel: TerminalViewModel
    @EnvironmentObject var settings: SettingsViewModel
    @State private var bgColor: Color = .black

    init(session: PTYSession) {
        _viewModel = StateObject(wrappedValue: TerminalViewModel(session: session))
    }

    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()

            if viewModel.isReady {
                TerminalSurfaceView(context: viewModel.terminalState)
                    .navigationTitle(viewModel.title)
            } else {
                ProgressView("Loading terminal...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            applyTheme(settings.themeName)
            viewModel.setup()
        }
        .onReceive(settings.objectWillChange) { _ in
            applyTheme(settings.themeName)
        }
    }

    private func applyTheme(_ name: String) {
        let scheme = TerminalColorScheme.from(themeName: name)
        bgColor = scheme.background
        viewModel.updateTheme(scheme)
    }
}
