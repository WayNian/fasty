# Fasty — macOS 终端应用技术方案

## 1. 项目概述

### 1.1 定位

Fasty 是一个基于 Swift + SwiftUI + GhosttyKit 构建的 macOS 原生终端应用，面向开发者日常终端使用场景。以 UI 定制和布局为核心差异化，兼容 Ghostty 配置格式。

### 1.2 技术选型

| 维度 | 选择 | 理由 |
|------|------|------|
| 语言 | Swift 5.9+ | 原生 macOS 开发语言，类型安全，现代并发模型 |
| UI 框架 | SwiftUI 为主 + AppKit 补充 | SwiftUI 简化视图层，AppKit 处理原生窗口/菜单/全局快捷键 |
| 终端引擎 | GhosttyKit (via `Lakr233/libghostty-spm`) | 提供完整的 VT 解析、Metal 渲染、CoreText 字体系统 |
| 最低系统 | macOS 14 (Sonoma) | SwiftUI 功能成熟，GhosttyKit 兼容 |
| 构建系统 | Swift Package Manager | 跨 IDE，CI 友好，依赖管理简单 |

### 1.3 架构分层

```
┌─────────────────────────────────────────────────────┐
│                  Presentation Layer                 │
│         SwiftUI Views + AppKit Window               │
├─────────────────────────────────────────────────────┤
│                  ViewModel Layer                    │
│    TerminalViewModel + SettingsViewModel            │
├─────────────────────────────────────────────────────┤
│                 Integration Layer                   │
│   GhosttyTerminal + PTYSession + ConfigBridge       │
├─────────────────────────────────────────────────────┤
│                  Engine Layer                       │
│   GhosttyKit (VT Parser + Metal Renderer)           │
├─────────────────────────────────────────────────────┤
│                  System Layer                       │
│   POSIX PTY + CoreText + Metal API                  │
└─────────────────────────────────────────────────────┘
```

## 2. 项目结构

```
fasty/
├── Package.swift
├── PLAN.md
├── Sources/
│   └── Fasty/
│       ├── App/
│       │   ├── FastyApp.swift
│       │   └── AppDelegate.swift
│       ├── Terminal/
│       │   ├── TerminalViewModel.swift
│       │   ├── TerminalView.swift
│       │   └── PTYSession.swift
│       ├── Settings/
│       │   ├── SettingsView.swift
│       │   ├── SettingsViewModel.swift
│       │   └── GhosttyConfigBridge.swift
│       ├── UI/
│       │   ├── Theme/
│       │   │   ├── ThemeManager.swift
│       │   │   └── ColorScheme.swift
│       │   └── Layout/
│       │       └── WindowLayout.swift
│       └── Helpers/
│           ├── ClipboardManager.swift
│           └── KeyboardHelper.swift
├── Resources/
│   ├── Info.plist
│   └── Assets.xcassets/
└── Tests/
    └── FastyTests/
```

## 3. 核心模块设计

### 3.1 应用入口

**FastyApp.swift** — SwiftUI App 入口

```swift
import SwiftUI
import GhosttyTerminal

@main
struct FastyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var settings = SettingsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
        .commands {
            CommandGroup(replacing: .newItem) { }
        }

        Settings {
            SettingsView()
                .environmentObject(settings)
        }
    }
}
```

**AppDelegate.swift** — AppKit 桥接层

```swift
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // 注册全局快捷键
        // 设置应用菜单
        // 恢复上次窗口状态
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // 确认退出（如有活动进程）
        return .terminateNow
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
```

### 3.2 PTY 会话管理

**PTYSession.swift** — 伪终端核心

