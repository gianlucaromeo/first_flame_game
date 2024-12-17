import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../widgets/game_button.dart';

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
              Text(
                'G A M E\nO V E R',
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    fontSize: 40,
                    color: Colors.yellowAccent,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.purpleAccent,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Text(
                'Your score: $score',
                style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.purpleAccent,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45),
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
