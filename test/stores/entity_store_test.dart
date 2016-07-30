// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('vm || browser')
library engine_2d.test.stores.entity_store;

import 'dart:math' show Point, Rectangle;

import 'package:test/test.dart';

import 'package:engine_2d/stores.dart';
import 'package:engine_2d/game_objects.dart';

void main() {
  group('EntityStore', () {
    EntityStore store;
    Circle aloneCircle;

    setUp(() {
      aloneCircle = new Circle(
          position: new Point<int>(100, 0),
          speed: 0.5,
          angle: 0,
          radius: 4,
          color: 'black');
      store = new EntityStore();

      store.add(aloneCircle);
    });

    test('.inBoundaries retrieves the entity in boundaries', () {
      expect(store.inBoundaries(new Rectangle<int>(0, 0, 150, 150)),
          equals(<Entity>[aloneCircle]));
    });

    test('.inBoundaries retrieves no entities in boundaries', () {
      expect(store.inBoundaries(new Rectangle<int>(0, 0, 50, 50)),
          equals(<Entity>[]));
    });
  });
}
