import SwiftUI

struct TerminalColorScheme {
    let background: Color
    let foreground: Color
    let cursor: Color
    let selection: Color

    let black: Color
    let red: Color
    let green: Color
    let yellow: Color
    let blue: Color
    let magenta: Color
    let cyan: Color
    let white: Color

    let brightBlack: Color
    let brightRed: Color
    let brightGreen: Color
    let brightYellow: Color
    let brightBlue: Color
    let brightMagenta: Color
    let brightCyan: Color
    let brightWhite: Color

    static func from(themeName: String) -> TerminalColorScheme {
        switch themeName {
        case "Catppuccin Mocha": return .catppuccinMocha
        case "Catppuccin Latte": return .catppuccinLatte
        case "Catppuccin Frappe": return .catppuccinFrappe
        case "Catppuccin Macchiato": return .catppuccinMacchiato
        case "Dracula": return .dracula
        case "Gruvbox Dark": return .gruvboxDark
        case "Gruvbox Light": return .gruvboxLight
        case "Nord": return .nord
        case "Solarized Dark": return .solarizedDark
        case "Solarized Light": return .solarizedLight
        case "Tokyo Night": return .tokyoNight
        case "One Dark": return .oneDark
        case "One Light": return .oneLight
        case "Monokai Pro": return .monokaiPro
        case "GitHub Dark": return .githubDark
        case "GitHub Light": return .githubLight
        default: return .catppuccinMocha
        }
    }

    // MARK: - Catppuccin Mocha
    static let catppuccinMocha = TerminalColorScheme(
        background: Color(red: 0.11, green: 0.11, blue: 0.13),
        foreground: Color(red: 0.90, green: 0.90, blue: 0.95),
        cursor: Color(red: 0.90, green: 0.90, blue: 0.95),
        selection: Color(red: 0.27, green: 0.28, blue: 0.35),
        black: Color(red: 0.11, green: 0.11, blue: 0.13),
        red: Color(red: 0.90, green: 0.33, blue: 0.35),
        green: Color(red: 0.47, green: 0.75, blue: 0.50),
        yellow: Color(red: 0.95, green: 0.75, blue: 0.45),
        blue: Color(red: 0.45, green: 0.55, blue: 0.85),
        magenta: Color(red: 0.85, green: 0.45, blue: 0.65),
        cyan: Color(red: 0.45, green: 0.75, blue: 0.75),
        white: Color(red: 0.90, green: 0.90, blue: 0.95),
        brightBlack: Color(red: 0.40, green: 0.40, blue: 0.45),
        brightRed: Color(red: 0.95, green: 0.45, blue: 0.45),
        brightGreen: Color(red: 0.55, green: 0.80, blue: 0.55),
        brightYellow: Color(red: 1.00, green: 0.80, blue: 0.55),
        brightBlue: Color(red: 0.55, green: 0.65, blue: 0.90),
        brightMagenta: Color(red: 0.90, green: 0.55, blue: 0.75),
        brightCyan: Color(red: 0.55, green: 0.80, blue: 0.80),
        brightWhite: Color(red: 0.95, green: 0.95, blue: 1.00)
    )

    // MARK: - Catppuccin Latte
    static let catppuccinLatte = TerminalColorScheme(
        background: Color(red: 0.93, green: 0.92, blue: 0.91),
        foreground: Color(red: 0.25, green: 0.25, blue: 0.27),
        cursor: Color(red: 0.25, green: 0.25, blue: 0.27),
        selection: Color(red: 0.85, green: 0.84, blue: 0.83),
        black: Color(red: 0.25, green: 0.25, blue: 0.27),
        red: Color(red: 0.80, green: 0.25, blue: 0.27),
        green: Color(red: 0.37, green: 0.60, blue: 0.37),
        yellow: Color(red: 0.75, green: 0.55, blue: 0.25),
        blue: Color(red: 0.25, green: 0.40, blue: 0.65),
        magenta: Color(red: 0.65, green: 0.25, blue: 0.45),
        cyan: Color(red: 0.25, green: 0.55, blue: 0.55),
        white: Color(red: 0.25, green: 0.25, blue: 0.27),
        brightBlack: Color(red: 0.55, green: 0.55, blue: 0.57),
        brightRed: Color(red: 0.85, green: 0.35, blue: 0.35),
        brightGreen: Color(red: 0.45, green: 0.65, blue: 0.45),
        brightYellow: Color(red: 0.80, green: 0.60, blue: 0.30),
        brightBlue: Color(red: 0.35, green: 0.50, blue: 0.75),
        brightMagenta: Color(red: 0.75, green: 0.35, blue: 0.55),
        brightCyan: Color(red: 0.35, green: 0.65, blue: 0.65),
        brightWhite: Color(red: 0.20, green: 0.20, blue: 0.22)
    )

