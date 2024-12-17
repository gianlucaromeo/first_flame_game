import 'package:first_flame_game/player.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';


class Enemy extends BodyComponent<MyGame> with ContactCallbacks {
  final double radius;
  final Color color;
  final Vector2 initialPosition;
  final double speed; // Speed multiplier

  Enemy({
    required this.initialPosition,
    this.radius = 3,
    this.color = Colors.red,
    this.speed = 40, // Default speed
  });

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: initialPosition,
      type: BodyType.kinematic,
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
  void update(double dt) {
    super.update(dt);

    if (position.x < camera.visibleWorldRect.left - 10) {
      removeFromParent();
      // game.addEnemy();
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Player) {
      removeFromParent();
      game.finishGame();
    }
  }
}
