import SwiftUI

struct ThemeManager {
    static let availableThemes: [String] = [
        "Catppuccin Mocha",
        "Catppuccin Latte",
        "Catppuccin Frappe",
        "Catppuccin Macchiato",
        "Dracula",
        "Gruvbox Dark",
        "Gruvbox Light",
        "Nord",
        "Solarized Dark",
        "Solarized Light",
        "Tokyo Night",
        "One Dark",
        "One Light",
        "Monokai Pro",
        "GitHub Dark",
        "GitHub Light",
    ]

    static let darkThemes: Set<String> = [
        "Catppuccin Mocha",
        "Catppuccin Frappe",
        "Catppuccin Macchiato",
        "Dracula",
        "Gruvbox Dark",
        "Nord",
        "Solarized Dark",
        "Tokyo Night",
        "One Dark",
        "Monokai Pro",
        "GitHub Dark",
    ]

    static let lightThemes: Set<String> = [
        "Catppuccin Latte",
        "Gruvbox Light",
        "Solarized Light",
        "One Light",
        "GitHub Light",
    ]

    static func isDarkTheme(_ themeName: String) -> Bool {
        darkThemes.contains(themeName)
    }

    static func colorScheme(for themeName: String) -> ColorScheme {
        isDarkTheme(themeName) ? .dark : .light
    }

    static func color(for themeName: String, role: ColorRole) -> Color {
        let scheme = TerminalColorScheme.from(themeName: themeName)
        switch role {
        case .background: return scheme.background
        case .foreground: return scheme.foreground
        case .cursor: return scheme.cursor
        case .selection: return scheme.selection
        case .black: return scheme.black
        case .red: return scheme.red
        case .green: return scheme.green
        case .yellow: return scheme.yellow
        case .blue: return scheme.blue
        case .magenta: return scheme.magenta
        case .cyan: return scheme.cyan
        case .white: return scheme.white
        case .brightBlack: return scheme.brightBlack
        case .brightRed: return scheme.brightRed
        case .brightGreen: return scheme.brightGreen
        case .brightYellow: return scheme.brightYellow
        case .brightBlue: return scheme.brightBlue
        case .brightMagenta: return scheme.brightMagenta
        case .brightCyan: return scheme.brightCyan
        case .brightWhite: return scheme.brightWhite
        }
    }
}

enum ColorRole {
    case background, foreground, cursor, selection
    case black, red, green, yellow, blue, magenta, cyan, white
    case brightBlack, brightRed, brightGreen, brightYellow
    case brightBlue, brightMagenta, brightCyan, brightWhite
}
