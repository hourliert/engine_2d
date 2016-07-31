// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.physic.bouncing_box_engine;

import 'dart:math';

import 'package:engine_2d/physic.dart' show PhysicEngine;
import 'package:engine_2d/stores.dart' show EntityStore;
import 'package:engine_2d/game_objects.dart' show Entity;

/// Manages the game physic
///
/// It computes scene bullet position according to a pseudo ballistic trajectory
class BouncingBoxEngine extends PhysicEngine {
  EntityStore _entityStore;

  /// Creates a physic engine
  BouncingBoxEngine(this._entityStore);

  /// Computes the next bullet positions using a finit [timeBudget]
  @override
  void nextPositions(Duration timeBudget) {
    _entityStore.data.forEach((Entity b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Entity e, Duration timeBudget) {
    e.position += new Point<int>(
        (e.speed * timeBudget.inMilliseconds * cos(e.angle)).toInt(),
        (e.speed * timeBudget.inMilliseconds * -sin(e.angle)).toInt());

    if (!boundaries.containsPoint(e.position)) {
      if (e.position.x <= 0) {
        e.position = new Point<int>(1, e.position.y);
        e.angle = 3 * PI - e.angle;
      }
      if (boundaries.width <= e.position.x) {
        e.position = new Point<int>(boundaries.width - 2, e.position.y);
        e.angle = 3 * PI - e.angle;
      }
      if (e.position.y <= 0) {
        e.position = new Point<int>(e.position.x, 1);
        e.angle = 2 * PI - e.angle;
      }
      if (boundaries.height <= e.position.y) {
        e.position = new Point<int>(e.position.x, boundaries.height - 2);
        e.angle = 2 * PI - e.angle;
      }

      onEntityHitBorderStreamController.add(e);
    }
  }
}
