import 'dart:async' as dart_async;
import 'dart:math';

import 'package:first_flame_game/components/enemy.dart';
import 'package:first_flame_game/components/gradient_background.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'player.dart';
import 'wall.dart';

class MyGame extends Forge2DGame {
  final Function(int) onGameOver;

  final ValueNotifier<int> score = ValueNotifier(0);

  MyGame({required this.onGameOver})
      : super(
          gravity: Vector2(0, 10.0),
          camera: CameraComponent(),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Get screen size
    final screenSize = size; // size is automatically provided by Flame

    // Adjust camera to fit the screen size dynamically
    camera.viewport = FixedResolutionViewport(
      resolution: Vector2(screenSize.x, screenSize.y),
    );

    // Add components
    await world.add(GradientBackground());
    await world.add(Player(initialPosition: Vector2(-10, 0)));
    await world.addAll(createBoundaries());

    dart_async.Timer.periodic(const Duration(seconds: 1), (timer) {
      addEnemy();
    });
  }

  void finishGame() {
    onGameOver(score.value);
  }

  void incrementScore() {
    score.value++;
  }

  Future<void> addEnemy() async {
    await world.add(
      Enemy(
        initialPosition: Vector2(
          camera.visibleWorldRect.right,
          camera.visibleWorldRect.bottom - Random().nextInt(100).toDouble(),
        ),
      ),
    );
  }

  List<Component> createBoundaries() {
    final visibleRect = camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    return [
      Wall(topLeft, topRight),
      Wall(bottomLeft, bottomRight),
    ];
  }
}
