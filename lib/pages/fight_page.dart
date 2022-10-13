import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FightPage extends StatefulWidget {
  @override
  State<FightPage> createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart._random();
  BodyPart whatEnemyDefends = BodyPart._random();

  int yourLives = maxLives;
  int enemiesLives = maxLives;

  String resultBlockText = FightClubColors.gameIsStartedInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
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
                      left: 16, right: 16, bottom: 30, top: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: ColoredBox(
                      color: FightClubColors.infoPanelBackgroundColor,
                      child: Center(
                          child: Text(
                            resultBlockText,
                            textAlign: TextAlign.center,
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
            ActionButton(
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
              text: _gameIsOver()
                  ? FightClubColors.endGame
                  : FightClubColors.goButtonMakeMove,
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
      return FightClubColors.blackButton;
    }
    return FightClubColors.greyButton;
  }

  void _onGoButtonClicked() {
    if (_gameIsOver()) {
      setState(() {
        Navigator.of(context).pop();
      });
    } else if (_bodyPartsIsChecked()) {
      setState(() {
        final bool enemyLooseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLooseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLooseLife) {
          enemiesLives--;
        }

        if (youLooseLife) {
          yourLives--;
        }

        final FightResult? fightResult =
        FightResult.calculateResult(yourLives, enemiesLives);
        if (fightResult != null) {
          SharedPreferences.getInstance().then((sharedPreferences) {
            sharedPreferences.setString(
                "last_fight_result", fightResult.result);

            final String key = "stats_${fightResult.result.toLowerCase()}";
            final int value = sharedPreferences.getInt(key) ?? 0;
            sharedPreferences.setInt(key, value + 1);
          });

          SharedPreferences.getInstance().then((spGetValue) {
            SharedPreferences.getInstance().then((spSetValue) =>
            {
             // spSetValue.setInt(spTag, spGetValue.getInt(spTag)!;)
            });
          });
        }

        resultBlockText = _calculateResultText(youLooseLife, enemyLooseLife);
        whatEnemyDefends = BodyPart._random();
        whatEnemyAttacks = BodyPart._random();
        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  String _calculateResultText(final bool youLooseLife,
      final bool enemyLooseLife) {
    if (yourLives == 0 && enemiesLives == 0) {
      return FightClubColors.resultDraw;
    } else if (yourLives == 0) {
      return FightClubColors.resultLost;
    } else if (enemiesLives == 0) {
      return FightClubColors.resultWon;
    } else {
      return "${_getAttackResult(enemyLooseLife)}\n${_getEnemyResult(
          youLooseLife)}";
    }
  }

  String _getAttackResult(bool enemyLooseLife) {
    if (enemyLooseLife) {
      return "${FightClubColors.attackDone} ${attackingBodyPart!.name
          .toLowerCase()}.";
    }
    return FightClubColors.attackBlocked;
  }

  String _getEnemyResult(bool youLooseLife) {
    if (youLooseLife) {
      return "${FightClubColors.enemyDone} ${whatEnemyAttacks.name
          .toLowerCase()}.";
    }
    return FightClubColors.enemyBlocked;
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

typedef FightersInfo = FightersInfoWidget;

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
    return SizedBox(
      height: 160,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Expanded(
                child: ColoredBox(
                  color: FightClubColors.youPartBackgroundColor,
                )),
            Expanded(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          FightClubColors.youPartBackgroundColor,
                          FightClubColors.enemyPartBackgroundColor
                        ])))),
            Expanded(
                child: ColoredBox(
                  color: FightClubColors.enemyPartBackgroundColor,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: yourLivesCount),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  FightClubColors.captionYou,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyText),
                ),
                const SizedBox(
                  height: 12,
                ),
                Image.asset(
                  FightClubImages.youAvatar,
                  width: 92,
                  height: 92,
                ),
              ],
            ),
            const SizedBox(
                width: 44,
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FightClubColors.blueButton,
                  ),
                  child: Center(
                    child: Text(
                      "vs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: FightClubColors.whiteText, fontSize: 16),
                    ),
                  ),
                )),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  FightClubColors.captionEnemy,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyText),
                ),
                const SizedBox(
                  height: 12,
                ),
                Image.asset(
                  FightClubImages.enemyAvatar,
                  height: 92,
                  width: 92,
                )
              ],
            ),
            LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: enemiesLivesCount),
          ],
        ),
      ]),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({Key? key,
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
              Text(FightClubColors.captionDefend.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyText)),
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
              Text(FightClubColors.captionAttack.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyText)),
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
  })
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding: EdgeInsets.only(top: (index == 0) ? 0 : 4),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: (index == 0) ? 0 : 4),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._(FightClubColors.captionHeadButton);
  static const torso = BodyPart._(FightClubColors.captionTorsoButton);
  static const legs = BodyPart._(FightClubColors.captionLegsButton);

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart _random() {
    return _values[
    Random(DateTime
        .now()
        .millisecondsSinceEpoch).nextInt(_values.length)];
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
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: selected ? FightClubColors.blueButton : Colors.transparent,
              border: Border.all(
                  color: selected
                      ? Colors.transparent
                      : FightClubColors.darkGreyText,
                  width: 2)),
          child: Center(
              child: Text(bodyPart.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: selected
                          ? FightClubColors.whiteText87
                          : FightClubColors.darkGreyText))),
        ),
      ),
    );
  }
}
