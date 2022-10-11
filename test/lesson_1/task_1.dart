import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';


///
/// 1. Обновить цвет страницы
///    Добавляем цвет бекграунда страницы
///    (1 балл - обязательное)
///
/// - Добавить цвет бекграунда страницы. Цвет фона найти в Фигме!
///


void runTestLesson1Task1() {
  testWidgets('module1', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(
      (tester.firstWidget(find.byType(Scaffold)) as Scaffold).backgroundColor,
      const Color.fromRGBO(213, 222, 240, 1),
      reason: "Виджет Scaffold имеет корректный цвет фона",
    );
  });
}
