import 'package:flutter_test/flutter_test.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('RadioGroup', () {
    testWidgets('radio card selects value on tap', (tester) async {
      String? selected = 'first';

      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return RadioGroup<String>(
                value: selected,
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                child: Column(
                  children: const [
                    RadioCard<String>(
                      value: 'first',
                      child: Text('First'),
                    ),
                    RadioCard<String>(
                      value: 'second',
                      child: Text('Second'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(selected, 'first');

      await tester.tap(find.text('Second'));
      await tester.pump();

      expect(selected, 'second');
    });

    testWidgets('disabled radio group ignores radio card taps', (tester) async {
      String? selected = 'first';

      await tester.pumpWidget(
        SimpleApp(
          child: RadioGroup<String>(
            value: selected,
            enabled: false,
            onChanged: (value) {
              selected = value;
            },
            child: Column(
              children: const [
                RadioCard<String>(
                  value: 'first',
                  child: Text('First'),
                ),
                RadioCard<String>(
                  value: 'second',
                  child: Text('Second'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Second'));
      await tester.pump();

      expect(selected, 'first');
    });
  });
}
