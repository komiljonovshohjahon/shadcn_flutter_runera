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
  });
}
