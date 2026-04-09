import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('Runera typography', () {
    test('uses SFMonoRegular for mono text by default', () {
      expect(
        const ThemeData.runeraLight().typography.mono.fontFamily,
        'SFMonoRegular',
      );
      expect(
        const ThemeData.runeraDark().typography.mono.fontFamily,
        'SFMonoRegular',
      );
    });
  });
}
