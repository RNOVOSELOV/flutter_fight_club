import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../shared/container_checks.dart';
import '../shared/test_helpers.dart';
import '../shared/text_checks.dart';

///
///  4. Сверстать экран StatisticsPage (3 балл)
///
/// Сверстать новый экран сообразно макетам
///
/// - Верхнеуровневым виджетом в StatisticsPageдолжен быть Scaffold
/// - Scaffold должен иметь безопасную зону с отступами. Использовать SafeArea
/// - Сама страница должна Column c тремя виджетами:
///   -- с текстом сверху экрана
///   -- с кнопкой снизу экрана типа SecondaryActionButton.
///   -- с растягивающим виджетом по центру
/// - Не используйте свойство Column mainAxisAlignment:
///   MainAxisAlignment.spaceBetween.
/// - Верхний виджет должен быть Container'ом. В качестве child у него должен
///   быть Text:
///   -- Стиль текста должен быть сообразно макету.
///   -- Для создания корректных отступов около текста используйте свойства
///      Container'а
///   -- Потомком контейнера должен быть Text с текстом и стилем из макета Figma
/// - Нижний виджет должен быть виджетом Padding:
///   -- Потомком Padding'а должен быть SecondaryButtonWidget
///   -- Для создания корректных отступов около текста используйте свойства
///      Padding'а
///   -- Текст на кнопке должен быть "BACK". Передавайте в SecondaryButtonWidget
///      текст не капсом!
/// - При нажатии на кнопку BACK мы должны возвращаться обратно на MainPage
///

void runTestLesson3Task4() {
  testWidgets('module4', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final secondaryActionButtonFinder =
        findTypeByTextOnlyInParentType(SecondaryActionButton, "Statistics".toUpperCase(), Column);

    expect(
      find.byType(MainPage),
      findsOneWidget,
      reason: "First page should be MainPage",
    );

    expect(
      secondaryActionButtonFinder,
      findsOneWidget,
      reason: "There are should be a SecondaryActionButton with text 'Statistics' in Column",
    );

    await tester.tap(secondaryActionButtonFinder);
    await tester.pumpAndSettle();

    expect(
      find.byType(StatisticsPage),
      findsOneWidget,
      reason: "Statistics should be opened after tap on 'STATISTICS' button",
    );
    final columnFinder = findTypeByTextOnlyInParentType(Column, "Statistics", StatisticsPage);

    expect(
      columnFinder,
      findsOneWidget,
      reason: "There should be a Column widget",
    );

    final Column column = tester.widget(columnFinder);

    expect(
      column.children.first,
      isInstanceOf<Container>(),
      reason: "First widget in Column should be Container",
    );

    final containerWithTitle = column.children.first as Container;

    checkContainerEdgeInsetsProperties(
      container: containerWithTitle,
      paddingOrMargin: EdgeInsetsCheck(top: 24),
    );

    expect(
      containerWithTitle.child,
      isInstanceOf<Text>(),
      reason: "Container's child should be of Text type",
    );

    checkTextProperties(
      textWidget: containerWithTitle.child as Text,
      text: "Statistics",
      textColor: const Color(0xFF161616),
      fontSize: 24,
    );

    final Widget lastWidgetInColumn = column.children.last;
    expect(
      lastWidgetInColumn,
      isInstanceOf<Padding>(),
      reason: "Last widget in Column should have type of Padding",
    );
    expect(
      (lastWidgetInColumn as Padding).padding,
      isInstanceOf<EdgeInsets>(),
      reason: "Padding should have padding property type of EdgeInsets",
    );
    expect(
      (lastWidgetInColumn.padding as EdgeInsets).bottom,
      16,
      reason: "Padding should have bottom padding of 16",
    );
    expect(lastWidgetInColumn.child, isNotNull, reason: "Padding should have not null child");

    final Widget paddingChild = lastWidgetInColumn.child!;
    expect(
      paddingChild,
      isInstanceOf<SecondaryActionButton>(),
      reason: "Padding's child should have type of SecondaryActionButton",
    );
    final SecondaryActionButton secondaryActionButton = paddingChild as SecondaryActionButton;
    expect(
      secondaryActionButton.text,
      "Back",
      reason: "SecondaryActionButton should have text 'Back'",
    );

    await tester.tap(find.text("BACK"));
    await tester.pumpAndSettle();

    expect(
      find.byType(MainPage),
      findsOneWidget,
      reason: "After tapping on Back we should be return to the MainPage",
    );
  });
}
