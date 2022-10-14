import 'package:flutter_test/flutter_test.dart';

import 'lesson_3/task_1.dart';
import 'lesson_3/task_2.dart';
import 'lesson_3/task_3.dart';
import 'lesson_3/task_4.dart';

void main() {
  group("l04h01", () => runTestLesson3Task1());
   group("l04h02", () => runTestLesson3Task2());
   group("l04h03", () => runTestLesson3Task3());
   group("l04h04", () => runTestLesson3Task4());
}
