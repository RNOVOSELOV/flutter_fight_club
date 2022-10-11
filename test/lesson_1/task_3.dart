import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/helpers.dart';

///
/// 3. Снимать выделение при нажатии на кнопку GO
///    Если выделены часть тела в DEFEND и часть тела в ATTACK, скидывать
///    выделение по нажатию на кнопку GO.
///    (1 балл - обязательное)
///
/// - Если выделены обе части тела, и для DEFEND (defendingBodyPart) и для
///   ATTACK (attackingBodyPart), то при нажатии на кнопку GO скидывать
///   выделенные значения (приравнивать их к нулю).
///

void runTestLesson1Task3() {
  testWidgets('module3', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final GestureDetector goButton = tester.widget(find.widgetWithText(GestureDetector, "GO"));
    expect(goButton, isNotNull);
    final List<GestureDetector> widgetsWithBodyParts =
        tester.widgetList<GestureDetector>(find.widgetWithText(GestureDetector, "HEAD")).toList();
    expect(widgetsWithBodyParts.length, 2);

    const Color selectedButtonColor = Color.fromRGBO(28, 121, 206, 1);

    final coloredBoxInGestureDetectorFinder =
        (text) => findTypeByTextOnlyInParentType(ColoredBox, text, GestureDetector);

    final Color unselectedButtonColor =
        tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").first).color;

    await tester.tap(find.widgetWithText(GestureDetector, "HEAD").first);
    await tester.pump();

    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").first).color,
      selectedButtonColor,
    );
    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").last).color,
      unselectedButtonColor,
    );

    await tester.tap(find.widgetWithText(GestureDetector, "GO"));
    await tester.pump();

    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").first).color,
      selectedButtonColor,
    );
    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").last).color,
      unselectedButtonColor,
    );

    await tester.tap(coloredBoxInGestureDetectorFinder("HEAD").last);
    await tester.pump();

    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").first).color,
      selectedButtonColor,
    );
    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").last).color,
      selectedButtonColor,
    );

    await tester.tap(find.widgetWithText(GestureDetector, "GO"));
    await tester.pump();

    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").first).color,
      unselectedButtonColor,
    );
    expect(
      tester.widget<ColoredBox>(coloredBoxInGestureDetectorFinder("HEAD").last).color,
      unselectedButtonColor,
    );
  });
}
