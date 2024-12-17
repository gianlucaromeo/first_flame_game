import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({super.key, required this.text,});

  final String text;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Text(
      text,
      style: GoogleFonts.pressStart2p(
        textStyle: TextStyle(
          fontSize: deviceSize.width > 640 ? 36 :  deviceSize.width * 0.04,
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
      textAlign: TextAlign.center,
    );
  }
}
