import 'dart:developer';

import 'package:first_flame_game/components/ground.dart';
import 'package:first_flame_game/components/player.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'gradient_background.dart';

class MyGame extends Forge2DGame {
  MyGame({required this.onGameOver})
      : super(
          gravity: Vector2(0, 10.0),
          camera: CameraComponent.withFixedResolution(
            width: 800,
            height: 600,
          ),
        );

  final Function(int) onGameOver;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(GradientBackground());
    await add(
      Ground(
        worldWidth: 800,
        worldHeight: 600,
        color: Colors.blue,
      ),
    );
    await add(Player(Vector2(150, 600 - 20), Colors.black));

    log('Game loaded!', name: 'MyGame');
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isMounted) {
      // log('Game mounted -> updated!', name: 'MyGame');
    } else {
      log('Game not mounted!', name: 'MyGame');
    }
  }

  @override
  void onDispose() {
    pauseEngine(); // Pause the game before disposing
    onDetach(); // Detach all components to clean up
    super.onDispose(); // Dispose the engine

    log('Game disposed!', name: 'MyGame');
  }
}
