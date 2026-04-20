import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

Finder _badgeButton(Finder badgeFinder) {
  return find.descendant(of: badgeFinder, matching: find.byType(Button));
}

Button _buttonWidget(WidgetTester tester, Finder badgeFinder) {
  return tester.widget<Button>(_badgeButton(badgeFinder));
}

BoxDecoration _badgeDecoration(WidgetTester tester, Finder badgeFinder,
    [Set<WidgetState>? states]) {
  final buttonFinder = _badgeButton(badgeFinder);
  final button = tester.widget<Button>(buttonFinder);
  final context = tester.element(buttonFinder);
  return button.style.decoration(context, states ?? <WidgetState>{})
      as BoxDecoration;
}

TextStyle _badgeTextStyle(WidgetTester tester, Finder badgeFinder,
    [Set<WidgetState>? states]) {
  final buttonFinder = _badgeButton(badgeFinder);
  final button = tester.widget<Button>(buttonFinder);
  final context = tester.element(buttonFinder);
  return button.style.textStyle(context, states ?? <WidgetState>{});
}

IconThemeData _badgeIconTheme(WidgetTester tester, Finder badgeFinder,
    [Set<WidgetState>? states]) {
  final buttonFinder = _badgeButton(badgeFinder);
  final button = tester.widget<Button>(buttonFinder);
  final context = tester.element(buttonFinder);
  return button.style.iconTheme(context, states ?? <WidgetState>{});
}

MouseCursor _badgeMouseCursor(WidgetTester tester, Finder badgeFinder,
    [Set<WidgetState>? states]) {
  final buttonFinder = _badgeButton(badgeFinder);
  final button = tester.widget<Button>(buttonFinder);
  final context = tester.element(buttonFinder);
  return button.style.mouseCursor(context, states ?? <WidgetState>{});
}

void main() {
  group('Badge interactivity', () {
    testWidgets(
        'non-pressable primary badge is not interactive but keeps appearance',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: PrimaryBadge(
            child: Text('Static'),
          ),
        ),
      );

      final badgeFinder = find.byType(PrimaryBadge);
      final button = _buttonWidget(tester, badgeFinder);
      final normalDecoration = _badgeDecoration(tester, badgeFinder);
      final disabledDecoration =
          _badgeDecoration(tester, badgeFinder, {WidgetState.disabled});
      final normalTextStyle = _badgeTextStyle(tester, badgeFinder);
      final disabledTextStyle =
          _badgeTextStyle(tester, badgeFinder, {WidgetState.disabled});

      expect(button.enabled, isFalse);
      expect(
        _badgeMouseCursor(tester, badgeFinder, {WidgetState.disabled}),
        SystemMouseCursors.basic,
      );
      expect(disabledDecoration.color, normalDecoration.color);
      expect(disabledTextStyle.color, normalTextStyle.color);
    });

    testWidgets('pressable primary badge stays interactive', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: PrimaryBadge(
            onPressed: () {},
            child: Text('Action'),
          ),
        ),
      );

      final badgeFinder = find.byType(PrimaryBadge);
      final button = _buttonWidget(tester, badgeFinder);

      expect(button.enabled, isTrue);
      expect(_badgeMouseCursor(tester, badgeFinder), SystemMouseCursors.click);
    });
  });

  group('CustomBadge', () {
    testWidgets('applies the custom fill color and derived foreground',
        (tester) async {
      const color = Color(0xFF16A34A);

      await tester.pumpWidget(
        SimpleApp(
          child: CustomBadge(
            color: color,
            child: Text('BETA'),
          ),
        ),
      );

      final badgeFinder = find.byType(CustomBadge);
      final decoration = _badgeDecoration(tester, badgeFinder);
      final textStyle = _badgeTextStyle(tester, badgeFinder);

      expect(decoration.color, color);
      expect(textStyle.color, color.getContrastColor());
      expect(textStyle.fontWeight, FontWeight.w500);
    });

    testWidgets('uses an explicit foreground color for text and icons',
        (tester) async {
      const color = Color(0xFFF97316);
      const foregroundColor = Color(0xFF111827);

      await tester.pumpWidget(
        SimpleApp(
          child: CustomBadge(
            color: color,
            foregroundColor: foregroundColor,
            leading: Icon(Icons.star, size: 14),
            trailing: Icon(Icons.close, size: 14),
            child: Text('Needs Review'),
          ),
        ),
      );

      final badgeFinder = find.byType(CustomBadge);
      final textStyle = _badgeTextStyle(tester, badgeFinder);
      final iconTheme = _badgeIconTheme(tester, badgeFinder);

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(textStyle.color, foregroundColor);
      expect(iconTheme.color, foregroundColor);
    });

    testWidgets('preserves the caller provided shape when recoloring',
        (tester) async {
      const color = Color(0xFF2563EB);

      await tester.pumpWidget(
        SimpleApp(
          child: CustomBadge(
            color: color,
            style: ButtonStyle.primary(
              size: ButtonSize.small,
              density: ButtonDensity.dense,
              shape: ButtonShape.circle,
            ),
            child: Icon(Icons.check, size: 14),
          ),
        ),
      );

      final badgeFinder = find.byType(CustomBadge);
      final decoration = _badgeDecoration(tester, badgeFinder);

      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, color);
    });

    testWidgets(
        'non-pressable custom badge keeps its configured color when disabled',
        (tester) async {
      const color = Color(0xFF16A34A);

      await tester.pumpWidget(
        SimpleApp(
          child: CustomBadge(
            color: color,
            child: Text('BETA'),
          ),
        ),
      );

      final badgeFinder = find.byType(CustomBadge);
      final button = _buttonWidget(tester, badgeFinder);
      final disabledDecoration =
          _badgeDecoration(tester, badgeFinder, {WidgetState.disabled});
      final disabledTextStyle =
          _badgeTextStyle(tester, badgeFinder, {WidgetState.disabled});

      expect(button.enabled, isFalse);
      expect(disabledDecoration.color, color);
      expect(disabledTextStyle.color, color.getContrastColor());
    });
  });
}
