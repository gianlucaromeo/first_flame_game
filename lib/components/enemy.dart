import 'dart:developer';

import 'package:first_flame_game/components/body_component_with_data.dart';
import 'package:first_flame_game/components/player.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Enemy extends BodyComponentWithUserData with ContactCallbacks {
  final double radius;
  final Color color;
  final Vector2 initialPosition;
  final double speed; // Speed multiplier

  Enemy({
    required this.initialPosition,
    this.radius = 3.0,
    this.color = Colors.red,
    this.speed = 40.0, // Default speed
  });

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
