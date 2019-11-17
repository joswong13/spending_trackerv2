import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/UI/Widgets/Dialog/AddTxDialogPickers.dart';

void main() {
  testWidgets('test date picker with null date', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  // presentDatePicker(context, null).then((resp) {
                  //   print(resp);
                  // });
                  presentDatePicker(context, null);
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('OK'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('OK'), findsOneWidget);
  });

  testWidgets('test one user category', (WidgetTester tester) async {
    UserCategory uc1 = UserCategory();
    uc1.id = 1;
    uc1.name = "Test";
    uc1.icon = "Food";

    List<UserCategory> ucList = [];
    ucList.add(uc1);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  categoryDialog(context, ucList, "Choose Category");
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Select Category'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Select Category'), findsOneWidget);
    expect(find.byType(SimpleDialogOption), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('test two user category', (WidgetTester tester) async {
    UserCategory uc1 = UserCategory();
    uc1.id = 1;
    uc1.name = "Test";
    uc1.icon = "Food";

    UserCategory uc2 = UserCategory();
    uc2.id = 2;
    uc2.name = "Test1";
    uc2.icon = "Pets";

    List<UserCategory> ucList = [];
    ucList.add(uc1);
    ucList.add(uc2);

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return RaisedButton(
                onPressed: () {
                  categoryDialog(context, ucList, "Choose Category");
                },
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Select Category'), findsNothing);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
    expect(find.text('Select Category'), findsOneWidget);
    expect(find.byType(SimpleDialogOption), findsNWidgets(2));
    expect(find.text('Test1'), findsOneWidget);
  });
}

//categoryDialog
