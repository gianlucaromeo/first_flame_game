import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GradientBackground extends Component {
  final double borderWidth;
  final Color borderColor;

  GradientBackground({
    this.borderWidth = 4.0,
    this.borderColor = Colors.red,
  });

  late Vector2 canvasSize; // Useful for resizing

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, canvasSize.x, canvasSize.y);

    // Gradient fill
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.black, Colors.blueAccent], // Simulates a night sky
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    // Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRect(rect, gradientPaint);
    canvas.drawRect(rect, borderPaint);
  }

  @override
  void onGameResize(Vector2 size) {
    canvasSize = size;
    super.onGameResize(size);
  }
}
