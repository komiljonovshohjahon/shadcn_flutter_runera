import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('Runera theme tokens', () {
    test('uses the updated light scaffold and card surfaces', () {
      expect(ColorSchemes.lightRunera.background, const Color(0xFFF9F8F5));
      expect(ColorSchemes.lightRunera.card, const Color(0xFFFFFFFF));
    });

    test('keeps legacy light Runera surfaces in sync', () {
      final legacyScheme = LegacyColorSchemes.lightRunera();

      expect(legacyScheme.background, const Color(0xFFF9F8F5));
      expect(legacyScheme.card, const Color(0xFFFFFFFF));
    });

    test('uses the refined dark Runera token palette', () {
      expect(ColorSchemes.darkRunera.background, const Color(0xFF0E043E));
      expect(ColorSchemes.darkRunera.card, const Color(0xFF17104F));
      expect(ColorSchemes.darkRunera.foreground, const Color(0xFFF3F6FF));
      expect(ColorSchemes.darkRunera.accent, const Color(0xFF28357C));
      expect(ColorSchemes.darkRunera.border, const Color(0xFF39356F));
      expect(ColorSchemes.darkRunera.ring, const Color(0xFF7EA2FF));
      expect(ColorSchemes.darkRunera.destructive, const Color(0xFFC43C4D));
    });

    test('keeps legacy dark Runera tokens in sync', () {
      final legacyScheme = LegacyColorSchemes.darkRunera();

      expect(legacyScheme.background, const Color(0xFF0E043E));
      expect(legacyScheme.card, const Color(0xFF17104F));
      expect(legacyScheme.foreground, const Color(0xFFF3F6FF));
      expect(legacyScheme.accent, const Color(0xFF28357C));
      expect(legacyScheme.border, const Color(0xFF39356F));
      expect(legacyScheme.ring, const Color(0xFF7EA2FF));
      expect(legacyScheme.destructive, const Color(0xFFC43C4D));
    });
  });
}
