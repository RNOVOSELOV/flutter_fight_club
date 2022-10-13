import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea (child: Column(
        children: [
          const SizedBox(height: 24,),
          const Center(
            child: Text("Statistics", textAlign: TextAlign.center, style:
              TextStyle (
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),),
          ),
          const Expanded(child: SizedBox()),
          SecondaryActionButton(text: "Back", onTap: () {Navigator.of(context).pop();}),
          SizedBox(height: 16,)
        ],
      ),

      ),
    );
  }
}
