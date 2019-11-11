import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spending_tracker/UI/Widgets/CommonWidgets/TopTextButtonStack.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockObserver = MockNavigatorObserver();

  testWidgets('test with title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: TopTextButtonStack(title: "Title"),
          ),
        ),
      ),
    );
    expect(find.text("Title"), findsOneWidget);
  });

  testWidgets('test back button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [mockObserver],
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: TopTextButtonStack(title: "Title"),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    verify(mockObserver.didPush(any, any));
  });
}
