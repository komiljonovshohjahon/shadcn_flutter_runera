import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('MultiSelect trigger display', () {
    Widget buildMultiSelect({
      double? width,
      MultiSelectTriggerDisplayMode triggerDisplayMode =
          MultiSelectTriggerDisplayMode.wrap,
      required List<String> values,
      MultiSelectTriggerBuilder<String>? triggerBuilder,
    }) {
      return SimpleApp(
        child: MultiSelect<String>(
          value: values,
          constraints:
              width == null ? null : BoxConstraints.tightFor(width: width),
          popup: (context) => const SizedBox.shrink(),
          triggerDisplayMode: triggerDisplayMode,
          triggerTextBuilder: (value) => value,
          triggerBuilder: triggerBuilder,
          itemBuilder: (context, item) => Text(item),
        ),
      );
    }

    Finder multiSelectFinder() =>
        find.byWidgetPredicate((widget) => widget is MultiSelect<String>);

    Finder summaryFinder() => find.byWidgetPredicate(
          (widget) =>
              widget.runtimeType.toString() == '_MultiSelectTriggerSummaryText',
        );

    dynamic summaryRenderObject(WidgetTester tester) =>
        tester.renderObject(summaryFinder());

    testWidgets('uses wrap display by default', (tester) async {
      await tester.pumpWidget(
        buildMultiSelect(width: 260, values: const ['Alpha', 'Beta', 'Gamma']),
      );

      expect(
        find.descendant(
          of: multiSelectFinder(),
          matching: find.byType(Wrap),
        ),
        findsOneWidget,
      );
      expect(find.text('Alpha'), findsOneWidget);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Gamma'), findsOneWidget);
    });

    testWidgets('renders a comma-separated summary when enabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildMultiSelect(
          width: 420,
          values: const ['Alpha', 'Beta', 'Gamma'],
          triggerDisplayMode: MultiSelectTriggerDisplayMode.commaSeparated,
        ),
      );

      expect(
        find.descendant(
          of: multiSelectFinder(),
          matching: find.byType(Wrap),
        ),
        findsNothing,
      );
      expect(summaryFinder(), findsOneWidget);
      expect(
        summaryRenderObject(tester).debugDisplayText,
        'Alpha, Beta, Gamma',
      );
    });

    testWidgets('does not throw layout exceptions in intrinsic sizing', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildMultiSelect(
          values: const ['Alpha', 'Beta', 'Gamma'],
          triggerDisplayMode: MultiSelectTriggerDisplayMode.commaSeparated,
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('allows wrapping the summary with an external clear action', (
      tester,
    ) async {
      final controller = MultiSelectController<String>(['Alpha', 'Beta']);

      await tester.pumpWidget(
        SimpleApp(
          child: ControlledMultiSelect<String>(
            controller: controller,
            popup: (context) => const SizedBox.shrink(),
            triggerDisplayMode: MultiSelectTriggerDisplayMode.commaSeparated,
            triggerTextBuilder: (value) => value,
            triggerBuilder: (context, values, child, clearSelection) => Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: clearSelection,
                  child: const Text('Clear'),
                ),
                const Gap(8),
                Expanded(child: child),
              ],
            ),
            itemBuilder: (context, item) => Text(item),
          ),
        ),
      );

      expect(find.text('Clear'), findsOneWidget);
      expect(summaryRenderObject(tester).debugDisplayText, 'Alpha, Beta');

      await tester.tap(find.text('Clear'));
      await tester.pump();

      expect(controller.value, isNull);
    });

    testWidgets('collapses the summary with dots when it does not fit', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildMultiSelect(
          width: 160,
          values: const [
            'Extremely long first option',
            'Second selection',
            'Third selection',
          ],
          triggerDisplayMode: MultiSelectTriggerDisplayMode.commaSeparated,
        ),
      );

      expect(summaryFinder(), findsOneWidget);
      final summaryDescription =
          summaryRenderObject(tester).debugDisplayText as String;
      expect(
        summaryDescription == '...' || summaryDescription.endsWith(', ...'),
        isTrue,
      );
    });
  });
}
