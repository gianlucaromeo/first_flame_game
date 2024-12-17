import 'dart:async' as dart_async;
import 'dart:math';

import 'package:first_flame_game/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'player.dart';
import 'wall.dart';

class MyGame extends Forge2DGame {
  final Function(int) onGameOver;

  MyGame({required this.onGameOver})
      : super(
          gravity: Vector2(0, 10.0),
          camera: CameraComponent.withFixedResolution(
            width: 800,
            height: 600,
          ),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport.add(FpsTextComponent());
    world.add(Player());
    world.addAll(createBoundaries());

    dart_async.Timer.periodic(const Duration(seconds: 1), (timer) {
      addEnemy();
    });
  }

  void finishGame() {
    onGameOver(0);
  }

  Future<void> addEnemy() async {
    await world.add(
      Enemy(
        initialPosition: Vector2(
          camera.visibleWorldRect.right,
          camera.visibleWorldRect.bottom - Random().nextInt(80).toDouble(),
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
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft),
    ];
  }
}
