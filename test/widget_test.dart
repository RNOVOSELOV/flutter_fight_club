import 'package:flutter_test/flutter_test.dart';

import 'lesson_1/task_1.dart';
import 'lesson_1/task_2.dart';
import 'lesson_1/task_3.dart';
import 'lesson_1/task_4.dart';
import 'lesson_1/task_5.dart';

void main() {
  group('l02h01', () => runTestLesson1Task1());
  group('l02h02', () => runTestLesson1Task2());
  group('l02h03', () => runTestLesson1Task3());
  group('l02h04', () => runTestLesson1Task4());
  group('l02h05', () => runTestLesson1Task5());
}
