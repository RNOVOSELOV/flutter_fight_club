import 'package:flutter/rendering.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class FightResult {
  final String result;
  final Color color;

  const FightResult._(this.result, this.color);

  static const won = FightResult._("Won", FightClubColors.wonColor);
  static const lost = FightResult._("Lost", FightClubColors.lostColor);
  static const draw = FightResult._("Draw", FightClubColors.drawColor);

  static FightResult? calculateResult (final int yourLives, final int enemiesLives) {
    if (yourLives ==0 && enemiesLives == 0) {
      return draw;
    } else if (yourLives == 0) {
      return lost;
    } else if (enemiesLives == 0) {
      return won;
    }
    return null;
  }

  static const values = [won, lost, draw];

  static FightResult getFightResultByName(String s) {
    return values.firstWhere((element) => element.result == s);
  }

  @override
  String toString() {
    return 'FightResult{result: $result}';
  }
}