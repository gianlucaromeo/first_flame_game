import 'package:first_flame_game/widgets/game_text.dart';
import 'package:first_flame_game/widgets/game_title.dart';
import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
    required this.level,
  });

  final ValueNotifier<int> score;
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
            ],
          ),
        );
      },
    );
  }
}
