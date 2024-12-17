import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
  });

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: score,
      builder: (context, score, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
          child: Text(
            'S C O R E : $score'.toUpperCase(),
            style: GoogleFonts.pressStart2p(
              textStyle: TextStyle(
                fontSize: 24,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.purpleAccent,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