    // MARK: - Catppuccin Frappe
    static let catppuccinFrappe = TerminalColorScheme(
        background: Color(red: 0.15, green: 0.16, blue: 0.20),
        foreground: Color(red: 0.85, green: 0.85, blue: 0.90),
        cursor: Color(red: 0.85, green: 0.85, blue: 0.90),
        selection: Color(red: 0.28, green: 0.29, blue: 0.35),
        black: Color(red: 0.15, green: 0.16, blue: 0.20),
        red: Color(red: 0.85, green: 0.30, blue: 0.32),
        green: Color(red: 0.45, green: 0.70, blue: 0.45),
        yellow: Color(red: 0.90, green: 0.70, blue: 0.40),
        blue: Color(red: 0.40, green: 0.50, blue: 0.80),
        magenta: Color(red: 0.80, green: 0.40, blue: 0.60),
        cyan: Color(red: 0.40, green: 0.70, blue: 0.70),
        white: Color(red: 0.85, green: 0.85, blue: 0.90),
        brightBlack: Color(red: 0.40, green: 0.42, blue: 0.48),
        brightRed: Color(red: 0.90, green: 0.40, blue: 0.42),
        brightGreen: Color(red: 0.55, green: 0.75, blue: 0.55),
        brightYellow: Color(red: 0.95, green: 0.75, blue: 0.50),
        brightBlue: Color(red: 0.50, green: 0.60, blue: 0.85),
        brightMagenta: Color(red: 0.85, green: 0.50, blue: 0.70),
        brightCyan: Color(red: 0.50, green: 0.75, blue: 0.75),
        brightWhite: Color(red: 0.90, green: 0.90, blue: 0.95)
    )

    // MARK: - Catppuccin Macchiato
    static let catppuccinMacchiato = TerminalColorScheme(
        background: Color(red: 0.12, green: 0.12, blue: 0.15),
        foreground: Color(red: 0.88, green: 0.88, blue: 0.93),
        cursor: Color(red: 0.88, green: 0.88, blue: 0.93),
        selection: Color(red: 0.26, green: 0.27, blue: 0.33),
        black: Color(red: 0.12, green: 0.12, blue: 0.15),
        red: Color(red: 0.88, green: 0.32, blue: 0.34),
        green: Color(red: 0.46, green: 0.73, blue: 0.47),
        yellow: Color(red: 0.93, green: 0.73, blue: 0.43),
        blue: Color(red: 0.43, green: 0.53, blue: 0.83),
        magenta: Color(red: 0.83, green: 0.43, blue: 0.63),
        cyan: Color(red: 0.43, green: 0.73, blue: 0.73),
        white: Color(red: 0.88, green: 0.88, blue: 0.93),
        brightBlack: Color(red: 0.38, green: 0.40, blue: 0.46),
        brightRed: Color(red: 0.93, green: 0.43, blue: 0.43),
        brightGreen: Color(red: 0.53, green: 0.78, blue: 0.53),
        brightYellow: Color(red: 0.98, green: 0.78, blue: 0.53),
        brightBlue: Color(red: 0.53, green: 0.63, blue: 0.88),
        brightMagenta: Color(red: 0.88, green: 0.53, blue: 0.73),
        brightCyan: Color(red: 0.53, green: 0.78, blue: 0.78),
        brightWhite: Color(red: 0.93, green: 0.93, blue: 0.98)
    )

