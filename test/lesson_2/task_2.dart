import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/helpers.dart';

///
///  2. Создать Util Class с цветами (1 балл)
///
/// Вынести текущие цвета приложения в этот класс. Ссылаться на эти цвета
/// Создать файл: fight_club_colors.dart
/// Положить в папку lib
/// Название класса FightClubColors
///
/// В классе должно быть как минимум 6 цветов:
/// - background (цвет задника экрана)
/// - greyButton (цвет кнопки серой)
/// - blueButton (цвет кнопки синей)
/// - blackButton (цвет черной кнопки GO)
/// - darkGreyText (темно-серый цвет текста — все тексты!)
/// - whiteText (белый цвет текста)
///
/// Заменить все подходящие цвета в файле main.dart на цвета из этого класса
///

void runTestLesson2Task2() {
  testWidgets('module2', (WidgetTester tester) async {
    expect(
      FightClubColors.background,
      const Color.fromRGBO(213, 222, 240, 1),
    );
    expect(
      FightClubColors.greyButton,
      isOneOrAnother(Colors.black38, Color(0x60000000)),
    );
    expect(
      FightClubColors.blueButton,
      Color(0xFF1C79CE),
    );
    expect(
      FightClubColors.blackButton,
      isOneOrAnother(Colors.black87, Color(0xDE000000)),
    );
    expect(
      FightClubColors.darkGreyText,
      Color(0xFF161616),
    );

    expect(
      FightClubColors.whiteText,
      isOneOrAnother(Color(0xDDFFFFFF), Color(0xDEFFFFFF)),
    );
  });
}
