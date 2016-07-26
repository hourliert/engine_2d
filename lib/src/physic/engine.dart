library engine_2d.src.physic.engine;

import 'dart:math' show Rectangle, MutableRectangle;
import 'dart:async' show Stream, StreamController;

import 'package:meta/meta.dart' show protected;

import 'package:engine_2d/game_objects.dart' show Entity;

/// Manages the game physic
///
/// It computes scene bullet position according to a pseudo ballistic trajectory
abstract class PhysicEngine {
  @protected
  MutableRectangle<int> boundaries;

  @protected
  StreamController<Rectangle<int>> onResizeController;

  @protected
  StreamController<Entity> onEntityHitBorderStreamController;

  /// Creates a physic engine
  ///
  /// A [BulletStore] and a [Scene] must be injected into it.
  PhysicEngine() {
    boundaries = new MutableRectangle<int>(0, 0, 0, 0);

    onResizeController = new StreamController<Rectangle<int>>.broadcast();
    onEntityHitBorderStreamController =
        new StreamController<Entity>.broadcast();
  }

  int get width => boundaries.width;
  int get height => boundaries.height;

  Stream<Entity> get onEntityHitBorder =>
      onEntityHitBorderStreamController.stream;
  Stream<Rectangle<int>> get onResize => onResizeController.stream;

  void updateBoundaries(int width, int height) {
    boundaries.width = width;
    boundaries.height = height;

    onResizeController.add(boundaries);
  }

  void nextPositions(Duration timeBudget);
}