    // MARK: - Dracula
    static let dracula = TerminalColorScheme(
        background: Color(red: 0.15, green: 0.16, blue: 0.21),
        foreground: Color(red: 0.95, green: 0.95, blue: 0.97),
        cursor: Color(red: 0.95, green: 0.95, blue: 0.97),
        selection: Color(red: 0.25, green: 0.27, blue: 0.35),
        black: Color(red: 0.15, green: 0.16, blue: 0.21),
        red: Color(red: 0.95, green: 0.32, blue: 0.35),
        green: Color(red: 0.45, green: 0.85, blue: 0.50),
        yellow: Color(red: 0.95, green: 0.82, blue: 0.40),
        blue: Color(red: 0.45, green: 0.55, blue: 0.95),
        magenta: Color(red: 0.85, green: 0.40, blue: 0.65),
        cyan: Color(red: 0.40, green: 0.85, blue: 0.80),
        white: Color(red: 0.95, green: 0.95, blue: 0.97),
        brightBlack: Color(red: 0.40, green: 0.42, blue: 0.50),
        brightRed: Color(red: 1.00, green: 0.42, blue: 0.42),
        brightGreen: Color(red: 0.55, green: 0.90, blue: 0.55),
        brightYellow: Color(red: 1.00, green: 0.88, blue: 0.52),
        brightBlue: Color(red: 0.55, green: 0.65, blue: 1.00),
        brightMagenta: Color(red: 0.95, green: 0.52, blue: 0.75),
        brightCyan: Color(red: 0.52, green: 0.90, blue: 0.85),
        brightWhite: Color(red: 1.00, green: 1.00, blue: 1.00)
    )

    // MARK: - Gruvbox Dark
    static let gruvboxDark = TerminalColorScheme(
        background: Color(red: 0.12, green: 0.11, blue: 0.10),
        foreground: Color(red: 0.85, green: 0.82, blue: 0.75),
        cursor: Color(red: 0.85, green: 0.82, blue: 0.75),
        selection: Color(red: 0.25, green: 0.22, blue: 0.18),
        black: Color(red: 0.12, green: 0.11, blue: 0.10),
        red: Color(red: 0.80, green: 0.30, blue: 0.25),
        green: Color(red: 0.60, green: 0.65, blue: 0.20),
        yellow: Color(red: 0.85, green: 0.60, blue: 0.15),
        blue: Color(red: 0.40, green: 0.50, blue: 0.60),
        magenta: Color(red: 0.75, green: 0.35, blue: 0.40),
        cyan: Color(red: 0.40, green: 0.60, blue: 0.50),
        white: Color(red: 0.85, green: 0.82, blue: 0.75),
        brightBlack: Color(red: 0.40, green: 0.38, blue: 0.35),
        brightRed: Color(red: 0.85, green: 0.40, blue: 0.30),
        brightGreen: Color(red: 0.70, green: 0.75, blue: 0.30),
        brightYellow: Color(red: 0.95, green: 0.70, blue: 0.25),
        brightBlue: Color(red: 0.55, green: 0.65, blue: 0.75),
        brightMagenta: Color(red: 0.85, green: 0.45, blue: 0.50),
        brightCyan: Color(red: 0.55, green: 0.75, blue: 0.60),
        brightWhite: Color(red: 0.95, green: 0.92, blue: 0.85)
    )

