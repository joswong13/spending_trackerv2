import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/FormWidgets/RaisedButtonWidget.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('test raised button icon widget', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (ctx) => AppProvider()),
        ],
        child: MaterialApp(
          navigatorObservers: [mockObserver],
          home: Material(
            child: Builder(
              builder: (BuildContext context) {
                // The builder function must return a widget.
                return emptyTransactionListAddButton(context, "Title");
              },
            ),
          ),
        ),
      ),
    );

    //Cannot find raisedbutton.icon
    expect(find.text('Title'), findsOneWidget);
    await tester.tap(find.text("Title"));
    await tester.pumpAndSettle();
    verify(mockObserver.didPush(any, any));
  });

  testWidgets('test capitalization', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              // The builder function must return a widget.
              return raisedButtonTextSize14("test");
            },
          ),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
  });
}
