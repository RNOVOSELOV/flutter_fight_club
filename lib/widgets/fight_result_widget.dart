import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult result;

  const FightResultWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  FightClubColors.captionYou,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyText),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  FightClubImages.youAvatar,
                  width: 92,
                  height: 92,
                ),
              ],
            ),
            Container(
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(22),
                color: result.color,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              alignment: Alignment.center,
              child: Text(
                result.result.toLowerCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: FightClubColors.whiteText, fontSize: 16),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  FightClubColors.captionEnemy,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: FightClubColors.darkGreyText),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  FightClubImages.enemyAvatar,
                  height: 92,
                  width: 92,
                )
              ],
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ]),
    );
  }
}
