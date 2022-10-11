import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/helpers.dart';

///
/// 2. Стилизовать кнопки с BodyPart
///    Кнопки с частями тела в не нажатом состоянии должны иметь другой цвет
///    подложки
///    (1 балл - обязательное)
///
/// - Цвета кнопок с частями тела ("HEAD", "TORSO" и "LEGS" (см 6 задание)) в
///   не нажатом состоянии должны иметь корректный цвет бекграунда. Цвет найти
///   в Фигме!
///

void runTestLesson1Task2() {
  testWidgets('module2', (WidgetTester tester) async {
    const Color correctBackgroundColor = Colors.black38;
    const Color correctBackgroundColor2 = Color(0x60000000);
    await tester.pumpWidget(MyApp());

    final coloredBoxInButtonFinder =
        (text) => findTypeByTextOnlyInParentType(ColoredBox, text, BodyPartButton);

    final List<ColoredBox> widgetsWithButtons = [
      ...tester.widgetList(coloredBoxInButtonFinder("HEAD")),
      ...tester.widgetList(coloredBoxInButtonFinder("TORSO")),
      ...tester.widgetList(coloredBoxInButtonFinder("LEGS")),
    ].cast<ColoredBox>().toList();
    final Set<Color> allColors = widgetsWithButtons.map((e) => e.color).toSet();
    expect(allColors, isNotEmpty);
    expect(allColors.length, 1);
    expect(allColors.single, isOneOrAnother(correctBackgroundColor, correctBackgroundColor2));
  });
}