    // MARK: - Gruvbox Light
    static let gruvboxLight = TerminalColorScheme(
        background: Color(red: 0.95, green: 0.93, blue: 0.87),
        foreground: Color(red: 0.20, green: 0.19, blue: 0.17),
        cursor: Color(red: 0.20, green: 0.19, blue: 0.17),
        selection: Color(red: 0.85, green: 0.82, blue: 0.75),
        black: Color(red: 0.20, green: 0.19, blue: 0.17),
        red: Color(red: 0.70, green: 0.15, blue: 0.12),
        green: Color(red: 0.40, green: 0.45, blue: 0.05),
        yellow: Color(red: 0.65, green: 0.40, blue: 0.00),
        blue: Color(red: 0.15, green: 0.25, blue: 0.35),
        magenta: Color(red: 0.55, green: 0.15, blue: 0.20),
        cyan: Color(red: 0.15, green: 0.40, blue: 0.30),
        white: Color(red: 0.20, green: 0.19, blue: 0.17),
        brightBlack: Color(red: 0.55, green: 0.53, blue: 0.48),
        brightRed: Color(red: 0.80, green: 0.25, blue: 0.18),
        brightGreen: Color(red: 0.50, green: 0.55, blue: 0.12),
        brightYellow: Color(red: 0.75, green: 0.50, blue: 0.08),
        brightBlue: Color(red: 0.25, green: 0.35, blue: 0.45),
        brightMagenta: Color(red: 0.65, green: 0.25, blue: 0.30),
        brightCyan: Color(red: 0.25, green: 0.50, blue: 0.40),
        brightWhite: Color(red: 0.15, green: 0.14, blue: 0.12)
    )

    // MARK: - Nord
    static let nord = TerminalColorScheme(
        background: Color(red: 0.13, green: 0.15, blue: 0.19),
        foreground: Color(red: 0.85, green: 0.87, blue: 0.92),
        cursor: Color(red: 0.85, green: 0.87, blue: 0.92),
        selection: Color(red: 0.22, green: 0.25, blue: 0.32),
        black: Color(red: 0.13, green: 0.15, blue: 0.19),
        red: Color(red: 0.80, green: 0.35, blue: 0.35),
        green: Color(red: 0.45, green: 0.70, blue: 0.45),
        yellow: Color(red: 0.90, green: 0.70, blue: 0.35),
        blue: Color(red: 0.45, green: 0.55, blue: 0.75),
        magenta: Color(red: 0.70, green: 0.45, blue: 0.60),
        cyan: Color(red: 0.40, green: 0.65, blue: 0.70),
        white: Color(red: 0.85, green: 0.87, blue: 0.92),
        brightBlack: Color(red: 0.35, green: 0.38, blue: 0.45),
        brightRed: Color(red: 0.85, green: 0.45, blue: 0.45),
        brightGreen: Color(red: 0.55, green: 0.75, blue: 0.55),
        brightYellow: Color(red: 0.95, green: 0.75, blue: 0.45),
        brightBlue: Color(red: 0.55, green: 0.65, blue: 0.85),
        brightMagenta: Color(red: 0.80, green: 0.55, blue: 0.70),
        brightCyan: Color(red: 0.50, green: 0.75, blue: 0.80),
        brightWhite: Color(red: 0.92, green: 0.93, blue: 0.97)
    )

    // MARK: - Solarized Dark
    static let solarizedDark = TerminalColorScheme(
        background: Color(red: 0.04, green: 0.12, blue: 0.16),
        foreground: Color(red: 0.71, green: 0.78, blue: 0.75),
        cursor: Color(red: 0.71, green: 0.78, blue: 0.75),
        selection: Color(red: 0.10, green: 0.18, blue: 0.22),
        black: Color(red: 0.04, green: 0.12, blue: 0.16),
        red: Color(red: 0.86, green: 0.20, blue: 0.18),
        green: Color(red: 0.52, green: 0.60, blue: 0.00),
        yellow: Color(red: 0.71, green: 0.54, blue: 0.00),
        blue: Color(red: 0.15, green: 0.44, blue: 0.61),
        magenta: Color(red: 0.65, green: 0.15, blue: 0.44),
        cyan: Color(red: 0.00, green: 0.51, blue: 0.53),
        white: Color(red: 0.71, green: 0.78, blue: 0.75),
        brightBlack: Color(red: 0.34, green: 0.41, blue: 0.39),
        brightRed: Color(red: 0.93, green: 0.28, blue: 0.25),
        brightGreen: Color(red: 0.60, green: 0.68, blue: 0.10),
        brightYellow: Color(red: 0.79, green: 0.62, blue: 0.10),
        brightBlue: Color(red: 0.25, green: 0.52, blue: 0.69),
        brightMagenta: Color(red: 0.73, green: 0.25, blue: 0.52),
        brightCyan: Color(red: 0.10, green: 0.59, blue: 0.61),
        brightWhite: Color(red: 0.93, green: 0.96, blue: 0.93)
    )

