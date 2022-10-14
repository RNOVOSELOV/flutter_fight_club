import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/test_helpers.dart';

///
/// 3. Кнопка STATISTICS на главном экране должна открывать новую страницу
///    (1 балл)
///
/// Пользуемся навигацией
///
/// - По нажатию на эту кнопку мы должны переходить на StatisticsPage.
/// - StatisticsPage — StatelessWidget, который должен лежать в папке pages и в
///   файле statistics_page.dart
/// - Для переход на следующую страницу воспользоваться нужным методом у
///   NavigatorState
///

void runTestLesson3Task3() {
  testWidgets('module3', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final gestureDetectorFinder =
        findTypeByTextOnlyInParentType(GestureDetector, "Statistics".toUpperCase(), Column);
    expect(
      gestureDetectorFinder,
      findsOneWidget,
      reason: "There  should be a GestureDetector with text 'STATISTICS' in Column",
    );

    final GestureDetector gestureDetector = tester.widget(gestureDetectorFinder);
    expect(
      gestureDetector.onTap,
      isNotNull,
      reason: "GestureDetector should have not null onTap method",
    );

    await tester.tap(gestureDetectorFinder);
    await tester.pumpAndSettle();

    expect(
      find.byType(StatisticsPage),
      findsOneWidget,
      reason: "StatisticsPage should be opened after tap on 'STATISTICS' button",
    );

    expect(
      find.byType(MainPage, skipOffstage: false),
      findsOneWidget,
      reason: "MainPage should be in a tree but offstage",
    );
  });
}
