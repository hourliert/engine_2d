// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.physic.engine;

import 'dart:math' show Rectangle, MutableRectangle;
import 'dart:async' show Stream, StreamController;

import 'package:meta/meta.dart' show protected;

import 'package:engine_2d/common.dart';
import 'package:engine_2d/game_objects.dart' show Entity;

/// Manages the game physic
///
/// It computes scene bullet position according to a pseudo ballistic trajectory
abstract class PhysicEngine implements Disposable {
  @protected
  StreamController<Rectangle<int>> onResizeController;

  @protected
  StreamController<Entity> onEntityHitBorderStreamController;

  MutableRectangle<int> _boundaries;

  /// Creates a physic engine
  PhysicEngine() {
    _boundaries = new MutableRectangle<int>(0, 0, 0, 0);

    onResizeController = new StreamController<Rectangle<int>>.broadcast();
    onEntityHitBorderStreamController =
        new StreamController<Entity>.broadcast();
  }

  Rectangle<int> get boundaries => _boundaries;

  Stream<Entity> get onEntityHitBorder =>
      onEntityHitBorderStreamController.stream;
  Stream<Rectangle<int>> get onResize => onResizeController.stream;

  void updateBoundaries(int width, int height) {
    _boundaries.width = width;
    _boundaries.height = height;

    onResizeController.add(_boundaries);
  }

  void nextPositions(Duration timeBudget);

  @override
  void dispose() {
    onResizeController.close();
    onEntityHitBorderStreamController.close();
  }
}
