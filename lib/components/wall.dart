import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Wall extends BodyComponent {
  final Vector2 _start;
  final Vector2 _end;

  Wall(this._start, this._end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(_start, _end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Define the paint for the border
    final paint = Paint()
      ..color = Colors.purple.shade500
      ..strokeWidth = 2  // Adjust thickness
      ..style = PaintingStyle.stroke;

    // Draw a line between _start and _end points
    canvas.drawLine(
      Offset(_start.x, _start.y),
      Offset(_end.x, _end.y),
      paint,
    );
  }
}
