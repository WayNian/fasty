import Foundation

enum AppLanguage: String, CaseIterable {
    case chinese = "zh"
    case english = "en"

    var displayName: String {
        switch self {
        case .chinese: return "中文"
        case .english: return "English"
        }
    }
}

class LocalizableManager: ObservableObject {
    static let shared = LocalizableManager()

    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "appLanguage")
            objectWillChange.send()
        }
    }

    private let translations: [AppLanguage: [String: String]] = [
        .chinese: [
            // 设置 Tab
            "settings.general": "通用",
            "settings.appearance": "外观",
            "settings.keybindings": "快捷键",
            "settings.advanced": "高级",

            // 通用设置
            "general.shell": "Shell",
            "general.shell.default": "默认 Shell",
            "general.shell.workdir": "工作目录",
            "general.shell.restore": "启动时恢复上次会话",
            "general.window": "窗口",
            "general.window.restore": "启动时恢复窗口状态",
            "general.window.focusLoss": "失去焦点时打开新窗口",

            // 外观设置
            "appearance.theme": "主题",
            "appearance.font": "字体",
            "appearance.font.family": "字体族",
            "appearance.font.size": "字体大小",
            "appearance.window": "窗口",
            "appearance.window.translucent": "半透明背景",
            "appearance.window.opacity": "不透明度",
            "appearance.window.cursor": "光标样式",
            "appearance.window.cursor.block": "方块",
            "appearance.window.cursor.beam": "竖线",
            "appearance.window.cursor.underline": "下划线",

            // 快捷键设置
            "keybindings.global": "全局快捷键",
            "keybindings.quickTerminal": "快速终端 (Ctrl+`)",
            "keybindings.custom": "自定义快捷键可在配置文件中设置。",
            "keybindings.ghostty": "Fasty 支持 Ghostty 兼容的快捷键语法。",

            // 高级设置
            "advanced.config": "配置",
            "advanced.config.path": "配置文件路径",
            "advanced.config.load": "加载 Ghostty 配置",
            "advanced.config.open": "打开配置文件",
            "advanced.debug": "调试",
            "advanced.debug.logLevel": "日志级别",
            "advanced.debug.logLevel.error": "错误",
            "advanced.debug.logLevel.warning": "警告",
            "advanced.debug.logLevel.info": "信息",
            "advanced.debug.logLevel.debug": "调试",

            // 语言设置
            "language": "语言",
        ],
        .english: [
            // Settings Tab
            "settings.general": "General",
            "settings.appearance": "Appearance",
            "settings.keybindings": "Keybindings",
            "settings.advanced": "Advanced",

            // General Settings
            "general.shell": "Shell",
            "general.shell.default": "Default Shell",
            "general.shell.workdir": "Working Directory",
            "general.shell.restore": "Restore previous session on launch",
            "general.window": "Window",
            "general.window.restore": "Restore window state on launch",
            "general.window.focusLoss": "Open new window on focus loss",

            // Appearance Settings
            "appearance.theme": "Theme",
            "appearance.font": "Font",
            "appearance.font.family": "Font Family",
            "appearance.font.size": "Font Size",
            "appearance.window": "Window",
            "appearance.window.translucent": "Translucent background",
            "appearance.window.opacity": "Opacity",
            "appearance.window.cursor": "Cursor Style",
            "appearance.window.cursor.block": "Block",
            "appearance.window.cursor.beam": "Beam",
            "appearance.window.cursor.underline": "Underline",

            // Keybindings Settings
            "keybindings.global": "Global Shortcuts",
            "keybindings.quickTerminal": "Quick Terminal (Ctrl+`)",
            "keybindings.custom": "Custom keybindings can be configured in the config file.",
            "keybindings.ghostty": "Fasty supports Ghostty-compatible keybind syntax.",

            // Advanced Settings
            "advanced.config": "Configuration",
            "advanced.config.path": "Config File Path",
            "advanced.config.load": "Load Ghostty Config",
            "advanced.config.open": "Open Config File",
            "advanced.debug": "Debug",
            "advanced.debug.logLevel": "Log Level",
            "advanced.debug.logLevel.error": "Error",
            "advanced.debug.logLevel.warning": "Warning",
            "advanced.debug.logLevel.info": "Info",
            "advanced.debug.logLevel.debug": "Debug",

            // Language Settings
            "language": "Language",
        ]
    ]

    private init() {
        let saved = UserDefaults.standard.string(forKey: "appLanguage") ?? "zh"
        self.currentLanguage = AppLanguage(rawValue: saved) ?? .chinese
    }

    func setLanguage(_ language: AppLanguage) {
        currentLanguage = language
    }

    func localize(_ key: String) -> String {
        translations[currentLanguage]?[key] ?? key
    }
}

func NSLocalizedString(_ key: String) -> String {
    LocalizableManager.shared.localize(key)
}
