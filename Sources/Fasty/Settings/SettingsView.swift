import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem { Label(NSLocalizedString("settings.general"), systemImage: "gear") }

            AppearanceSettingsView()
                .tabItem { Label(NSLocalizedString("settings.appearance"), systemImage: "paintbrush") }

            KeybindingSettingsView()
                .tabItem { Label(NSLocalizedString("settings.keybindings"), systemImage: "keyboard") }

            AdvancedSettingsView()
                .tabItem { Label(NSLocalizedString("settings.advanced"), systemImage: "wrench") }
        }
        .frame(width: 500, height: 450)
    }
}

struct GeneralSettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    var body: some View {
        Form {
            Section(NSLocalizedString("language")) {
                Picker("", selection: $settings.appLanguage) {
                    ForEach(AppLanguage.allCases, id: \.self) { lang in
                        Text(lang.displayName).tag(lang)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }

            Section(NSLocalizedString("general.shell")) {
                TextField(NSLocalizedString("general.shell.default") + ":", text: $settings.defaultShell)
                    .textFieldStyle(.roundedBorder)

                TextField(NSLocalizedString("general.shell.workdir") + ":", text: $settings.workingDirectory)
                    .textFieldStyle(.roundedBorder)

                Toggle(NSLocalizedString("general.shell.restore"), isOn: $settings.restoreSession)
            }

            Section(NSLocalizedString("general.window")) {
                Toggle(NSLocalizedString("general.window.restore"), isOn: $settings.restoreWindowState)
                Toggle(NSLocalizedString("general.window.focusLoss"), isOn: $settings.openOnFocusLoss)
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
                Section(NSLocalizedString("appearance.font")) {
                    TextField(NSLocalizedString("appearance.font.family") + ":", text: $settings.fontFamily)
                        .textFieldStyle(.roundedBorder)

                    HStack {
                        Text(NSLocalizedString("appearance.font.size") + ":")
                        Slider(value: $settings.fontSize, in: 10...24, step: 1)
                        Text("\(Int(settings.fontSize))")
                            .monospacedDigit()
                            .frame(width: 30)
                    }
                }

                Section(NSLocalizedString("appearance.window")) {
                    Toggle(NSLocalizedString("appearance.window.translucent"), isOn: $settings.translucentBackground)
                    if settings.translucentBackground {
                        HStack {
                            Text(NSLocalizedString("appearance.window.opacity") + ":")
                            Slider(value: $settings.backgroundOpacity, in: 0.3...1.0, step: 0.05)
                            Text("\(Int(settings.backgroundOpacity * 100))%")
                                .monospacedDigit()
                                .frame(width: 40)
                        }
                    }

                    Picker(NSLocalizedString("appearance.window.cursor") + ":", selection: $settings.cursorStyle) {
                        Text(NSLocalizedString("appearance.window.cursor.block")).tag(CursorStyle.block)
                        Text(NSLocalizedString("appearance.window.cursor.beam")).tag(CursorStyle.beam)
                        Text(NSLocalizedString("appearance.window.cursor.underline")).tag(CursorStyle.underline)
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
            Section(NSLocalizedString("keybindings.global")) {
                Toggle(NSLocalizedString("keybindings.quickTerminal"), isOn: $settings.quickTerminalEnabled)
            }

            Section(NSLocalizedString("settings.keybindings")) {
                Text(NSLocalizedString("keybindings.custom"))
                    .foregroundColor(.secondary)
                Text(NSLocalizedString("keybindings.ghostty"))
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
            Section(NSLocalizedString("advanced.config")) {
                TextField(NSLocalizedString("advanced.config.path") + ":", text: $settings.configPath)
                    .textFieldStyle(.roundedBorder)

                Button(NSLocalizedString("advanced.config.load")) {
                    settings.loadGhosttyConfig()
                }

                Button(NSLocalizedString("advanced.config.open")) {
                    settings.openConfigFile()
                }
            }

            Section(NSLocalizedString("advanced.debug")) {
                Picker(NSLocalizedString("advanced.debug.logLevel") + ":", selection: $settings.logLevel) {
                    Text(NSLocalizedString("advanced.debug.logLevel.error")).tag(LogLevel.error)
                    Text(NSLocalizedString("advanced.debug.logLevel.warning")).tag(LogLevel.warning)
                    Text(NSLocalizedString("advanced.debug.logLevel.info")).tag(LogLevel.info)
                    Text(NSLocalizedString("advanced.debug.logLevel.debug")).tag(LogLevel.debug)
                }
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}
