import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/CategoryStats.dart';

void main() {
  testWidgets('test stat category card', (WidgetTester tester) async {
    StatCategory statCategory = StatCategory("Test", 0.0, 0, "Phone");

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: CategoryStat(statCategory),
          ),
        ),
      ),
    );

    expect(find.byIcon(icons["Phone"]), findsOneWidget);
    expect(find.byType(AutoSizeText), findsNWidgets(3));
    expect(find.text("Test"), findsOneWidget);
  });
}
