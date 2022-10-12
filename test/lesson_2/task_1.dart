import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/helpers.dart';

///
/// 1. Обновить цвета текстов (1 балл)
///    Цвета текстов в макетах обновлены. Обновить приложение
///
/// Все тексты темные теперь имеют один цвет.
///
/// Все тексты светлые также — один цвет.
/// Найти в Фигме и применить для всего проекта
///

void runTestLesson2Task1() {
  testWidgets('module1', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final Iterable<Text> allTextsWithGrey = [
      ...tester.widgetList(find.text("DEFEND")),
      ...tester.widgetList(find.text("ATTACK")),
      ...tester.widgetList(find.text("HEAD")),
      ...tester.widgetList(find.text("TORSO")),
      ...tester.widgetList(find.text("LEGS")),
      ...tester.widgetList(find.text("You")),
      ...tester.widgetList(find.text("Enemy")),
    ].cast<Text>();
    final Iterable<Color?> colorsOfTextsWithGrey =
        allTextsWithGrey.map((e) => e.style?.color).toSet().toList();
    expect(
      colorsOfTextsWithGrey.length,
      1,
      reason: 'количество уникальных цветов',
    );
    expect(
      colorsOfTextsWithGrey.first,
      isNotNull,
    );

    expect(
      colorsOfTextsWithGrey.first,
      const Color(0xFF161616),
    );

    final Iterable<Text> allTextsWithWhite = [
      ...tester.widgetList(find.text("GO")),
    ].cast<Text>();
    final List<Color?> colorsOfTextsWithWhite =
        allTextsWithWhite.map((e) => e.style?.color).toSet().toList();
    expect(colorsOfTextsWithWhite.length, 1);
    expect(colorsOfTextsWithWhite.first, isNotNull);

    expect(
      colorsOfTextsWithWhite.first,
      isOneOrAnother(const Color(0xDDFFFFFF), const Color(0xDEFFFFFF)),
    );
  });
}
