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

        // Apply initial theme configuration
        let config = buildTerminalConfiguration(for: currentTheme)
        terminalState.configuration = TerminalSurfaceOptions(
            backend: .inMemory(inMemory)
        )
        terminalState.controller.setTerminalConfiguration(config)

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
        let config = buildTerminalConfiguration(for: theme)
        terminalState.controller.setTerminalConfiguration(config)
    }

    private func buildTerminalConfiguration(for theme: TerminalColorScheme) -> TerminalConfiguration {
        TerminalConfiguration { builder in
            // Background
            builder.withBackground(theme.background.hexString)

            // Foreground
            builder.withForeground(theme.foreground.hexString)

            // Cursor
            builder.withCursorColor(theme.cursor.hexString)
            builder.withCursorText(theme.background.hexString)

            // Selection
            builder.withSelectionBackground(theme.selection.hexString)
            builder.withSelectionForeground(theme.foreground.hexString)

            // Palette (0-7: normal colors, 8-15: bright colors)
            builder.withPalette(0, color: theme.black.hexString)
            builder.withPalette(1, color: theme.red.hexString)
            builder.withPalette(2, color: theme.green.hexString)
            builder.withPalette(3, color: theme.yellow.hexString)
            builder.withPalette(4, color: theme.blue.hexString)
            builder.withPalette(5, color: theme.magenta.hexString)
            builder.withPalette(6, color: theme.cyan.hexString)
            builder.withPalette(7, color: theme.white.hexString)
            builder.withPalette(8, color: theme.brightBlack.hexString)
            builder.withPalette(9, color: theme.brightRed.hexString)
            builder.withPalette(10, color: theme.brightGreen.hexString)
            builder.withPalette(11, color: theme.brightYellow.hexString)
            builder.withPalette(12, color: theme.brightBlue.hexString)
            builder.withPalette(13, color: theme.brightMagenta.hexString)
            builder.withPalette(14, color: theme.brightCyan.hexString)
            builder.withPalette(15, color: theme.brightWhite.hexString)

            // Font
            builder.withFontFamily("Menlo")
            builder.withFontSize(14)
            builder.withFontThicken(true)

            // Cursor style
            builder.withCursorStyle(.block)
            builder.withCursorStyleBlink(true)
        }
    }
}

extension Color {
    var hexString: String {
        let components = NSColor(self).usingColorSpace(.deviceRGB) ?? NSColor(self)
        let r = Int(components.redComponent * 255)
        let g = Int(components.greenComponent * 255)
        let b = Int(components.blueComponent * 255)
        return String(format: "#%02x%02x%02x", r, g, b)
    }
}
