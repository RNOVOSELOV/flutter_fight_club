import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// 4. Добавить по центру экрана темно-фиолетовый блок (1 балл)
///
/// Добавить по центру экрана ColoredBox с темно-фиолетовым фоном, используя виджет
/// Padding
///
/// Использовать виджет Padding для указания боковых отступов
///
/// Для того, чтобы виджет занял необходимое количество места,
/// воспользуйтесь виджетами Expanded и SizedBox. В SizedBox нужно догадаться
/// какие использовать размеры
///

void runTestLesson2Task4() {
  testWidgets('module4', (WidgetTester tester) async {
    void _testSizedBox(SizedBox sizedBox) {
      expect(sizedBox.width, double.infinity);
    }

    void _testPadding(Padding padding) {
      expect((padding.padding as EdgeInsets).left, 16);
      expect((padding.padding as EdgeInsets).right, 16);
    }

    void _testColoredBox(ColoredBox coloredBox) {
      expect(coloredBox.color, const Color(0xFFC5D1EA));
    }

    await tester.pumpWidget(MyApp());
    final SafeArea safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
    expect(safeArea.child, isInstanceOf<Column>());

    final Column topLevelColumn = safeArea.child as Column;
    final Widget? possiblyExpanded =
        topLevelColumn.children.firstWhereOrNull((element) => element is Expanded);
    expect(possiblyExpanded, isNotNull);
    expect(possiblyExpanded, isInstanceOf<Expanded>());
    final Expanded expanded = possiblyExpanded as Expanded;

    if (expanded.child is SizedBox) {
      final SizedBox sizedBox = expanded.child as SizedBox;

      _testSizedBox(sizedBox);

      expect(sizedBox.child, isInstanceOf<Padding>());
      final Padding padding = sizedBox.child as Padding;
      _testPadding(padding);

      expect(padding.child, isInstanceOf<ColoredBox>());
      _testColoredBox(padding.child as ColoredBox);
    } else {
      expect(expanded.child, isInstanceOf<Padding>());
      final Padding padding = expanded.child as Padding;
      _testPadding(padding);

      if (padding.child is SizedBox) {
        final SizedBox sizedBox = padding.child as SizedBox;
        _testSizedBox(sizedBox);

        expect(sizedBox.child, isInstanceOf<ColoredBox>());
        _testColoredBox(sizedBox.child as ColoredBox);
      } else {
        expect(padding.child, isInstanceOf<ColoredBox>());
        final ColoredBox coloredBox = padding.child as ColoredBox;
        _testColoredBox(coloredBox);

        expect(coloredBox.child, isInstanceOf<SizedBox>());

        _testSizedBox(coloredBox.child as SizedBox);
      }
    }
  });
}
