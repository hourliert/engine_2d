library engine_2d.src.game_object.circle;

import 'dart:math' show Point;

import 'package:engine_2d/game_objects.dart';

class Circle extends Entity {
  num radius;

  Circle(
      {Point<num> position,
      num speed,
      num angle,
      String color,
      num this.radius})
      : super(
            position: position,
            type: EntityType.CIRCLE,
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
