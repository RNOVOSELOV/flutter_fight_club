import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/helpers.dart';

///
/// 4. Сделать кнопку GO другого цвета для неактивного состояния
///    (1 балл - обязательное)
///
/// - Пока пользователь не нажмет на одну из кнопок с BodyPart для DEFEND и для
///   ATTACK, кнопка GO должна иметь серый цвет неактивного состояния.
/// - Если defendingBodyPart отсутствует, или же attackingBodyPart отсутствует,
///   то делать кнопку GO другого, серого цвета. Цвет найти в Фигме!
///

void runTestLesson1Task4() {
  testWidgets('module4', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final GestureDetector goButton = tester.widget(find.widgetWithText(GestureDetector, "GO"));
    expect(goButton, isNotNull);

    final gestureDetectorFinder =
        (text) => findTypeByTextOnlyInParentType(GestureDetector, text, Row);

    final List<GestureDetector> widgetsWithBodyParts =
        tester.widgetList<GestureDetector>(gestureDetectorFinder("HEAD")).toList();
    expect(widgetsWithBodyParts.length, 2);

    const Color unselectedButtonColor = Colors.black38;
    const Color unselectedButtonColor2 = Color(0x60000000);
    const Color selectedGoButtonColor = Colors.black87;
    const Color selectedGoButtonColor2 = Color(0xDE000000);

    final coloredBoxFinder = (text) => findTypeByTextOnlyInParentType(ColoredBox, text, Row);

    expect(
      tester.widget<ColoredBox>(coloredBoxFinder("GO")).color,
      isOneOrAnother(unselectedButtonColor, unselectedButtonColor2),
    );

    await tester.tap(gestureDetectorFinder("HEAD").first);
    await tester.pump();

    expect(
      tester.widget<ColoredBox>(coloredBoxFinder("GO")).color,
      isOneOrAnother(unselectedButtonColor, unselectedButtonColor2),
    );

    await tester.tap(gestureDetectorFinder("HEAD").last);
    await tester.pump();

    expect(
      tester.widget<ColoredBox>(coloredBoxFinder("GO")).color,
      isOneOrAnother(selectedGoButtonColor, selectedGoButtonColor2),
    );
  });
}
