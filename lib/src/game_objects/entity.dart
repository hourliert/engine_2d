library engine_2d.src.game_object.entity;

import 'dart:math' show Point;

import 'package:engine_2d/game_objects.dart';

abstract class Entity {
  EntityType type;
  Point<num> position;
  num speed;
  num angle;
  String color;

  Entity(
      {Point<num> this.position,
      EntityType this.type,
      num this.speed: 0.5,
      num this.angle: 0,
      String this.color: 'black'});

  @override
  String toString() {
    return '''
      Entity:
      position: $position
      speed: $speed
      angle: $angle
      color: $color
    ''';
  }
}