    // MARK: - Solarized Light
    static let solarizedLight = TerminalColorScheme(
        background: Color(red: 1.00, green: 0.99, blue: 0.94),
        foreground: Color(red: 0.16, green: 0.14, blue: 0.10),
        cursor: Color(red: 0.16, green: 0.14, blue: 0.10),
        selection: Color(red: 0.83, green: 0.82, blue: 0.78),
        black: Color(red: 0.16, green: 0.14, blue: 0.10),
        red: Color(red: 0.86, green: 0.20, blue: 0.18),
        green: Color(red: 0.52, green: 0.60, blue: 0.00),
        yellow: Color(red: 0.71, green: 0.54, blue: 0.00),
        blue: Color(red: 0.15, green: 0.44, blue: 0.61),
        magenta: Color(red: 0.65, green: 0.15, blue: 0.44),
        cyan: Color(red: 0.00, green: 0.51, blue: 0.53),
        white: Color(red: 0.16, green: 0.14, blue: 0.10),
        brightBlack: Color(red: 0.50, green: 0.52, blue: 0.47),
        brightRed: Color(red: 0.78, green: 0.12, blue: 0.10),
        brightGreen: Color(red: 0.42, green: 0.50, blue: 0.00),
        brightYellow: Color(red: 0.61, green: 0.44, blue: 0.00),
        brightBlue: Color(red: 0.05, green: 0.34, blue: 0.51),
        brightMagenta: Color(red: 0.55, green: 0.05, blue: 0.34),
        brightCyan: Color(red: 0.00, green: 0.41, blue: 0.43),
        brightWhite: Color(red: 0.98, green: 0.97, blue: 0.92)
    )

    // MARK: - Tokyo Night
    static let tokyoNight = TerminalColorScheme(
        background: Color(red: 0.09, green: 0.11, blue: 0.16),
        foreground: Color(red: 0.84, green: 0.87, blue: 0.94),
        cursor: Color(red: 0.84, green: 0.87, blue: 0.94),
        selection: Color(red: 0.20, green: 0.23, blue: 0.30),
        black: Color(red: 0.09, green: 0.11, blue: 0.16),
        red: Color(red: 0.95, green: 0.35, blue: 0.42),
        green: Color(red: 0.40, green: 0.75, blue: 0.45),
        yellow: Color(red: 0.95, green: 0.75, blue: 0.35),
        blue: Color(red: 0.50, green: 0.60, blue: 0.90),
        magenta: Color(red: 0.85, green: 0.45, blue: 0.70),
        cyan: Color(red: 0.40, green: 0.75, blue: 0.75),
        white: Color(red: 0.84, green: 0.87, blue: 0.94),
        brightBlack: Color(red: 0.35, green: 0.38, blue: 0.45),
        brightRed: Color(red: 1.00, green: 0.45, blue: 0.52),
        brightGreen: Color(red: 0.50, green: 0.85, blue: 0.55),
        brightYellow: Color(red: 1.00, green: 0.80, blue: 0.45),
        brightBlue: Color(red: 0.60, green: 0.70, blue: 0.95),
        brightMagenta: Color(red: 0.90, green: 0.55, blue: 0.80),
        brightCyan: Color(red: 0.50, green: 0.85, blue: 0.85),
        brightWhite: Color(red: 0.95, green: 0.95, blue: 1.00)
    )

