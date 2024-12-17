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

    // Set up the paint for the glowing effect
    _playerPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.purpleAccent, Colors.black],
        stops: [0.5, 1.0],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: 4))
      ..style = PaintingStyle.fill;
  }

  @override
  void onMount() {
    super.onMount();

    // DO NOT MOVE FROM HERE :)
    // This safely applies forces AFTER the body is initialized,
    // otherwise the game will crash for "LateInitializationError" of "body"
    body.applyLinearImpulse(Vector2(0, -1000));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw the player inner square ("circle..") with the glowing effect
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: 6,
        height: 6,
      ),
      _playerPaint,
    );

    // Add a border for a futuristic look
    final borderPaint = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: 6,
        height: 6,
      ),
      borderPaint,
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
