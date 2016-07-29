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
      {this.position,
      this.type,
      this.speed: 0.5,
      this.angle: 0,
      this.color: 'black'});

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
