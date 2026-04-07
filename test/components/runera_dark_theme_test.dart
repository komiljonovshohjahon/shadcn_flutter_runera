import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Widget buildRuneraDarkApp({required Widget child}) {
  return ShadcnApp(
    theme: const ThemeData.runeraLight(),
    darkTheme: const ThemeData.runeraDark(),
    themeMode: ThemeMode.dark,
    home: Scaffold(child: child),
  );
}

Iterable<BoxDecoration> _boxDecorations(
  WidgetTester tester,
  Finder finder,
) sync* {
  for (final widget in tester.widgetList<Container>(finder)) {
    final decoration = widget.decoration;
    if (decoration is BoxDecoration) {
      yield decoration;
    }
  }
}

void main() {
  group('Runera dark theme', () {
    testWidgets('uses the branded gradient for primary buttons',
        (tester) async {
      await tester.pumpWidget(
        buildRuneraDarkApp(
          child: Button.primary(
            onPressed: () {},
            child: const Text('Runera Dark Button'),
          ),
        ),
      );

      final decoratedBox = tester.widget<OverflowDecoratedBox>(
        find.descendant(
          of: find.byType(Button),
          matching: find.byType(OverflowDecoratedBox),
        ),
      );
      final decoration = decoratedBox.decoration as BoxDecoration;
      final gradient = decoration.gradient as LinearGradient?;

      expect(gradient, isNotNull);
      expect(
        gradient!.colors,
        equals([
          ColorSchemes.darkRunera.accent,
          ColorSchemes.darkRunera.primary,
        ]),
      );
      expect(decoration.color, isNull);
    });

    testWidgets('tints focused text fields with the dark Runera accent',
        (tester) async {
      await tester.pumpWidget(
        buildRuneraDarkApp(
          child: const TextField(),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      final decorations = _boxDecorations(
        tester,
        find.descendant(
          of: find.byType(TextField),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Container && widget.decoration is BoxDecoration,
          ),
        ),
      ).toList();

      final expectedFill = Color.lerp(
        ColorSchemes.darkRunera.background,
        ColorSchemes.darkRunera.accent,
        0.56,
      )!;
      final focusedDecoration = decorations.firstWhere(
        (decoration) => decoration.color?.toARGB32() == expectedFill.toARGB32(),
      );
      final border = focusedDecoration.border! as Border;

      expect(focusedDecoration.color?.toARGB32(), expectedFill.toARGB32());
      expect(
        border.top.color.toARGB32(),
        ColorSchemes.darkRunera.ring.toARGB32(),
      );
    });

    testWidgets('keeps tabs on the dark Runera navigation surface',
        (tester) async {
      await tester.pumpWidget(
        buildRuneraDarkApp(
          child: Tabs(
            index: 0,
            onChanged: (_) {},
            children: const [
              TabItem(child: Text('Overview')),
              TabItem(child: Text('Details')),
            ],
          ),
        ),
      );

      final selectedTab = tester
          .widgetList<AnimatedContainer>(
            find.descendant(
              of: find.byType(Tabs),
              matching: find.byType(AnimatedContainer),
            ),
          )
          .map((widget) => widget.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((decoration) => decoration.color != null);
      final selectedBorder = selectedTab.border! as Border;
      final expectedSelectedFill = Color.lerp(
        ColorSchemes.darkRunera.background,
        ColorSchemes.darkRunera.accent,
        0.3,
      )!;

      expect(
        selectedTab.color?.toARGB32(),
        expectedSelectedFill.toARGB32(),
      );
      expect(
        selectedBorder.top.color.toARGB32(),
        Color.lerp(
          ColorSchemes.darkRunera.border,
          ColorSchemes.darkRunera.ring,
          0.24,
        )!
            .toARGB32(),
      );

      final tabContainer = _boxDecorations(
        tester,
        find.descendant(
          of: find.byType(Tabs),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Container && widget.decoration is BoxDecoration,
          ),
        ),
      ).firstWhere(
        (decoration) =>
            decoration.color?.toARGB32() ==
            ColorSchemes.darkRunera.secondary.toARGB32(),
      );

      expect(
        tabContainer.color?.toARGB32(),
        ColorSchemes.darkRunera.secondary.toARGB32(),
      );
    });
  });
}
