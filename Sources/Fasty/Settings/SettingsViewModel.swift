import SwiftUI

enum CursorStyle: String, CaseIterable {
    case block, beam, underline
}

enum LogLevel: String, CaseIterable {
    case error, warning, info, debug
}

class SettingsViewModel: ObservableObject {
    // General
    @Published var defaultShell: String = ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/zsh"
    @Published var workingDirectory: String = "~"
    @Published var restoreSession: Bool = true
    @Published var restoreWindowState: Bool = true
    @Published var openOnFocusLoss: Bool = false

    // Appearance
    @Published var themeName: String = "Catppuccin Mocha" {
        didSet {
            if themeName != oldValue {
                objectWillChange.send()
                NotificationCenter.default.post(name: .themeDidChange, object: nil, userInfo: ["theme": themeName])
                saveSettings()
            }
        }
    }
    @Published var fontFamily: String = "Menlo"
    @Published var fontSize: Double = 13
    @Published var translucentBackground: Bool = false
    @Published var backgroundOpacity: Double = 0.9
    @Published var cursorStyle: CursorStyle = .block

    // Keybindings
    @Published var quickTerminalEnabled: Bool = false

    // Advanced
    @Published var configPath: String = "~/.config/fasty/config"
    @Published var logLevel: LogLevel = .info

    // Language
    @Published var appLanguage: AppLanguage = .chinese {
        didSet {
            if appLanguage != oldValue {
                LocalizableManager.shared.setLanguage(appLanguage)
                objectWillChange.send()
                saveSettings()
            }
        }
    }

    private let userDefaults = UserDefaults.standard

    var currentColorScheme: TerminalColorScheme {
        TerminalColorScheme.from(themeName: themeName)
    }

    init() {
        loadSettings()
    }

    func loadSettings() {
        defaultShell = userDefaults.string(forKey: "defaultShell") ?? defaultShell
        workingDirectory = userDefaults.string(forKey: "workingDirectory") ?? workingDirectory
        restoreSession = userDefaults.bool(forKey: "restoreSession")
        restoreWindowState = userDefaults.bool(forKey: "restoreWindowState")
        themeName = userDefaults.string(forKey: "themeName") ?? themeName
        fontFamily = userDefaults.string(forKey: "fontFamily") ?? fontFamily
        fontSize = userDefaults.double(forKey: "fontSize") != 0 ? userDefaults.double(forKey: "fontSize") : fontSize
        translucentBackground = userDefaults.bool(forKey: "translucentBackground")
        backgroundOpacity = userDefaults.double(forKey: "backgroundOpacity") != 0 ? userDefaults.double(forKey: "backgroundOpacity") : backgroundOpacity
        configPath = userDefaults.string(forKey: "configPath") ?? configPath

        // Load language
        if let langRaw = userDefaults.string(forKey: "appLanguage"),
           let lang = AppLanguage(rawValue: langRaw) {
            appLanguage = lang
            LocalizableManager.shared.setLanguage(lang)
        }
    }

    func saveSettings() {
        userDefaults.set(defaultShell, forKey: "defaultShell")
        userDefaults.set(workingDirectory, forKey: "workingDirectory")
        userDefaults.set(restoreSession, forKey: "restoreSession")
        userDefaults.set(restoreWindowState, forKey: "restoreWindowState")
        userDefaults.set(themeName, forKey: "themeName")
        userDefaults.set(fontFamily, forKey: "fontFamily")
        userDefaults.set(fontSize, forKey: "fontSize")
        userDefaults.set(translucentBackground, forKey: "translucentBackground")
        userDefaults.set(backgroundOpacity, forKey: "backgroundOpacity")
        userDefaults.set(configPath, forKey: "configPath")
        userDefaults.set(appLanguage.rawValue, forKey: "appLanguage")
    }

    func loadGhosttyConfig() {
        let expandedPath = NSString(string: configPath).expandingTildeInPath
        let config = GhosttyConfigBridge.parse(from: expandedPath)
        applyGhosttyConfig(config)
    }

    func openConfigFile() {
        let expandedPath = NSString(string: configPath).expandingTildeInPath
        if let url = URL(string: "file://\(expandedPath)") {
            NSWorkspace.shared.open(url)
        }
    }

    private func applyGhosttyConfig(_ config: [String: String]) {
        if let font = config["font-family"] {
            fontFamily = font
        }
        if let size = config["font-size"], let sizeVal = Double(size) {
            fontSize = sizeVal
        }
        if let theme = config["theme"] {
            themeName = theme
        }
    }
}
