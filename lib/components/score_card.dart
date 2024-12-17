import 'package:first_flame_game/widgets/game_text.dart';
import 'package:first_flame_game/widgets/game_title.dart';
import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
    required this.level,
    required this.secondsLeftToCompleteLevel,
  });

  final ValueNotifier<int> score;
  final ValueNotifier<int> secondsLeftToCompleteLevel;
  final int level;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: score,
      builder: (context, score, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
          child: Column(
            children: [
              GameTitle(text: 'Level $level'),
              const SizedBox(height: 24),
              GameText(
                text: 'SCORE : $score'.toUpperCase(),
              ),
              const SizedBox(height: 12),
              secondsLeftToCompleteLevel.value == 0
                  ? GameText(
                      text: 'Level Complete!',
                    )
                  : Text(
                      '${secondsLeftToCompleteLevel.value} more seconds to complete !'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
