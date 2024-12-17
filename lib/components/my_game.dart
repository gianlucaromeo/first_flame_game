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
  final ValueNotifier<int> secondsLeftToCompleteLevel = ValueNotifier(10);

  dart_async.Timer? _timesLeftTimer;
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
    final double width = screenSize.x > 600 ? 600 : screenSize.x;
    camera.viewport = FixedResolutionViewport(
      resolution: Vector2(width, screenSize.y),
    );

    // Add components
    await world.add(GradientBackground());
    player = Player(initialPosition: Vector2(-10, 0)); // Add player here
    await world.add(player);
    await world.addAll(createBoundaries());

    // Add enemies based on the level
    startTimer(level);

    // Timer that every sec decrements the seconds left to complete the level
    _timesLeftTimer = dart_async.Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeftToCompleteLevel.value > 0) {
        secondsLeftToCompleteLevel.value--;
      } else {
        final currentHighestLevel = UserData.getLevelsCompleted();
        final newHighestLevel = max(currentHighestLevel, level);
        UserData.setLevelsCompleted(newHighestLevel);
      }
    });
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
      secondsLeftToCompleteLevel.value = 0;
      onGameOver(score.value);
      UserData.incrementTotalGamesPlayed();
      _timesLeftTimer?.cancel();
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
    final currentHeight = camera.visibleWorldRect.height;
    await world.add(
      Enemy(
        initialPosition: Vector2(
          camera.visibleWorldRect.right,
          camera.visibleWorldRect.top + Random().nextDouble() * currentHeight,
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
