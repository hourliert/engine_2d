library engine_2d.src.stores.entity_store;

import 'dart:math' show Rectangle;

import 'package:engine_2d/stores.dart' show Store;
import 'package:engine_2d/game_objects.dart' show Entity;

class EntityStore extends Store<Entity> {
  List<Entity> inBoundaries(Rectangle<num> boundaries) {
    return entities.where((Entity e) => boundaries.containsPoint(e.position));
  }
}
