# Fasty — Agent Guide

macOS terminal app: Swift 5.9 + SwiftUI + GhosttyKit (Metal renderer). Targets macOS 14+.

## Prerequisites

- Local fork of libghostty-spm at `../libghostty-spm` (relative to project root). Package.swift uses `.package(path: "../libghostty-spm")`. Without this, build fails.
- The fork contains an IME fix in `TerminalKeyEventHandler@AppKit.swift` — do not revert it.

## Build & Run

```bash
swift build          # compile
swift run            # launch app
rm -rf .build && swift build  # clean rebuild (required after modifying local libghostty-spm)
```

No test suite exists. No linting configured.

## Project Structure

```
Sources/Fasty/
├── App/          FastyApp.swift (entry), AppDelegate.swift (NSWindow config)
├── Terminal/     TerminalView, TerminalViewModel, PTYSession
├── Settings/     SettingsView (4 tabs), SettingsViewModel, GhosttyConfigBridge
├── UI/Theme/     ThemeManager, ColorScheme (16 themes), ThemePreview
├── Helpers/      LocalizableManager, ClipboardManager, KeyboardHelper
└── UI/Layout/    WindowLayout

docs/
├── PLAN.md       Technical spec
└── LESSONS.md    Pitfalls and solutions (read this first)
```

## Key Conventions

- **No auto-commit.** Only commit when user explicitly asks.
- **No `#Preview` macros** — SPM projects don't support them.
- **No `.lproj` localization** — SPM doesn't bundle them. Use dictionary-based translations in `LocalizableManager.swift`.
- **Theme changes** must use `controller.setTheme()` (not `setTerminalConfiguration()`). See LESSONS.md #1.
- **Window style** is `.windowStyle(.hiddenTitleBar)` + `isMovableByWindowBackground = true`. Do NOT use `titlebarAppearsTransparent` — macOS won't redraw the title bar on background color changes. See LESSONS.md #2.
- **Theme sync** uses `onReceive(settings.objectWillChange)` not `onChange(of:)` — the latter doesn't fire across Settings/WindowGroup scenes. See LESSONS.md #8.

## Architecture

Presentation (SwiftUI) → ViewModel (TerminalVM + SettingsVM) → Integration (GhosttyTerminal + PTYSession) → Engine (GhosttyKit/Metal) → System (POSIX PTY).

PTY uses `forkpty` via CBridge (`fasty_forkpty`). Ghostty integration uses `InMemoryTerminalSession` + `TerminalSurfaceView`.

## Gotchas

- `SettingsViewModel.init()` calls `loadSettings()` which sets `@Published themeName` — triggers `didSet` before views render. Guard with `oldValue` checks.
- `NSInputContext.abandonMarkedText()` doesn't exist. Use `unmarkText()` on the text input client.
- After modifying libghostty-spm source, always `rm -rf .build` before rebuilding.
