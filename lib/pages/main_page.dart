import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _MainPageContext();
  }
}

class _MainPageContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              "The\nFight\nClub".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30, color: FightClubColors.darkGreyText),
            ),
          ),
          const Expanded(child: SizedBox()),
          FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((value) => value.getString("last_fight_result")),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox();
              }
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom:12),
                    child: Center(
                      child: Text("Last fight result", textAlign: TextAlign.center, style: TextStyle (
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ),
                  FightResultWidget(result: getFightResult(snapshot.data!),),
                ],
              );
            },
          ),
          const Expanded(child: SizedBox()),
          SecondaryActionButton(
            text: 'Statistics',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StatisticsPage()));
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ActionButton(
            text: "Start".toUpperCase(),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FightPage(),
              ));
            },
            color: FightClubColors.blackButton,
          ),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }

  FightResult? getFightResult(String s) {
    switch (s) {
      case "Lost":
        return FightResult.lost;
      case "Won":
        return FightResult.won;
      case "Draw":
        return FightResult.draw;
      default:
        return null;
    }
  }
  
}
