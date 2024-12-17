import 'package:first_flame_game/services/local_storage_service.dart';
import 'package:first_flame_game/widgets/game_text.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          GameText(text: "Best Score: ${UserData.getBestScore()}"),
          const SizedBox(height: 20),
          GameText(text: "Total Games: ${UserData.getTotalGamesPlayed()}"),
        ],
      ),
    );
  }
}