    // MARK: - One Dark
    static let oneDark = TerminalColorScheme(
        background: Color(red: 0.11, green: 0.12, blue: 0.14),
        foreground: Color(red: 0.83, green: 0.84, blue: 0.87),
        cursor: Color(red: 0.83, green: 0.84, blue: 0.87),
        selection: Color(red: 0.24, green: 0.26, blue: 0.31),
        black: Color(red: 0.11, green: 0.12, blue: 0.14),
        red: Color(red: 0.91, green: 0.32, blue: 0.32),
        green: Color(red: 0.45, green: 0.75, blue: 0.39),
        yellow: Color(red: 0.98, green: 0.75, blue: 0.35),
        blue: Color(red: 0.45, green: 0.57, blue: 0.85),
        magenta: Color(red: 0.79, green: 0.40, blue: 0.65),
        cyan: Color(red: 0.35, green: 0.70, blue: 0.70),
        white: Color(red: 0.83, green: 0.84, blue: 0.87),
        brightBlack: Color(red: 0.40, green: 0.42, blue: 0.48),
        brightRed: Color(red: 0.96, green: 0.42, blue: 0.42),
        brightGreen: Color(red: 0.55, green: 0.85, blue: 0.50),
        brightYellow: Color(red: 1.00, green: 0.82, blue: 0.45),
        brightBlue: Color(red: 0.55, green: 0.67, blue: 0.95),
        brightMagenta: Color(red: 0.89, green: 0.50, blue: 0.75),
        brightCyan: Color(red: 0.50, green: 0.80, blue: 0.80),
        brightWhite: Color(red: 0.93, green: 0.93, blue: 0.97)
    )

    // MARK: - One Light
    static let oneLight = TerminalColorScheme(
        background: Color(red: 0.98, green: 0.98, blue: 0.98),
        foreground: Color(red: 0.15, green: 0.16, blue: 0.18),
        cursor: Color(red: 0.15, green: 0.16, blue: 0.18),
        selection: Color(red: 0.90, green: 0.90, blue: 0.92),
        black: Color(red: 0.15, green: 0.16, blue: 0.18),
        red: Color(red: 0.80, green: 0.15, blue: 0.15),
        green: Color(red: 0.30, green: 0.55, blue: 0.20),
        yellow: Color(red: 0.75, green: 0.50, blue: 0.10),
        blue: Color(red: 0.20, green: 0.35, blue: 0.65),
        magenta: Color(red: 0.60, green: 0.20, blue: 0.50),
        cyan: Color(red: 0.15, green: 0.50, blue: 0.50),
        white: Color(red: 0.15, green: 0.16, blue: 0.18),
        brightBlack: Color(red: 0.60, green: 0.62, blue: 0.65),
        brightRed: Color(red: 0.90, green: 0.25, blue: 0.25),
        brightGreen: Color(red: 0.40, green: 0.65, blue: 0.30),
        brightYellow: Color(red: 0.85, green: 0.60, blue: 0.20),
        brightBlue: Color(red: 0.30, green: 0.45, blue: 0.75),
        brightMagenta: Color(red: 0.70, green: 0.30, blue: 0.60),
        brightCyan: Color(red: 0.25, green: 0.60, blue: 0.60),
        brightWhite: Color(red: 0.10, green: 0.11, blue: 0.13)
    )

    // MARK: - Monokai Pro
    static let monokaiPro = TerminalColorScheme(
        background: Color(red: 0.14, green: 0.14, blue: 0.16),
        foreground: Color(red: 0.92, green: 0.92, blue: 0.94),
        cursor: Color(red: 0.92, green: 0.92, blue: 0.94),
        selection: Color(red: 0.28, green: 0.28, blue: 0.32),
        black: Color(red: 0.14, green: 0.14, blue: 0.16),
        red: Color(red: 0.95, green: 0.30, blue: 0.30),
        green: Color(red: 0.40, green: 0.80, blue: 0.35),
        yellow: Color(red: 1.00, green: 0.80, blue: 0.30),
        blue: Color(red: 0.50, green: 0.55, blue: 0.90),
        magenta: Color(red: 0.90, green: 0.35, blue: 0.70),
        cyan: Color(red: 0.35, green: 0.80, blue: 0.75),
        white: Color(red: 0.92, green: 0.92, blue: 0.94),
        brightBlack: Color(red: 0.42, green: 0.42, blue: 0.48),
        brightRed: Color(red: 1.00, green: 0.42, blue: 0.42),
        brightGreen: Color(red: 0.52, green: 0.88, blue: 0.48),
        brightYellow: Color(red: 1.00, green: 0.88, blue: 0.42),
        brightBlue: Color(red: 0.62, green: 0.68, blue: 0.95),
        brightMagenta: Color(red: 0.95, green: 0.48, blue: 0.80),
        brightCyan: Color(red: 0.48, green: 0.88, blue: 0.82),
        brightWhite: Color(red: 0.97, green: 0.97, blue: 1.00)
    )

