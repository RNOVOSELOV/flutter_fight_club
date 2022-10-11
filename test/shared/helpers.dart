import 'package:flutter_test/flutter_test.dart';

Matcher isOneOrAnother(dynamic one, dynamic another) => OneOrAnotherMatcher(one, another);

class OneOrAnotherMatcher extends Matcher {
  final dynamic _one;
  final dynamic _another;

  const OneOrAnotherMatcher(this._one, this._another);

  @override
  Description describe(Description description) {
    return description
        .add('either ${_one.runtimeType}:<$_one> or ${_another.runtimeType}:<$_another>');
  }

  @override
  bool matches(Object? item, Map matchState) => item == _one || item == _another;
}

Finder findTypeByTextOnlyInParentType(
  final Type type,
  final String text,
  final Type parentType,
) {
  return find.descendant(
    of: find.byType(parentType),
    matching: find.ancestor(of: find.text(text), matching: find.byType(type)),
  );
}
