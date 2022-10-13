import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
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
              return Center(
                child: Text(snapshot.data!),
              );
            },
          ),
          const Expanded(child: SizedBox()),
          SecondaryActionButton(text: 'Statistics', onTap: () { print("Hello world!"); },),

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
}