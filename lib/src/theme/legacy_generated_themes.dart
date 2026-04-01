import '../../shadcn_flutter.dart';

Color _legacyHex(int hex) => HSLColor.fromColor(Color(hex)).toColor();

void _assertNotThemeModeSystem(ThemeMode mode, String label) {
  if (mode == ThemeMode.system) {
    final List<DiagnosticsNode> diagnosticList = [];
    diagnosticList.add(ErrorSummary(
        'ColorSchemes.${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.'));
    diagnosticList.add(ErrorDescription(
        'This method is only intended as a helper method to get either ColorSchemes.light$label() or ColorSchemes.dark$label().'));
    diagnosticList.add(ErrorHint('To use system theme mode, do this:\n'
        'ShadcnApp(\n'
        '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.light)),\n'
        '  darkTheme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.dark)),\n'
        '  themeMode: ThemeMode.system, // optional, default is ThemeMode.system\n'
        ')\n'
        'or:\n'
        'ShadcnApp(\n'
        '  theme: ThemeData(colorScheme: LegacyColorSchemes.light$label()),\n'
        '  darkTheme: ThemeData(colorScheme: LegacyColorSchemes.dark$label()),\n'
        ')\n'
        'instead of:\n'
        'ShadcnApp(\n'
        '  theme: ThemeData(colorScheme: LegacyColorSchemes.${label.toLowerCase()}(ThemeMode.system)),\n'
        ')'));
    throw FlutterError.fromParts(diagnosticList);
  }
}

/// Legacy color schemes using HSL color definitions.
///
/// These color schemes use HSL (Hue, Saturation, Lightness) for color definition
/// and are provided for backward compatibility. New code should prefer
/// using the RGB-based [ColorSchemes] class.
class LegacyColorSchemes {
  const LegacyColorSchemes._();

  /// Returns light neutral color scheme.
  static ColorScheme lightNeutral() {
    return ColorScheme(
      brightness: Brightness.light,
      background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
      foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
      cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
      popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      primary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
      primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      secondary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
      secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
      muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
      mutedForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.45).toColor(),
      accent: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
      accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
      destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
      destructiveForeground:
          const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      border: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.9).toColor(),
      input: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.9).toColor(),
      ring: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      chart1: const HSLColor.fromAHSL(1, 12.0, 0.76, 0.61).toColor(),
      chart2: const HSLColor.fromAHSL(1, 173.0, 0.58, 0.39).toColor(),
      chart3: const HSLColor.fromAHSL(1, 197.0, 0.37, 0.24).toColor(),
      chart4: const HSLColor.fromAHSL(1, 43.0, 0.74, 0.66).toColor(),
      chart5: const HSLColor.fromAHSL(1, 27.0, 0.87, 0.67).toColor(),
    );
  }

  /// Returns dark neutral color scheme.
  static ColorScheme darkNeutral() {
    return ColorScheme(
      brightness: Brightness.dark,
      background: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      card: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
      popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      primary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
      secondary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
      secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
      mutedForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.64).toColor(),
      accent: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
      accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
      destructiveForeground:
          const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
      border: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
      input: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
      ring: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.83).toColor(),
      chart1: const HSLColor.fromAHSL(1, 220.0, 0.7, 0.5).toColor(),
      chart2: const HSLColor.fromAHSL(1, 160.0, 0.6, 0.45).toColor(),
      chart3: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.55).toColor(),
      chart4: const HSLColor.fromAHSL(1, 280.0, 0.65, 0.6).toColor(),
      chart5: const HSLColor.fromAHSL(1, 340.0, 0.75, 0.55).toColor(),
    );
  }

  /// Returns light Runera color scheme.
  static ColorScheme lightRunera() {
    return ColorScheme(
      brightness: Brightness.light,
      background: _legacyHex(0xFFFFFFFF),
      foreground: _legacyHex(0xFF0F172A),
      card: _legacyHex(0xFFFFFFFF),
      cardForeground: _legacyHex(0xFF0F172A),
      popover: _legacyHex(0xFFFFFFFF),
      popoverForeground: _legacyHex(0xFF0F172A),
      primary: _legacyHex(0xFF0E043E),
      primaryForeground: _legacyHex(0xFFFFFFFF),
      secondary: _legacyHex(0xFFF5F7FB),
      secondaryForeground: _legacyHex(0xFF0E043E),
      muted: _legacyHex(0xFFF5F7FB),
      mutedForeground: _legacyHex(0xFF475569),
      accent: _legacyHex(0xFFE8EFFF),
      accentForeground: _legacyHex(0xFF0E043E),
      destructive: _legacyHex(0xFFEF4444),
      destructiveForeground: _legacyHex(0xFFFFFFFF),
      border: _legacyHex(0xFFE5E7EB),
      input: _legacyHex(0xFFE5E7EB),
      ring: _legacyHex(0xFF3B6EF5),
      chart1: _legacyHex(0xFF0E043E),
      chart2: _legacyHex(0xFF3B6EF5),
      chart3: _legacyHex(0xFF43328E),
      chart4: _legacyHex(0xFF64748B),
      chart5: _legacyHex(0xFF93A4D6),
    );
  }

  /// Returns dark Runera color scheme.
  static ColorScheme darkRunera() {
    return ColorScheme(
      brightness: Brightness.dark,
      background: _legacyHex(0xFF0E043E),
      foreground: _legacyHex(0xFFE8EFFF),
      card: _legacyHex(0xFF16104B),
      cardForeground: _legacyHex(0xFFE8EFFF),
      popover: _legacyHex(0xFF16104B),
      popoverForeground: _legacyHex(0xFFE8EFFF),
      primary: _legacyHex(0xFF3B6EF5),
      primaryForeground: _legacyHex(0xFFFFFFFF),
      secondary: _legacyHex(0xFF20175A),
      secondaryForeground: _legacyHex(0xFFE8EFFF),
      muted: _legacyHex(0xFF20175A),
      mutedForeground: _legacyHex(0xFFB8C3E6),
      accent: _legacyHex(0xFF2A245F),
      accentForeground: _legacyHex(0xFFE8EFFF),
      destructive: _legacyHex(0xFF991B1B),
      destructiveForeground: _legacyHex(0xFFFFFFFF),
      border: _legacyHex(0xFF302962),
      input: _legacyHex(0xFF302962),
      ring: _legacyHex(0xFF3B6EF5),
      chart1: _legacyHex(0xFF3B6EF5),
      chart2: _legacyHex(0xFFE8EFFF),
      chart3: _legacyHex(0xFF43328E),
      chart4: _legacyHex(0xFF93A4D6),
      chart5: _legacyHex(0xFF64748B),
    );
  }

  /// Returns neutral color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme neutral(ThemeMode mode) {
    assert(() {
      _assertNotThemeModeSystem(mode, 'Neutral');
      return true;
    }());
    return mode == ThemeMode.light ? lightNeutral() : darkNeutral();
  }

  /// Returns Runera color scheme for the given [mode].
  ///
  /// The [mode] must be either [ThemeMode.light] or [ThemeMode.dark].
  /// [ThemeMode.system] is not supported.
  static ColorScheme runera(ThemeMode mode) {
    assert(() {
      _assertNotThemeModeSystem(mode, 'Runera');
      return true;
    }());
    return mode == ThemeMode.light ? lightRunera() : darkRunera();
  }
}
