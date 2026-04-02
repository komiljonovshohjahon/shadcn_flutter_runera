import '../../shadcn_flutter.dart';

/// Reusable branded gradients for the Runera theme family.
///
/// These helpers centralize the brand's diagonal blue treatment so components
/// can share the same gradient logic without duplicating color/state handling.
class RuneraGradients {
  const RuneraGradients._();

  /// Returns true when [colorScheme] matches one of the built-in Runera presets.
  static bool isPreset(ColorScheme colorScheme) {
    return colorScheme == ColorSchemes.lightRunera ||
        colorScheme == ColorSchemes.darkRunera;
  }

  /// Returns the branded primary gradient for Runera surfaces and CTAs.
  ///
  /// The gradient runs from top-left to bottom-right and subtly darkens during
  /// hover, focus, selected, and pressed states.
  static LinearGradient primary({
    required ColorScheme colorScheme,
    Set<WidgetState> states = const <WidgetState>{},
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    final bool isLightRunera = colorScheme == ColorSchemes.lightRunera;
    final Color startColor = isLightRunera
        // Light Runera's accent token is a pale surface tint, so the CTA uses
        // the deeper navy brand tone for a readable gradient.
        ? colorScheme.accentForeground
        : colorScheme.accent;
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [
        _toneColor(
          startColor,
          states,
          hoverDelta: -0.015,
          pressedDelta: -0.035,
        ),
        _toneColor(
          colorScheme.primary,
          states,
          hoverDelta: -0.015,
          pressedDelta: -0.035,
        ),
      ],
    );
  }

  static bool _isHoveredLike(Set<WidgetState> states) {
    return states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.focused) ||
        states.contains(WidgetState.selected);
  }

  static Color _toneColor(
    Color color,
    Set<WidgetState> states, {
    double hoverDelta = -0.02,
    double pressedDelta = -0.05,
  }) {
    double delta = 0;
    if (states.contains(WidgetState.pressed)) {
      delta = pressedDelta;
    } else if (_isHoveredLike(states)) {
      delta = hoverDelta;
    }
    if (delta == 0) {
      return color;
    }
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + delta).clamp(0.0, 1.0)).toColor();
  }
}
