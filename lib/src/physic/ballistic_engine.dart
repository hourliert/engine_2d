library engine_2d.src.physic.ballistic_engine;

import 'dart:math';

import 'package:engine_2d/physic.dart' show PhysicEngine;
import 'package:engine_2d/stores.dart' show EntityStore;
import 'package:engine_2d/game_objects.dart' show Entity;

/// Manages the game physic
///
/// It computes scene bullet position according to a pseudo ballistic trajectory
class BallisticEngine extends PhysicEngine {
  EntityStore _entityStore;

  /// Creates a physic engine
  BallisticEngine(this._entityStore);

  /// Computes the next bullet positions using a finit [timeBudget]
  @override
  void nextPositions(Duration timeBudget) {
    _entityStore.entities.forEach((Entity b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Entity e, Duration timeBudget) {
    e.position += new Point<int>(
        (e.speed * timeBudget.inMilliseconds * cos(e.angle)).toInt(),
        (e.speed * timeBudget.inMilliseconds * sin(e.angle)).toInt());
    // we slightly alter the bullet angle. we are using a gaussian function
    e.angle += exp(-pow((3 * e.speed - 3.5), 2)) / 10;
    // we slightly alter the bullet speed. we are using a linear function
    e.speed -= (e.speed - 0.1) / 90;

    if (!boundaries.containsPoint(e.position)) {
      onEntityHitBorderStreamController.add(e);
    }
  }
}
