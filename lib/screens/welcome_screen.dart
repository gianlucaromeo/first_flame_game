import 'package:first_flame_game/services/local_storage_service.dart';
import 'package:first_flame_game/widgets/game_button.dart';
import 'package:first_flame_game/widgets/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/game_text.dart';
import 'game_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.purple.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Statistics(),
              const SizedBox(height: 40),
              GameText(
                text: 'R E A D Y ?',
              ),
              const SizedBox(height: 40),
              for (var i = 1; i <= 3; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GameButton(
                    text: 'Level $i',
                    onPressed: () {
                      Get.to(() => GameScreen(level: i));
                    },
                    disabled: UserData.getLevelsCompleted() < i - 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
