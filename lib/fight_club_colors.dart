import 'dart:ui';

class FightClubColors {

  FightClubColors._();

  static const background = Color(0xFFD5DEF0);
  static const youPartBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const enemyPartBackgroundColor = Color.fromRGBO(197, 209, 234, 1);
  static const infoPanelBackgroundColor = enemyPartBackgroundColor;

  static const greyButton = Color.fromRGBO(0, 0, 0, 0.38);
  static const blueButton = Color.fromRGBO(28, 121, 206, 1);
  static const blackButton = Color.fromRGBO(0, 0, 0, 0.87);

  static const darkGreyText = Color.fromRGBO(22, 22, 22, 1);
  static const whiteText = Color.fromRGBO(255, 255, 255, 0.87);

  static const String gameIsStartedInfo = "The game is started!";

  static const String goButtonStartNewGame = "Start new Game";
  static const String goButtonMakeMove = "Go";

  static const String attackBlocked = "You attack was blocked.";
  static const String attackDone = "You hit enemy's";
  static const String enemyBlocked = "Enemy's attack was blocked.";
  static const String enemyDone = "Enemy hit your";

  static const String resultDraw = "Draw.";
  static const String resultWon = "You won.";
  static const String resultLost = "You lost.";

  static const String captionYou = "You";
  static const String captionEnemy = "Enemy";
  static const String captionDefend = "Defend";
  static const String captionAttack = "Attack";
  static const String captionHeadButton = "Head";
  static const String captionTorsoButton = "Torso";
  static const String captionLegsButton = "Legs";
}
