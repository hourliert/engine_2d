// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('vm || browser')
library engine_2d.test.game_objects.circle;

import 'dart:math' show Point;

import 'package:test/test.dart';

import 'package:engine_2d/game_objects.dart';

void main() {
  group('Circle', () {
    Circle entity;

    setUp(() {
      entity = new Circle(
          position: new Point<int>(10, 10),
          speed: 1,
          angle: 3,
          color: 'blue',
          radius: 5);
    });

    test('.type returns the correct entity type', () {
      expect(entity.type, equals(EntityType.circle));
    });
  });
}