```swift
import Foundation

class PTYSession: ObservableObject {
    @Published var isRunning = false

    private var masterFd: Int32 = -1
    private var childPid: pid_t = -1
    private var readSource: DispatchSourceRead?

    let id = UUID()
    let shell: String

    var onOutput: ((Data) -> Void)?
    var onExit: ((Int32) -> Void)?

    init(shell: String = ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/zsh") {
        self.shell = shell
    }

    func start(cols: UInt32, rows: UInt32) {
        var master: Int32 = 0
        var slave: Int32 = 0

        guard openpty(&master, &slave, nil, nil, nil) == 0 else { return }
        self.masterFd = master

        var winsize = winsize(ws_row: UInt16(rows), ws_col: UInt16(cols))
        ioctl(slave, UInt(TIOCSWINSZ), &winsize)

        childPid = fork()

        if childPid == 0 {
            setsid()
            dup2(slave, STDIN_FILENO)
            dup2(slave, STDOUT_FILENO)
            dup2(slave, STDERR_FILENO)
            close(slave)
            close(master)
            let shellPath = (shell as NSString).utf8String
            execl(shellPath, shellPath, nil)
            _exit(1)
        }

        close(slave)
        DispatchQueue.main.async { self.isRunning = true }

        let readQueue = DispatchQueue(label: "com.fasty.pty.\(id.uuidString)")
        readSource = DispatchSource.makeReadSource(fileDescriptor: master, queue: readQueue)
        readSource?.setEventHandler { [weak self] in
            var buffer = [UInt8](repeating: 0, count: 65536)
            let bytesRead = read(master, &buffer, buffer.count)
            if bytesRead > 0 {
                self?.onOutput?(Data(bytes: buffer, count: bytesRead))
            }
        }
        readSource?.setCancelHandler { [weak self] in
            close(master)
            self?.onExit?(0)
        }
        readSource?.resume()
    }

    func write(_ data: Data) {
        data.withUnsafeBytes { ptr in
            _ = write(masterFd, ptr.baseAddress!, data.count)
        }
    }

    func resize(cols: UInt32, rows: UInt32) {
        var winsize = winsize(ws_row: UInt16(rows), ws_col: UInt16(cols))
        ioctl(masterFd, UInt(TIOCSWINSZ), &winsize)
    }

    func terminate() {
        if childPid > 0 { kill(childPid, SIGTERM) }
        readSource?.cancel()
    }
}
```

### 3.3 终端视图

**TerminalView.swift** — SwiftUI 终端视图

```swift
import SwiftUI
import GhosttyTerminal

struct TerminalView: View {
    @StateObject private var viewModel: TerminalViewModel

    init(session: PTYSession) {
        _viewModel = StateObject(wrappedValue: TerminalViewModel(session: session))
    }

    var body: some View {
        ZStack {
            if viewModel.isReady {
                TerminalSurfaceView(context: viewModel.terminalState)
                    .navigationTitle(viewModel.title)
            } else {
                ProgressView("Loading terminal...")
            }
        }
        .onAppear { viewModel.setup() }
    }
}
```

**TerminalViewModel.swift** — 终端状态管理

```swift
import SwiftUI
import GhosttyTerminal

class TerminalViewModel: ObservableObject {
    @Published var title = "Fasty"
    @Published var isReady = false

    let terminalState = TerminalViewState()
    let session: PTYSession

    private var inMemorySession: InMemoryTerminalSession!

    init(session: PTYSession) { self.session = session }

    func setup() {
        inMemorySession = InMemoryTerminalSession(
            write: { [weak self] data in self?.session.write(data) },
            resize: { [weak self] viewport in
                self?.session.resize(cols: viewport.cols, rows: viewport.rows)
            }
        )
        terminalState.configuration = TerminalSurfaceOptions(
            backend: .inMemory(inMemorySession)
        )
        session.onOutput = { [weak self] data in
            self?.inMemorySession.receive(data)
        }
        session.start(cols: 80, rows: 24)
        DispatchQueue.main.async { self.isReady = true }
    }
}
```

### 3.4 设置面板

| Tab | 内容 |
|-----|------|
| General | 默认 shell、工作目录、启动行为、窗口恢复 |
| Appearance | 主题选择、字体族/大小、透明度、光标样式、窗口装饰 |
| Keybindings | 快捷键自定义（支持 Ghostty 格式） |
| Advanced | Ghostty 配置文件路径、日志级别、实验性功能开关 |

### 3.5 Ghostty 配置兼容层

**配置文件路径**：
- Ghostty: `~/.config/ghostty/config`
- Fasty: `~/.config/fasty/config`（兼容 Ghostty 格式）

## 4. 数据流

```
PTY stdout → onOutput → inMemorySession.receive() → Ghostty 渲染
Ghostty input → write closure → session.write() → PTY stdin → shell
```

## 5. MVP 实施计划

| Phase | 任务 | 产出 |
|-------|------|------|
| 1 | 项目初始化 + 依赖引入 | Package.swift + 编译通过 |
| 2 | PTY 会话管理 | 可运行 shell 进程 |
| 3 | Ghostty 终端视图集成 | 可渲染的终端界面 |
| 4 | 键盘/鼠标输入处理 | 完整的交互循环 |
| 5 | 窗口管理 + 菜单 | macOS 原生窗口体验 |
| 6 | 设置面板基础版 | 可配置终端外观 |
| 7 | 主题系统 | 内建配色方案 |

## 6. 风险与应对

| 风险 | 影响 | 应对 |
|------|------|------|
| GhosttyKit API 不稳定 | 上游变更导致编译失败 | 锁定 SPM 版本 + 适配层封装 |
| PTY 线程安全 | 数据竞争导致崩溃 | 严格主线程调度 + actor 隔离 |
| Metal 渲染性能 | 低端 Mac 表现差 | 配置开关降级到软件渲染 |
| 配置兼容性 | Ghostty 配置无法正确解析 | 渐进支持 + 完善测试 |
