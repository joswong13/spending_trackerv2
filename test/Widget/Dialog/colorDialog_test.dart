import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/ColorDialog.dart';

void main() {
  testWidgets('test color dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  colorDialog(context);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Select Color'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Select Color'), findsOneWidget);
  });
}
