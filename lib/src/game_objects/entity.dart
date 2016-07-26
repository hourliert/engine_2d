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
      num this.speed,
      num this.angle,
      String this.color});
}
