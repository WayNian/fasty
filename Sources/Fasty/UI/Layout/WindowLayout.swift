import SwiftUI

struct WindowLayout {
    static let defaultWidth: CGFloat = 900
    static let defaultHeight: CGFloat = 600
    static let minWidth: CGFloat = 600
    static let minHeight: CGFloat = 400

    static func defaultFrame() -> CGRect {
        CGRect(
            x: (NSScreen.main?.frame.width ?? 1440) / 2 - defaultWidth / 2,
            y: (NSScreen.main?.frame.height ?? 900) / 2 - defaultHeight / 2,
            width: defaultWidth,
            height: defaultHeight
        )
    }
}
