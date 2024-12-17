import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.disabled = false,
  });

  final Function onPressed;
  final String text;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: disabled ? null : () => onPressed.call(),
      style: !disabled ? ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade700,
        padding: const EdgeInsets.symmetric(
          horizontal: 54,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        shadowColor: Colors.purpleAccent,
      )
      : null,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.pressStart2p(
          textStyle: disabled
              ? TextStyle(
                  fontSize:
                      deviceSize.width > 640 ? 36 : deviceSize.width * 0.04,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.purpleAccent,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                )
              : TextStyle(
                  fontSize:
                      deviceSize.width > 640 ? 36 : deviceSize.width * 0.04,
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
  }
}
