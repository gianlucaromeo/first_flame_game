import 'package:first_flame_game/components/my_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GradientBackground extends Component with HasGameReference<MyGame> {
  final Paint _backgroundPaint;

  GradientBackground()
      : _backgroundPaint = Paint()
          ..shader = LinearGradient(
            colors: [Colors.black, Colors.purple.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromCircle(center: Offset.zero, radius: 25));

  @override
  void render(Canvas canvas) {
    // Draw the gradient to fill the entire canvas
    final gameWidth = game.camera.visibleWorldRect.width;
    final gameHeight = game.camera.visibleWorldRect.height;
    canvas.drawRect(
      // from top-left to bottom-right
      Rect.fromLTWH(
        - gameWidth / 2,
        - gameHeight / 2,
        gameWidth,
        gameHeight,
      ),
      _backgroundPaint,
    );
  }

  @override
  void update(double dt) {
    // No dynamic updates needed for a static gradient background
  }
}
