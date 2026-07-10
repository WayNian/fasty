import SwiftUI

struct ThemePreview: View {
    let themeName: String
    let isSelected: Bool

    private var scheme: TerminalColorScheme {
        TerminalColorScheme.from(themeName: themeName)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(themeName)
                    .font(.headline)
                    .foregroundColor(scheme.foreground)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scheme.green)
                }
            }

            HStack(spacing: 4) {
                colorBlock(scheme.black)
                colorBlock(scheme.red)
                colorBlock(scheme.green)
                colorBlock(scheme.yellow)
                colorBlock(scheme.blue)
                colorBlock(scheme.magenta)
                colorBlock(scheme.cyan)
                colorBlock(scheme.white)
            }

            HStack(spacing: 4) {
                colorBlock(scheme.brightBlack)
                colorBlock(scheme.brightRed)
                colorBlock(scheme.brightGreen)
                colorBlock(scheme.brightYellow)
                colorBlock(scheme.brightBlue)
                colorBlock(scheme.brightMagenta)
                colorBlock(scheme.brightCyan)
                colorBlock(scheme.brightWhite)
            }

            HStack(spacing: 4) {
                colorBlock(scheme.background)
                colorBlock(scheme.foreground)
                colorBlock(scheme.cursor)
                colorBlock(scheme.selection)
            }
        }
        .padding(10)
        .background(scheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? scheme.foreground : Color.clear, lineWidth: 2)
        )
    }

    private func colorBlock(_ color: Color) -> some View {
        color
            .frame(width: 16, height: 16)
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

struct ThemePreviewGrid: View {
    let themes: [String]
    @Binding var selectedTheme: String

    private let columns = [
        GridItem(.adaptive(minimum: 200, maximum: 300), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(themes, id: \.self) { theme in
                    Button(action: {
                        selectedTheme = theme
                    }) {
                        ThemePreview(themeName: theme, isSelected: theme == selectedTheme)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}
