import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Player extends BodyComponent with TapCallbacks {
  Player({Vector2? initialPosition})
      : super(
    fixtureDefs: [
      FixtureDef(
        PolygonShape()..setAsBoxXY(4, 4),
        restitution: 0.2,
        friction: 0.4,
      ),
    ],
    bodyDef: BodyDef(
      angularDamping: 0.8,
      position: initialPosition ?? Vector2.zero(),
      type: BodyType.dynamic,
    ),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    body.applyLinearImpulse(Vector2(0, -1000));
  }

  @override
  void update(double dt) {
    super.update(dt);
    body.applyLinearImpulse(Vector2(0, 10));
  }

  @override
  void onTapDown(_) {
    body.applyLinearImpulse(Vector2(0, -1000));
  }
}
