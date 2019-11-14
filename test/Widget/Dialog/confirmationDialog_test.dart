import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ConfirmationAlertDialog.dart';

void main() {
  testWidgets('test confirmation dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  confirmationDialog(context, "Confirm Dialog Test");
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Confirm Dialog Test'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Confirm Dialog Test'), findsOneWidget);
    expect(find.byType(FlatButton), findsNWidgets(2));
  });
}
