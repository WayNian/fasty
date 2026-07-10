import AppKit

struct KeyboardHelper {
    static func ghosttyMods(from flags: NSEvent.ModifierFlags) -> UInt32 {
        var mods: UInt32 = 0
        if flags.contains(.shift) { mods |= 1 << 0 }
        if flags.contains(.control) { mods |= 1 << 1 }
        if flags.contains(.option) { mods |= 1 << 2 }
        if flags.contains(.command) { mods |= 1 << 3 }
        return mods
    }

    static func flagsFromGhostty(_ mods: UInt32) -> NSEvent.ModifierFlags {
        var flags: NSEvent.ModifierFlags = []
        if mods & (1 << 0) != 0 { flags.insert(.shift) }
        if mods & (1 << 1) != 0 { flags.insert(.control) }
        if mods & (1 << 2) != 0 { flags.insert(.option) }
        if mods & (1 << 3) != 0 { flags.insert(.command) }
        return flags
    }
}
