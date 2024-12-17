import 'dart:async' as dart_async;
import 'dart:math';

import 'package:first_flame_game/components/enemy.dart';
import 'package:first_flame_game/components/gradient_background.dart';
import 'package:first_flame_game/services/local_storage_service.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'player.dart';
import 'wall.dart';

class MyGame extends Forge2DGame with TapCallbacks {
  final Function(int) onGameOver;
  final ValueNotifier<int> score = ValueNotifier(0);

  bool isGameOver = false;
  final int level;

  late final Player player;

  MyGame({required this.onGameOver, required this.level})
      : super(
          gravity: Vector2(0, 10.0),
          camera: CameraComponent(),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Get screen size
    final screenSize = size;

    // Adjust camera to fit the screen size dynamically
    camera.viewport = FixedResolutionViewport(
      resolution: Vector2(screenSize.x, screenSize.y),
    );

    // Add components
    await world.add(GradientBackground());
    player = Player(initialPosition: Vector2(-10, 0)); // Add player here
    await world.add(player);
    await world.addAll(createBoundaries());

    // Add enemies based on the level
    startTimer(level);
  }

  dart_async.Timer? _timer;

  void startTimer(int level) {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    switch (level) {
      case 1:
        _timer = dart_async.Timer.periodic(const Duration(milliseconds: 1400), (timer) {
          addEnemy();
        });
        break;
      case 2:
        _timer = dart_async.Timer.periodic(const Duration(milliseconds: 900), (timer) {
          addEnemy();
        });
        break;
      case 3:
        _timer = dart_async.Timer.periodic(const Duration(milliseconds: 400), (timer) {
          addEnemy();
        });
        break;
      default:
        break;
    }
  }

  void finishGame() {
    if (!isGameOver) {
      onGameOver(score.value);
      UserData.incrementTotalGamesPlayed();
    }
    isGameOver = true;
  }

  void incrementScore() {
    score.value++;
    if (UserData.getBestScore() < score.value) {
      UserData.setBestScore(score.value);
    }
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

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    player.body.setAwake(true);
    player.body.applyLinearImpulse(Vector2(0, -1000));
    player.body.applyAngularImpulse(360);
  }
}
