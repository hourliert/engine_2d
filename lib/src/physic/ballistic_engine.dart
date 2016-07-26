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
  ///
  /// A [BulletStore] and a [Scene] must be injected into it.
  BallisticEngine(this._entityStore);

  /// Computes the next bullet positions using a finit [timeBudget]
  void nextPositions(Duration timeBudget) {
    _entityStore.entities.forEach((Entity b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Entity b, Duration timeBudget) {
    if (!boundaries.containsPoint(b.position)) {
      onEntityHitBorderStreamController.add(b);
    } else {
      b.position += new Point<int>(
          (b.speed * timeBudget.inMilliseconds * cos(b.angle)).toInt(),
          (b.speed * timeBudget.inMilliseconds * sin(b.angle)).toInt());
      // we slightly alter the bullet angle. we are using a gaussian function
      b.angle += exp(-pow((3 * b.speed - 3.5), 2)) / 10;
      // we slightly alter the bullet speed. we are using a linear function
      b.speed -= (b.speed - 0.1) / 90;
    }
  }
}