    // MARK: - GitHub Dark
    static let githubDark = TerminalColorScheme(
        background: Color(red: 0.10, green: 0.10, blue: 0.12),
        foreground: Color(red: 0.88, green: 0.90, blue: 0.94),
        cursor: Color(red: 0.88, green: 0.90, blue: 0.94),
        selection: Color(red: 0.20, green: 0.22, blue: 0.28),
        black: Color(red: 0.10, green: 0.10, blue: 0.12),
        red: Color(red: 0.95, green: 0.35, blue: 0.35),
        green: Color(red: 0.35, green: 0.75, blue: 0.40),
        yellow: Color(red: 0.95, green: 0.75, blue: 0.30),
        blue: Color(red: 0.40, green: 0.55, blue: 0.90),
        magenta: Color(red: 0.85, green: 0.40, blue: 0.65),
        cyan: Color(red: 0.35, green: 0.75, blue: 0.75),
        white: Color(red: 0.88, green: 0.90, blue: 0.94),
        brightBlack: Color(red: 0.40, green: 0.42, blue: 0.48),
        brightRed: Color(red: 1.00, green: 0.45, blue: 0.45),
        brightGreen: Color(red: 0.45, green: 0.85, blue: 0.50),
        brightYellow: Color(red: 1.00, green: 0.82, blue: 0.42),
        brightBlue: Color(red: 0.55, green: 0.65, blue: 0.95),
        brightMagenta: Color(red: 0.92, green: 0.52, blue: 0.75),
        brightCyan: Color(red: 0.48, green: 0.85, blue: 0.82),
        brightWhite: Color(red: 0.95, green: 0.95, blue: 1.00)
    )

    // MARK: - GitHub Light
    static let githubLight = TerminalColorScheme(
        background: Color(red: 1.00, green: 1.00, blue: 1.00),
        foreground: Color(red: 0.15, green: 0.16, blue: 0.18),
        cursor: Color(red: 0.15, green: 0.16, blue: 0.18),
        selection: Color(red: 0.88, green: 0.90, blue: 0.94),
        black: Color(red: 0.15, green: 0.16, blue: 0.18),
        red: Color(red: 0.82, green: 0.15, blue: 0.15),
        green: Color(red: 0.15, green: 0.55, blue: 0.15),
        yellow: Color(red: 0.70, green: 0.50, blue: 0.05),
        blue: Color(red: 0.10, green: 0.30, blue: 0.65),
        magenta: Color(red: 0.60, green: 0.15, blue: 0.45),
        cyan: Color(red: 0.10, green: 0.50, blue: 0.50),
        white: Color(red: 0.15, green: 0.16, blue: 0.18),
        brightBlack: Color(red: 0.55, green: 0.58, blue: 0.62),
        brightRed: Color(red: 0.92, green: 0.25, blue: 0.25),
        brightGreen: Color(red: 0.25, green: 0.65, blue: 0.25),
        brightYellow: Color(red: 0.80, green: 0.60, blue: 0.15),
        brightBlue: Color(red: 0.20, green: 0.40, blue: 0.75),
        brightMagenta: Color(red: 0.70, green: 0.25, blue: 0.55),
        brightCyan: Color(red: 0.20, green: 0.60, blue: 0.60),
        brightWhite: Color(red: 0.10, green: 0.11, blue: 0.13)
    )
}
