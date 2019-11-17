import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/DeleteDialog.dart';

void main() {
  testWidgets('test delete dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  deleteDialog(context);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Delete this transaction?'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Delete this transaction?'), findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(2));
  });

  testWidgets('test delete category dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  deleteCategoryDialog(context);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(
        find.text(
            'Warning: Deleting this category will also delete all associated transactions for this category. Continue deleting this category?'),
        findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Warning: Deleting this category will also delete all associated transactions for this category. Continue deleting this category?'),
        findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(2));
  });
}
