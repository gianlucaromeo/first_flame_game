import 'package:first_flame_game/widgets/game_button.dart';
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
              GameText(
                text: 'R E A D Y ?',
              ),
              const SizedBox(height: 40),
              GameButton(
                onPressed: () {
                  Get.to(() => const GameScreen());
                },
                text: 'START',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
