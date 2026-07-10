import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem { Label("General", systemImage: "gear") }

            AppearanceSettingsView()
                .tabItem { Label("Appearance", systemImage: "paintbrush") }

            KeybindingSettingsView()
                .tabItem { Label("Keybindings", systemImage: "keyboard") }

            AdvancedSettingsView()
                .tabItem { Label("Advanced", systemImage: "wrench") }
        }
        .frame(width: 500, height: 400)
    }
}

struct GeneralSettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        Form {
            Section("Shell") {
                TextField("Default Shell:", text: $settings.defaultShell)
                    .textFieldStyle(.roundedBorder)

                TextField("Working Directory:", text: $settings.workingDirectory)
                    .textFieldStyle(.roundedBorder)

                Toggle("Restore previous session on launch", isOn: $settings.restoreSession)
            }

            Section("Window") {
                Toggle("Restore window state on launch", isOn: $settings.restoreWindowState)
                Toggle("Open new window on focus loss", isOn: $settings.openOnFocusLoss)
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}

struct AppearanceSettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        VStack(spacing: 0) {
            ThemePreviewGrid(
                themes: ThemeManager.availableThemes,
                selectedTheme: $settings.themeName
            )

            Form {
                Section("Font") {
                    TextField("Font Family:", text: $settings.fontFamily)
                        .textFieldStyle(.roundedBorder)

                    HStack {
                        Text("Font Size:")
                        Slider(value: $settings.fontSize, in: 10...24, step: 1)
                        Text("\(Int(settings.fontSize))")
                            .monospacedDigit()
                            .frame(width: 30)
                    }
                }

                Section("Window") {
                    Toggle("Translucent background", isOn: $settings.translucentBackground)
                    if settings.translucentBackground {
                        HStack {
                            Text("Opacity:")
                            Slider(value: $settings.backgroundOpacity, in: 0.3...1.0, step: 0.05)
                            Text("\(Int(settings.backgroundOpacity * 100))%")
                                .monospacedDigit()
                                .frame(width: 40)
                        }
                    }

                    Picker("Cursor Style:", selection: $settings.cursorStyle) {
                        Text("Block").tag(CursorStyle.block)
                        Text("Beam").tag(CursorStyle.beam)
                        Text("Underline").tag(CursorStyle.underline)
                    }
                }
            }
            .formStyle(.grouped)
            .padding()
        }
    }
}

struct KeybindingSettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        Form {
            Section("Global Shortcuts") {
                Toggle("Quick Terminal (Ctrl+`)", isOn: $settings.quickTerminalEnabled)
            }

            Section("Keybindings") {
                Text("Custom keybindings can be configured in the config file.")
                    .foregroundColor(.secondary)
                Text("Fasty supports Ghostty-compatible keybind syntax.")
                    .foregroundColor(.secondary)
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}

struct AdvancedSettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        Form {
            Section("Configuration") {
                TextField("Config File Path:", text: $settings.configPath)
                    .textFieldStyle(.roundedBorder)

                Button("Load Ghostty Config") {
                    settings.loadGhosttyConfig()
                }

                Button("Open Config File") {
                    settings.openConfigFile()
                }
            }

            Section("Debug") {
                Picker("Log Level:", selection: $settings.logLevel) {
                    Text("Error").tag(LogLevel.error)
                    Text("Warning").tag(LogLevel.warning)
                    Text("Info").tag(LogLevel.info)
                    Text("Debug").tag(LogLevel.debug)
                }
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}
