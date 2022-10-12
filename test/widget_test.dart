import 'package:flutter_test/flutter_test.dart';

import 'lesson_2/task_1.dart';
import 'lesson_2/task_2.dart';
import 'lesson_2/task_3.dart';
import 'lesson_2/task_4.dart';
import 'lesson_2/task_5.dart';

void main() {
  group("l03h01", () => runTestLesson2Task1());
   group('l03h02', () => runTestLesson2Task2());
   group("l03h03", () => runTestLesson2Task3());
   group('l03h04', () => runTestLesson2Task4());
   group('l03h05', () => runTestLesson2Task5());
}
