import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ErrorDialog.dart';

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
                  errorMsgDialog(context, "Error message test");
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Error empty catgory dialog'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Error message test'), findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(1));
  });

  testWidgets('test delete dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  errorEmptyCategoryDialog(context);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Please add Categories before adding transactions.'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Please add Categories before adding transactions.'), findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(2));
  });
}
