// ignore_for_file: public_member_api_docs

import '../../shadcn_flutter.dart';

void _assertNotThemeModeSystem(ThemeMode mode, String label) {
  if (mode == ThemeMode.system) {
    final List<DiagnosticsNode> diagnosticList = [];
    diagnosticList.add(ErrorSummary(
        'ColorSchemes.${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.'));
    diagnosticList.add(ErrorDescription(
        'This method is only intended as a helper method to get either ColorSchemes.light$label or ColorSchemes.dark$label.'));
    diagnosticList.add(ErrorHint('To use system theme mode, do this:\n'
        'ShadcnApp(\n'
        '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.light)),\n'
        '  darkTheme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.dark)),\n'
        '  themeMode: ThemeMode.system, // optional, default is ThemeMode.system\n'
        ')\n'
        'or:\n'
        'ShadcnApp(\n'
        '  theme: ThemeData(colorScheme: ColorSchemes.light$label),\n'
        '  darkTheme: ThemeData(colorScheme: ColorSchemes.dark$label),\n'
        ')\n'
        'instead of:\n'
        'ShadcnApp(\n'
        '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.system)),\n'
        ')'));
    throw FlutterError.fromParts(diagnosticList);
  }
}

class ColorSchemes {
  ColorSchemes._();

  static const ColorScheme lightNeutral = ColorScheme(
    brightness: Brightness.light,
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF0A0A0A),
    card: Color(0xFFFFFFFF),
    cardForeground: Color(0xFF0A0A0A),
    popover: Color(0xFFFFFFFF),
    popoverForeground: Color(0xFF0A0A0A),
    primary: Color(0xFF171717),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF5F5F5),
    secondaryForeground: Color(0xFF171717),
    muted: Color(0xFFF5F5F5),
    mutedForeground: Color(0xFF737373),
    accent: Color(0xFFF5F5F5),
    accentForeground: Color(0xFF171717),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    border: Color(0xFFE5E5E5),
    input: Color(0xFFE5E5E5),
    ring: Color(0xFF0A0A0A),
    chart1: Color(0xFFE76E50),
    chart2: Color(0xFF2A9D90),
    chart3: Color(0xFF274754),
    chart4: Color(0xFFE8C468),
    chart5: Color(0xFFF4A462),
  );

  static const ColorScheme darkNeutral = ColorScheme(
    brightness: Brightness.dark,
    background: Color(0xFF0A0A0A),
    foreground: Color(0xFFFAFAFA),
    card: Color(0xFF0A0A0A),
    cardForeground: Color(0xFFFAFAFA),
    popover: Color(0xFF0A0A0A),
    popoverForeground: Color(0xFFFAFAFA),
    primary: Color(0xFFFAFAFA),
    primaryForeground: Color(0xFF171717),
    secondary: Color(0xFF262626),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF262626),
    mutedForeground: Color(0xFFA3A3A3),
    accent: Color(0xFF262626),
    accentForeground: Color(0xFFFAFAFA),
    destructive: Color(0xFF7F1D1D),
    destructiveForeground: Color(0xFFFAFAFA),
    border: Color(0xFF262626),
    input: Color(0xFF262626),
    ring: Color(0xFFD4D4D4),
    chart1: Color(0xFF2662D9),
    chart2: Color(0xFF2EB88A),
    chart3: Color(0xFFE88C30),
    chart4: Color(0xFFAF57DB),
    chart5: Color(0xFFE23670),
  );

  static const ColorScheme lightRunera = ColorScheme(
    brightness: Brightness.light,
    background: Color(0xFFF9F8F5),
    foreground: Color(0xFF0F172A),
    card: Color(0xFFFFFFFF),
    cardForeground: Color(0xFF0F172A),
    popover: Color(0xFFFFFFFF),
    popoverForeground: Color(0xFF0F172A),
    primary: Color(0xFF3B6EF5),
    primaryForeground: Color(0xFFFFFFFF),
    secondary: Color(0xFFF5F7FB),
    secondaryForeground: Color(0xFF0E043E),
    muted: Color(0xFFF5F7FB),
    mutedForeground: Color(0xFF475569),
    accent: Color(0xFFE8EFFF),
    accentForeground: Color(0xFF0E043E),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFFFFFF),
    border: Color(0xFFE5E7EB),
    input: Color(0xFFE5E7EB),
    ring: Color(0xFF3B6EF5),
    chart1: Color(0xFF0E043E),
    chart2: Color(0xFF3B6EF5),
    chart3: Color(0xFF43328E),
    chart4: Color(0xFF64748B),
    chart5: Color(0xFF93A4D6),
  );

  static const ColorScheme darkRunera = ColorScheme(
    brightness: Brightness.dark,
    background: Color(0xFF0E043E),
    foreground: Color(0xFFF3F6FF),
    card: Color(0xFF17104F),
    cardForeground: Color(0xFFF3F6FF),
    popover: Color(0xFF17104F),
    popoverForeground: Color(0xFFF3F6FF),
    primary: Color(0xFF3B6EF5),
    primaryForeground: Color(0xFFFFFFFF),
    secondary: Color(0xFF1E1758),
    secondaryForeground: Color(0xFFF3F6FF),
    muted: Color(0xFF241D62),
    mutedForeground: Color(0xFFC7D2F4),
    accent: Color(0xFF28357C),
    accentForeground: Color(0xFFF3F6FF),
    destructive: Color(0xFFC43C4D),
    destructiveForeground: Color(0xFFFFFFFF),
    border: Color(0xFF39356F),
    input: Color(0xFF39356F),
    ring: Color(0xFF7EA2FF),
    chart1: Color(0xFF3B6EF5),
    chart2: Color(0xFFF3F6FF),
    chart3: Color(0xFF6578DA),
    chart4: Color(0xFF96ACEB),
    chart5: Color(0xFF6A80C4),
  );

  static ColorScheme neutral(ThemeMode mode) {
    assert(() {
      _assertNotThemeModeSystem(mode, 'Neutral');
      return true;
    }());
    return mode == ThemeMode.light ? lightNeutral : darkNeutral;
  }

  static ColorScheme runera(ThemeMode mode) {
    assert(() {
      _assertNotThemeModeSystem(mode, 'Runera');
      return true;
    }());
    return mode == ThemeMode.light ? lightRunera : darkRunera;
  }
}
