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
        let theme = buildTerminalTheme(for: currentTheme)
        terminalState.configuration = TerminalSurfaceOptions(
            backend: .inMemory(inMemory)
        )
        terminalState.controller.setTheme(theme)

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
        let terminalTheme = buildTerminalTheme(for: theme)
        terminalState.controller.setTheme(terminalTheme)
    }

    private func buildTerminalTheme(for scheme: TerminalColorScheme) -> TerminalTheme {
        let config = buildTerminalConfiguration(for: scheme)
        return TerminalTheme(light: config, dark: config)
    }

    private func buildTerminalConfiguration(for scheme: TerminalColorScheme) -> TerminalConfiguration {
        TerminalConfiguration { builder in
            // Background
            builder.withBackground(scheme.background.hexString)

            // Foreground
            builder.withForeground(scheme.foreground.hexString)

            // Cursor
            builder.withCursorColor(scheme.cursor.hexString)
            builder.withCursorText(scheme.background.hexString)

            // Selection
            builder.withSelectionBackground(scheme.selection.hexString)
            builder.withSelectionForeground(scheme.foreground.hexString)

            // Palette (0-7: normal colors, 8-15: bright colors)
            builder.withPalette(0, color: scheme.black.hexString)
            builder.withPalette(1, color: scheme.red.hexString)
            builder.withPalette(2, color: scheme.green.hexString)
            builder.withPalette(3, color: scheme.yellow.hexString)
            builder.withPalette(4, color: scheme.blue.hexString)
            builder.withPalette(5, color: scheme.magenta.hexString)
            builder.withPalette(6, color: scheme.cyan.hexString)
            builder.withPalette(7, color: scheme.white.hexString)
            builder.withPalette(8, color: scheme.brightBlack.hexString)
            builder.withPalette(9, color: scheme.brightRed.hexString)
            builder.withPalette(10, color: scheme.brightGreen.hexString)
            builder.withPalette(11, color: scheme.brightYellow.hexString)
            builder.withPalette(12, color: scheme.brightBlue.hexString)
            builder.withPalette(13, color: scheme.brightMagenta.hexString)
            builder.withPalette(14, color: scheme.brightCyan.hexString)
            builder.withPalette(15, color: scheme.brightWhite.hexString)

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
