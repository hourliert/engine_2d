// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.game_object.circle;

import 'dart:math' show Point;

import 'package:engine_2d/game_objects.dart';

class Circle extends Entity {
  num radius;

  Circle({Point<num> position, num speed, num angle, String color, this.radius})
      : super(
            position: position,
            type: EntityType.circle,
            speed: speed,
            angle: angle,
            color: color);

  @override
  String toString() {
    return '''
      Circle:
      position: $position
      speed: $speed
      angle: $angle
      color: $color
      radius: $radius
    ''';
  }
}
