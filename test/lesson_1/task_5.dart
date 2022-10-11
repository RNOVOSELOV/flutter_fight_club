import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// 5. Добавить колонки с пятью единицами
///    Добавить колонку с единичками под You и под Enemy. Это наши будущие
///    жизни.
///    (2 балла - обязательное)
///
/// - Добавить колонку сверху, под You. Добавить туда 5 единичек, чтобы равнение
///   было по центру. Тоже самое сделать под Enemy. Макет смотрите в Фигме.
///

void runTestLesson1Task5() {
  testWidgets('module5', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final List<Text> widgetsWithLegs = tester.widgetList<Text>(find.text("1")).toList();
    expect(widgetsWithLegs.length, 10);
  });
}
