import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fight_club_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      home: MyHomePage(),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.pressStart2pTextTheme(baseTheme.textTheme),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart._random();
  BodyPart whatEnemyDefends = BodyPart._random();

  int yourLives = maxLives;
  int enemiesLives = maxLives;

  String resultBlockText = "The game is started!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfoWidget(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemiesLivesCount: enemiesLives,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 30,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ColoredBox(
                  color: FightClubColors.infoPanelBackgroundColor,
                  child: Center(
                      child: Text(
                    resultBlockText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ),
              ),
            )),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
            ),
            const SizedBox(height: 14),
            GoButtonWidget(
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
              text: _gameIsOver() ? "Start new Game" : "Go",
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  bool _bodyPartsIsChecked() {
    return (attackingBodyPart != null && defendingBodyPart != null)
        ? true
        : false;
  }

  bool _gameIsOver() {
    return (yourLives == 0 || enemiesLives == 0);
  }

  Color _getGoButtonColor() {
    if (_gameIsOver() || _bodyPartsIsChecked()) {
      return FightClubColors.blackButtonColor;
    }
    return FightClubColors.greyButtonColor;
  }

  void _onGoButtonClicked() {
    if (_gameIsOver()) {
      setState(() {
        resultBlockText = "The game is started!";
        yourLives = maxLives;
        enemiesLives = maxLives;
      });
    } else if (_bodyPartsIsChecked()) {
      setState(() {
        String attackString = "";
        String enemyString = "";
        final bool enemyLooseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLooseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLooseLife) {
          enemiesLives--;
          attackString =
              "You hit enemy's ${attackingBodyPart?.name.toLowerCase()}";
        } else {
          attackString = "You attack was blocked.";
        }

        if (youLooseLife) {
          yourLives--;
          enemyString = "Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}";
        } else {
          enemyString = "Enemy's attack was blocked";
        }

        if (yourLives == 0 && enemiesLives == 0) {
          resultBlockText = "Done.";
        } else if (yourLives == 0) {
          resultBlockText = "You lost.";
        } else if (enemiesLives == 0) {
          resultBlockText = "You won.";
        } else {
          resultBlockText = "$attackString\n$enemyString";
        }

        whatEnemyDefends = BodyPart._random();
        whatEnemyAttacks = BodyPart._random();

        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (_gameIsOver()) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (_gameIsOver()) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class FightersInfoWidget extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemiesLivesCount;

  const FightersInfoWidget({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemiesLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LivesWidget(
              overallLivesCount: maxLivesCount,
              currentLivesCount: yourLivesCount),
          Column(
            children: const [
              SizedBox(
                height: 16,
              ),
              Text(
                "You",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: FightClubColors.darkGreyTextColor),
              ),
              SizedBox(
                height: 12,
              ),
              ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    height: 92,
                    width: 92,
                  )),
              SizedBox(
                height: 30,
              )
            ],
          ),
          SizedBox(
              width: 44, height: 44, child: ColoredBox(color: Colors.green)),
          Column(
            children: const [
              SizedBox(
                height: 16,
              ),
              Text(
                "Enemy",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: FightClubColors.darkGreyTextColor),
              ),
              SizedBox(
                height: 12,
              ),
              ColoredBox(
                  color: Colors.blue,
                  child: SizedBox(
                    height: 92,
                    width: 92,
                  )),
              SizedBox(
                height: 30,
              )
            ],
          ),
          LivesWidget(
              overallLivesCount: maxLivesCount,
              currentLivesCount: enemiesLivesCount),
        ],
      ),
    ]);
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget(
      {Key? key,
      required this.defendingBodyPart,
      required this.selectDefendingBodyPart,
      required this.attackingBodyPart,
      required this.selectAttackingBodyPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            children: [
              Text("Defend".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyTextColor)),
              const SizedBox(
                height: 13,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            children: [
              Text("Attack".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyTextColor)),
              const SizedBox(
                height: 13,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              const SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 16,
        )
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(overallLivesCount * 2 - 1, (index) {
        if (index % 2 != 0) {
          return const SizedBox(
            height: 4,
          );
        } else if (index < currentLivesCount * 2 - 1) {
          return Image.asset(
            FightClubIcons.heartFull,
            width: 18,
            height: 18,
          );
        } else {
          return Image.asset(
            FightClubIcons.heartEmpty,
            width: 18,
            height: 18,
          );
        }
      }),
    );
  }
}

class GoButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButtonWidget({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: const TextStyle(
                    color: FightClubColors.whiteTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart _random() {
    return _values[
        Random(DateTime.now().millisecondsSinceEpoch).nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButtonColor
              : FightClubColors.greyButtonColor,
          child: Center(
              child: Text(bodyPart.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: selected
                          ? FightClubColors.whiteTextColor
                          : FightClubColors.darkGreyTextColor))),
        ),
      ),
    );
  }
}
