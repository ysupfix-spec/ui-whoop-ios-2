import SwiftUI

// MARK: - NOOP visual foundation
//
// These tokens describe the visual treatment used by NOOP's existing views. They deliberately
// contain no navigation, state, or domain semantics: screens keep their current hierarchy and data
// bindings, while cards, gauges, typography, and chrome share one maintainable source of truth.

public enum NoopVisualStyle {
    // Neutral, low-chroma surfaces sampled from the supplied dark-mode reference.
    public static let canvas = Color(light: "#F3F4F6", dark: "#000000")
    public static let surface = Color(light: "#FFFFFF", dark: "#1C1C1E")
    public static let surfaceTop = Color(light: "#FFFFFF", dark: "#1C1C1E")
    public static let surfaceBottom = Color(light: "#F4F5F7", dark: "#1C1C1E")
    public static let inset = Color(light: "#E8E9ED", dark: "#141416")

    public static let border = Color(light: "#D8DAE0", dark: "#2C2C2E")
    public static let borderHighlight = Color(light: "#FFFFFF", dark: "#2C2C2E")
    public static let divider = Color(light: "#E4E5E9", dark: "#26262A")

    public static let primaryText = Color(light: "#17181C", dark: "#FFFFFF")
    public static let secondaryText = Color(light: "#555861", dark: "#A1A1A8")
    public static let tertiaryText = Color(light: "#7D808A", dark: "#6E6E76")

    public static let mint = Color(light: "#149A78", dark: "#00E0A8")
    public static let mintDeep = Color(light: "#0D765C", dark: "#00C896")
    public static let mintGlow = Color(light: "#38C99E", dark: "#4DF0C2")

    public static let cardRadius: CGFloat = 20
    public static let compactRadius: CGFloat = 16
    public static let pillRadius: CGFloat = 999
    public static let pagePadding: CGFloat = 16
    public static let cardPadding: CGFloat = 16
    public static let itemGap: CGFloat = 12
    public static let sectionGap: CGFloat = 26
}

/// Shared card/panel treatment: a solid surface on iOS, gradient and soft elevation elsewhere.
/// `tint` is intentionally faint so metric identity never turns the whole card into a coloured tile.
public struct NoopPanelSurface: View {
    public var tint: Color?
    public var cornerRadius: CGFloat
    public var elevated: Bool
    public var surfaceOpacity: Double

    public init(
        tint: Color? = nil,
        cornerRadius: CGFloat = NoopVisualStyle.cardRadius,
        elevated: Bool = false,
        surfaceOpacity: Double = 1
    ) {
        self.tint = tint
        self.cornerRadius = cornerRadius
        self.elevated = elevated
        self.surfaceOpacity = surfaceOpacity
    }

    /// WHOOP-style card: one flat fill on a black canvas, no gradient, rim or shadow.
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(NoopVisualStyle.surface)
            .opacity(surfaceOpacity)
    }
}

/// Shared edge-to-edge chrome for sheet and split-view headers. Unlike a card it has no
/// rounded outline or elevation, but it uses the same top-lit surface ramp and divider token.
public struct NoopChromeSurface: View {
    public init() {}

    public var body: some View {
        LinearGradient(
            colors: [NoopVisualStyle.surfaceTop, NoopVisualStyle.surfaceBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(NoopVisualStyle.divider)
                .frame(height: 0.5)
        }
    }
}

public extension View {
    func noopPanel(
        tint: Color? = nil,
        cornerRadius: CGFloat = NoopVisualStyle.cardRadius,
        elevated: Bool = false,
        surfaceOpacity: Double = 1
    ) -> some View {
        background {
            NoopPanelSurface(
                tint: tint,
                cornerRadius: cornerRadius,
                elevated: elevated,
                surfaceOpacity: surfaceOpacity
            )
        }
    }
}
