import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// 3. Добавить подложку в виджет FightersInfo (1 балл)
///
/// Подложка с двумя цветами, каждый на пол экрана.
///
/// - Левая часть подложки должна быть белой.
/// - Правая часть подложки должна быть темно-фиолетовой.
/// - Цвета найти в Фигме!
///

void runTestLesson2Task3() {
  testWidgets('module3', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final List<Row> rowWidgets = tester
        .widgetList<Row>(find.descendant(of: find.byType(FightersInfo), matching: find.byType(Row)))
        .toList();
    final Row? rowWithTwoChildren = rowWidgets.firstWhereOrNull((e) => e.children.length == 2);
    expect(rowWithTwoChildren, isNotNull, reason: "Cannot find Row with needed colors");
    expect(rowWithTwoChildren!.crossAxisAlignment, CrossAxisAlignment.stretch);
    expect(
      rowWithTwoChildren.children[0],
      isInstanceOf<Expanded>(),
    );
    expect(
      (rowWithTwoChildren.children[0] as Expanded).child,
      isInstanceOf<ColoredBox>(),
    );
    expect(
      ((rowWithTwoChildren.children[0] as Expanded).child as ColoredBox).color,
      Colors.white,
    );

    expect(
      rowWithTwoChildren.children[1],
      isInstanceOf<Expanded>(),
    );
    expect(
      (rowWithTwoChildren.children[1] as Expanded).child,
      isInstanceOf<ColoredBox>(),
    );
    expect(
      ((rowWithTwoChildren.children[1] as Expanded).child as ColoredBox).color,
      Color(0xFFC5D1EA),
    );
  });
}
