import AppKit

struct ClipboardManager {
    static func copyToClipboard(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
    }

    static func pasteFromClipboard() -> String? {
        let pasteboard = NSPasteboard.general
        return pasteboard.string(forType: .string)
    }

    static func clearClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
    }
}
