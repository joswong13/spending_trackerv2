import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/Core/Constants/IconsLibrary.dart';
import 'package:spending_tracker/Core/Models/Stat.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/CategoryStats.dart';
import 'package:spending_tracker/UI/Widgets/StatsWidget/MonthlyStats.dart';

void main() {
  testWidgets('test month category container', (WidgetTester tester) async {
    // StatMonth statMonth = StatMonth(0.0, 0, DateTime.utc(2019, 8, 1));

    // await tester.pumpWidget(
    //   MaterialApp(
    //     home: Material(
    //       child: Directionality(
    //         textDirection: TextDirection.ltr,
    //         child: Container(
    //           width: 1080,
    //           height: 1920,
    //           child: Expanded(
    //             child: MonthlyStats(statMonth, 0.0),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // expect(find.text("\$0.00"), findsOneWidget);
  });
}
