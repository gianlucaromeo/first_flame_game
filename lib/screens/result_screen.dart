import 'package:first_flame_game/widgets/game_text.dart';
import 'package:first_flame_game/widgets/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/game_button.dart';
import '../widgets/game_title.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Statistics(),
              const SizedBox(height: 80),
              GameTitle(
                text: 'G A M E\nO V E R',
              ),
              const SizedBox(height: 45),
              GameText(
                text: 'Your score: $score',
              ),
              const SizedBox(height: 80),
              GameButton(
                onPressed: () {
                  Get.back();
                },
                text: 'PLAY AGAIN',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
