import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('RuneraGradients', () {
    test('identifies Runera presets', () {
      expect(RuneraGradients.isPreset(ColorSchemes.lightRunera), isTrue);
      expect(RuneraGradients.isPreset(ColorSchemes.darkRunera), isTrue);
      expect(RuneraGradients.isPreset(ColorSchemes.lightNeutral), isFalse);
    });

    test('builds the light Runera primary gradient', () {
      final gradient = RuneraGradients.primary(
        colorScheme: ColorSchemes.lightRunera,
      );

      expect(gradient.begin, Alignment.topLeft);
      expect(gradient.end, Alignment.bottomRight);
      expect(
        gradient.colors,
        equals([
          ColorSchemes.lightRunera.accentForeground,
          ColorSchemes.lightRunera.primary,
        ]),
      );
    });

    test('builds the dark Runera primary gradient', () {
      final gradient = RuneraGradients.primary(
        colorScheme: ColorSchemes.darkRunera,
      );

      expect(gradient.begin, Alignment.topLeft);
      expect(gradient.end, Alignment.bottomRight);
      expect(
        gradient.colors,
        equals([
          ColorSchemes.darkRunera.accent,
          ColorSchemes.darkRunera.primary,
        ]),
      );
    });

    test('darkens the gradient for hovered states', () {
      final gradient = RuneraGradients.primary(
        colorScheme: ColorSchemes.lightRunera,
        states: {WidgetState.hovered},
      );

      expect(
        gradient.colors.first,
        isNot(ColorSchemes.lightRunera.accentForeground),
      );
      expect(
        gradient.colors.last,
        isNot(ColorSchemes.lightRunera.primary),
      );
    });

    test('darkens the dark Runera gradient for pressed states', () {
      final gradient = RuneraGradients.primary(
        colorScheme: ColorSchemes.darkRunera,
        states: {WidgetState.pressed},
      );

      expect(
        gradient.colors.first,
        isNot(ColorSchemes.darkRunera.accent),
      );
      expect(
        gradient.colors.last,
        isNot(ColorSchemes.darkRunera.primary),
      );
    });
  });
}
