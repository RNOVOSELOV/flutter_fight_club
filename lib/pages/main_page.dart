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

class _MainPageContext extends StatefulWidget {
  @override
  State<_MainPageContext> createState() => _MainPageContextState();
}

class _MainPageContextState extends State<_MainPageContext> {
  late FightResult? fightResult;

  @override
  void initState() {
    super.initState();
    fightResult = null;
  }

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
              fightResult = FightResult.getFightResultByName(snapshot.data!);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Last fight result",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FightResultWidget(
                    result: fightResult!,
                  ),
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
            onTap: () async {
              final result = await Navigator.push<FightResult>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FightPage(),
                  ));
              setState(() {
                fightResult = result;
              });
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
