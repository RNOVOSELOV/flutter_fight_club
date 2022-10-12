import 'package:flutter/material.dart';

import '../resources/fight_club_colors.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const ActionButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              color: FightClubColors.whiteText87,
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ),
      ),
    );
  }
}