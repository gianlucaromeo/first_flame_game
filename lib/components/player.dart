import 'package:first_flame_game/components/body_component_with_data.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Player extends BodyComponentWithUserData with TapCallbacks {
  late final Paint _playerPaint;

  Player({Vector2? initialPosition})
      : super(
          fixtureDefs: [
            FixtureDef(
              PolygonShape()..setAsBoxXY(3.5, 3.5),
              restitution: 0.2,
              friction: 0.4,
            ),
          ],
          bodyDef: BodyDef(
            angularDamping: 0.8,
            position: initialPosition ?? Vector2.zero(),
            type: BodyType.dynamic,
          ),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Set up the paint for the purple gradient effect
    _playerPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.purpleAccent, Colors.deepPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromCenter(
          center: Offset.zero,
          width: 14,
          height: 14,
        ),
      ) // Adjust size as needed
      ..style = PaintingStyle.fill;
  }

  @override
  void onMount() {
    super.onMount();

    // Apply an impulse to make the player move
    body.applyLinearImpulse(Vector2(0, -1000));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw the glowing rectangle with a gradient
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: 7, // Width of the rectangle
        height: 7, // Height of the rectangle
      ),
      _playerPaint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    body.applyLinearImpulse(Vector2(0, 10));

    final halfWidth = game.camera.visibleWorldRect.width / 2;
    if (body.position.x < -halfWidth || body.position.x > halfWidth) {
      game.finishGame();
    }
  }

  @override
  void onTapDown(_) {
    body.setAwake(true);
    body.applyLinearImpulse(Vector2(0, -1000));
    body.applyAngularImpulse(360);
  }
}
