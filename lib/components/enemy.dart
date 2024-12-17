import 'dart:developer';

import 'package:first_flame_game/components/body_component_with_data.dart';
import 'package:first_flame_game/components/player.dart';
import 'package:first_flame_game/services/local_storage_service.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Enemy extends BodyComponentWithUserData with ContactCallbacks {
  final double radius;
  final Vector2 initialPosition;
  final double speed; // Speed multiplier
  late final Paint _enemyPaint;

  Enemy({
    required this.initialPosition,
    this.radius = 3.0,
    this.speed = 40.0, // Default speed
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Set up the paint for the glowing effect
    _enemyPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.greenAccent,
          Colors.black,
        ],
        stops: [0.4, 1.0],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius))
      ..style = PaintingStyle.fill;
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: initialPosition,
      type: BodyType.dynamic,
      userData: this,
      linearVelocity: Vector2(-speed, 0), // Faster movement
    );

    final shape = CircleShape()..radius = radius;
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0
      ..density = 1.0
      ..friction = 0.0;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw the glowing enemy ball
    canvas.drawCircle(
      Offset.zero,
      radius,
      _enemyPaint,
    );

    // Add a thin outline for extra detail
    final borderPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4;
    canvas.drawCircle(
      Offset.zero,
      radius,
      borderPaint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final halfWidth = game.camera.visibleWorldRect.width / 2;
    if (body.position.x < -halfWidth) {
      game.incrementScore();
      log('Enemy removed');
      world.remove(this);
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    log('Enemy contact');
    if (other is Player) {
      game.finishGame();
    }
    super.beginContact(other, contact);
  }
}
