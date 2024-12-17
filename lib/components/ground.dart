import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';

import 'body_component_with_user_data.dart';

const _groundHeight = 7.0;

class Ground extends BodyComponentWithUserData {
  final double worldWidth;
  final double worldHeight;

  Ground({
    required this.worldWidth,
    required this.worldHeight,
    Color? color,
  }) : super(
          renderBody: false,
          bodyDef: BodyDef()
            ..position =
                Vector2(worldWidth / 2, worldHeight) // Centered horizontally
            ..type = BodyType.static,
          fixtureDefs: [
            FixtureDef(
              PolygonShape()..setAsBoxXY(worldWidth / 2, _groundHeight / 2),
              friction: 0.3,
            )
          ],
          children: [
            RectangleComponent(
              anchor: Anchor.center,
              size: Vector2(worldWidth, _groundHeight),
              position: Vector2(0, 0),
              paint: Paint()..color = color ?? const Color(0xFF808080),
            ),
          ],
        );
}
