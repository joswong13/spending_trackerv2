import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/HeaderCard.dart';

void main() {
  testWidgets('test with title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: HeaderCard(DateTime.utc(2019, 1, 1), DateTime.utc(2019, 12, 1), 128.88, 4),
          ),
        ),
      ),
    );

    expect(find.byType(Text), findsNWidgets(3));
    expect(find.text('\$128.88'), findsNWidgets(1));
    expect(find.text('4 Transaction(s)'), findsNWidgets(1));
    expect(find.text('Jan 2019 - Dec 2019'), findsNWidgets(1));
  });
}
