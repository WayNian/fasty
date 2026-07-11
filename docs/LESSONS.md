# Fasty 踩坑文档

记录开发过程中遇到的问题和解决方案，避免重复踩坑。

## 1. GhosttyTerminal 主题背景色不生效

### 问题
切换主题后，终端背景色没有变化。

### 原因
使用了 `setTerminalConfiguration()` 而不是 `setTheme()`。

### 解决
```swift
// ❌ 错误：setTerminalConfiguration 是 per-session 覆盖
terminalState.controller.setTerminalConfiguration(config)

// ✅ 正确：setTheme 是正式的主题 API
let terminalTheme = TerminalTheme(light: config, dark: config)
terminalState.controller.setTheme(terminalTheme)
```

---

## 2. macOS 标题栏背景色不跟随 window.backgroundColor 更新

### 问题
使用 `titlebarAppearsTransparent = true` 后，动态修改 `window.backgroundColor` 不会更新标题栏颜色。

### 原因
macOS 的标题栏是系统渲染的，`window.backgroundColor` 变更后不会立即触发标题栏重绘。这是已知的系统行为。

### 尝试过（均无效）
1. `window.backgroundColor = newColor` — 不重绘
2. `window.titlebarAppearsTransparent = false` 再 `true` — 不重绘
3. `window.superview?.needsDisplay = true` — 编译错误，NSWindow 没有 superview

### 解决
使用 `.windowStyle(.hiddenTitleBar)`，让 SwiftUI 背景色延伸到整个窗口：
```swift
.windowStyle(.hiddenTitleBar)
// 配合
window.isMovableByWindowBackground = true  // 窗口拖拽
```

这样切换主题时，SwiftUI 的 `@State` 背景色立即更新，不依赖 `window.backgroundColor`。

---

## 3. 中文输入法 Command+Delete 不取消预选

### 问题
中文输入法预选状态下，按 Command+Delete 会删除整行，而不是取消预选。

### 原因
1. `interpretKeyEvents` 收到的事件经过 Ghostty 的修饰符转换，Command 修饰符被移除
2. 输入法收到的事件没有 Command 修饰符，无法识别为 Command+Delete
3. 输入法将 Delete 键解释为普通删除，而不是取消预选

### 解决
在 `TerminalKeyEventHandler@AppKit.swift` 的 `handleKeyDown` 中，当有输入法预选时，传递原始事件（保留 Command 修饰符）：

```swift
let isCmdDelete = event.modifierFlags.contains(.command) && event.keyCode == 51
if isCmdDelete && inputMethodHandler?.hasMarkedText == true {
    // 使用原始 event，不是 translationEvent
    view.interpretKeyEvents([event])
    if inputMethodHandler?.hasMarkedText == true {
        inputMethodHandler?.unmarkText()  // 后备
    }
    return
}
```

### 关键点
- `translationEvent` 会移除 Command 修饰符（Ghostty 的 key translation）
- `event` 保留原始修饰符，输入法能正确识别

---

## 4. Swift Package Manager 中 .lproj 文件不生效

### 问题
创建 `Resources/zh.lproj/Localizable.strings` 和 `en.lproj/Localizable.strings`，但 `NSLocalizedString` 找不到翻译。

### 原因
SPM 项目的 `.lproj` 文件不会自动打包到 Bundle 中。

### 解决
使用内存字典存储翻译，不依赖 NSBundle：
```swift
private let translations: [AppLanguage: [String: String]] = [
    .chinese: ["settings.general": "通用", ...],
    .english: ["settings.general": "General", ...]
]
```

---

## 5. #Preview 宏在 SPM 项目中不工作

### 问题
`#Preview { ... }` 编译报错：`external macro implementation type could not be found`

### 原因
Swift 5.9 的 `#Preview` 宏需要 Xcode 的预览插件，SPM 项目没有。

### 解决
移除 `#Preview` 代码块，使用 Xcode 的预览功能替代。

---

## 6. SettingsViewModel.init() 中触发 didSet

### 问题
在 `SettingsViewModel.init()` 中调用 `loadSettings()` 设置 `themeName`，触发 `didSet`，可能在 SwiftUI 视图渲染前导致问题。

### 原因
`@Published var themeName` 的 `didSet` 会调用 `objectWillChange.send()`，但 `@StateObject` 初始化时视图还未渲染。

### 解决
确保 `loadSettings()` 中的赋值顺序正确，避免在 `init()` 中触发不必要的副作用。或者在 `didSet` 中检查 `oldValue`。

---

## 7. NSInputContext.abandonMarkedText() 不存在

### 问题
尝试调用 `NSInputContext.current?.abandonMarkedText()` 强制退出输入法组合模式。

### 原因
`abandonMarkedText()` 不是公开 API。

### 解决
使用 `NSTextInputClient.unmarkText()` 取消预选，配合发送 ESC 键事件。

---

## 8. 窗口背景色与视图背景色不同步

### 问题
打开应用时，标题栏颜色正确，但主区域是黑色；或者反过来。

### 原因
`window.backgroundColor`（标题栏）和 SwiftUI 视图背景是两个独立的系统，需要分别设置和同步。

### 解决
统一在 TerminalView 中管理：
```swift
.onAppear {
    applyTheme(settings.themeName)  // 启动时同步
}
.onReceive(settings.objectWillChange) { _ in
    applyTheme(settings.themeName)  // 设置变化时同步
}
```

使用 `onReceive` 而不是 `onChange`，因为 `onChange` 在设置面板和主窗口之间可能不触发。

---

## 9. GhosttyTerminal #Preview 不工作

### 问题
在 GhosttyTerminal 的 Swift 文件中使用 `#Preview` 编译失败。

### 原因
GhosttyTerminal 使用 Swift 6.0，但 `#Preview` 宏需要 Xcode 插件。

### 解决
移除 `#Preview` 代码块。

---

## 10. Package.swift 本地依赖路径

### 问题
需要修改 GhosttyTerminal 源码，但它是远程依赖。

### 解决
1. Fork 仓库到自己的 GitHub
2. Clone 到本地
3. 修改 Package.swift 使用本地路径：
```swift
.package(path: "../libghostty-spm")
```

4. 修改后需要清理构建缓存：`rm -rf .build && swift build`
