import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/container_checks.dart';
import '../shared/test_helpers.dart';
import '../shared/text_checks.dart';

///
/// 2. Создаем виджет SecondaryActionButton (2 балл)
///
/// Создаем новый виджет, на базе виджета с текстом STATISTICS с главного экрана
///
/// - Создать файл secondary_action_button.dart и положить его в папку widgets
/// - Создать внутри StatelessWidget с названием SecondaryActionButton
/// - Этот виджет должен выглядеть также, как и кнопка с текстом STATISTICS на
///   главном экране
/// - Этот виджет должен иметь обработчик нажатий GestureDetector, над виджетом
///   Container
/// - В виджет должно передаваться 2 параметра:
///   -- Обязательный параметр onTap типа VoidCallback
///   -- Обязательный параметр text типа String
/// - onTap параметр должен передаваться в onTap виджета GestureDetector
/// - text должен передаваться в Text и при этом текст должен приводиться к
///   UpperCase
/// - Заменить кнопку STATISTICS с главного экрана на этот созданный виджет
///

void runTestLesson3Task2() {
  testWidgets('module2', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryActionButton(onTap: () {}, text: "Statistics"),
        ),
      ),
    );

    final containerFinder = findTypeByTextOnlyInParentType(
        Container, "Statistics".toUpperCase(), SecondaryActionButton);

    final Container container = tester.widget<Container>(containerFinder);

    checkContainerEdgeInsetsProperties(
      container: container,
      margin: EdgeInsetsCheck(left: 16, right: 16),
    );
    checkContainerWidthOrHeightProperties(
      container: container,
      widthAndHeight: WidthAndHeight(width: null, height: 40),
      secondWidthAndHeight: WidthAndHeight(width: double.infinity, height: 40),
    );
    checkContainerAlignment(
      container: container,
      alignment: Alignment.center,
    );
    checkContainerBorder(
      container: container,
      border: Border.all(color: const Color(0xFF161616), width: 2),
    );

    expect(
      container.child,
      isInstanceOf<Text>(),
      reason: "Container should have child of Text type",
    );

    expect(
      (container.child as Text).data,
      "Statistics".toUpperCase(),
      reason: "Text should uppercased text",
    );

    expect(
      (container.child as Text).style,
      isNotNull,
      reason: "Text should have not null style",
    );

    checkTextProperties(
      textWidget: container.child as Text,
      textColor: const Color(0xFF161616),
    );

    await tester.pumpWidget(MyApp());

    final secondaryActionButtonFinder =
        findTypeByTextOnlyInParentType(SecondaryActionButton, "Statistics".toUpperCase(), Column);
    expect(
      secondaryActionButtonFinder,
      findsOneWidget,
      reason: "There are should be a SecondaryActionButton\n"
          "with text 'STATISTICS' in a top-level Column",
    );

    final gestureDetectorFinder = findTypeByTextOnlyInParentType(
        GestureDetector, "Statistics".toUpperCase(), SecondaryActionButton);
    expect(
      gestureDetectorFinder,
      findsOneWidget,
      reason: "There are should be a GestureDetector inside SecondaryActionButton",
    );
  });
}
