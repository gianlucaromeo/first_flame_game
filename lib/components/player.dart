import 'package:first_flame_game/components/my_game.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Player extends BodyComponent<MyGame> with TapCallbacks, ContactCallbacks {
  final Vector2 initialPosition;
  final Color color;
  late Paint _paint;
  bool _isGrounded = false;

  Player(this.initialPosition, this.color) {
    _paint = Paint()..color = color;
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: initialPosition,
      type: BodyType.dynamic,
      userData: this,
      fixedRotation: true, // Prevent rotation
    );

    final shape = PolygonShape()..setAsBoxXY(20, 20);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0 // No bouncing
      ..density = 5 // Increased density to fall faster
      ..friction = 0.7; // Increase friction to stop sliding

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Get the current body position and rotation
    final pos = body.position;
    final angle = body.angle;

    // Save canvas state before transformation
    canvas.save();

    // Translate and rotate the canvas to match the body
    canvas.translate(pos.x, pos.y);
    canvas.rotate(angle);

    // Draw the rectangle matching the physics body's dimensions
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: 20, // Slightly wider than physics body
      height: 20, // Slightly taller than physics body
    );
    canvas.drawRect(rect, _paint);

    // Restore canvas state
    canvas.restore();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Check if player is on the ground
    _isGrounded = _checkGrounded();

    // Add downward force to make falling faster
    body.applyForce(Vector2(0, body.mass * 480)); // Additional gravity
  }

  bool _checkGrounded() {
    // Check if the player is very close to the ground
    return body.position.y >= game.size.y - 30; // Adjust based on ground height
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Only allow jump if player is grounded
    if (_isGrounded) {
      // Apply a quick, moderate impulse for a fast, low jump
      body.applyLinearImpulse(Vector2(0, -25000000));
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    // Optional: Handle contact logic if needed
    // game.finishGame();
  }
}