import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/MonthYearDialog.dart';

void main() {
  testWidgets('test error dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  monthSelector(context, 11, 2018, [2019, 2018]);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Select Month and Year'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Select Month and Year'), findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(2));
    expect(find.text('Nov'), findsOneWidget);
    expect(find.text('2018'), findsOneWidget);
  });
}
