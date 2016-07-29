@TestOn('vm || browser')
library engine_2d.test.physic.ballistic_engine;

import 'dart:math' show Point, PI;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:engine_2d/physic.dart';
import 'package:engine_2d/stores.dart';
import 'package:engine_2d/game_objects.dart';

import 'physic_mock.dart';

void main() {
  group('BallisticEngine', () {
    PhysicEngine engine;
    EntityStore store;
    Circle aloneCircle;

    setUp(() {
      store = new MockEntityStore();
      engine = new BallisticEngine(store);
      aloneCircle = new Circle(
          position: new Point<int>(100, 0),
          speed: 0.5,
          angle: 0,
          radius: 4,
          color: 'black');

      when(store.entities).thenReturn([aloneCircle]);
    });

    test('.nextPositions() computes the next position of all entities', () {
      engine.updateBoundaries(1000, 1000);
      engine.nextPositions(const Duration(milliseconds: 100));

      expect(aloneCircle.position, equals(new Point<int>(150, 0)));
      expect(aloneCircle.speed, inClosedOpenRange(0, 1));
      expect(aloneCircle.angle, inClosedOpenRange(0, 2 * PI));
    });

    test('.nextPositions() broadcasts when an entity hits a border', () {
      engine.updateBoundaries(120, 120);

      // ignore: STRONG_MODE_DOWN_CAST_COMPOSITE
      engine.onEntityHitBorder.listen(expectAsync((Entity e) {
        expect(e.position, equals(new Point<int>(150, 0)));
        expect(e.speed, inClosedOpenRange(0, 1));
        expect(e.angle, inClosedOpenRange(0, 2 * PI));
      }, count: 1));

      engine.nextPositions(const Duration(milliseconds: 100));
    });
  });
}
