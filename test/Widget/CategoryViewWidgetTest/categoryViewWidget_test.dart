import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Category.dart';
import 'package:spending_tracker/Core/ViewModels/AppProvider.dart';
import 'package:spending_tracker/UI/Widgets/CategoryViewWidget/CategoryCard.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('test loading userCategoryCard and pressing the card', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    UserCategory uc = UserCategory();
    uc.id = 1;
    uc.name = "test";
    uc.icon = "Shopping";
    uc.colorOne = "red500";
    uc.colorTwo = "green500";
    uc.position = 0;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (ctx) => AppProvider()),
        ],
        child: Builder(
          builder: (BuildContext context) => MaterialApp(
            navigatorObservers: [mockObserver],
            home: Material(
              child: Container(
                height: 200,
                width: 200,
                child: CategoryCard(uc),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(icons["Shopping"]), findsOneWidget);
    expect(find.byType(AutoSizeText), findsNWidgets(2));
    expect(find.byType(InkWell), findsNWidgets(1));
    expect(find.text("Test"), findsOneWidget);
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    verify(mockObserver.didPush(any, any));
  });
}
