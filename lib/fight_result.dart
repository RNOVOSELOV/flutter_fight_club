import 'package:flutter/rendering.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class FightResult {
  final String result;

  const FightResult._(this.result);

  static const won = FightResult._("Won");
  static const lost = FightResult._("Lost");
  static const draw = FightResult._("Draw");

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

  static Color getColor (FightResult result) {
    switch (result) {
      case FightResult.lost:
        return FightClubColors.lostColor;
      case FightResult.won:
        return FightClubColors.wonColor;
      case FightResult.draw:
      default:
        return FightClubColors.drawColor;
    }
  }

  @override
  String toString() {
    return 'FightResult{result: $result}';
  }
}