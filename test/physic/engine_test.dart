@TestOn('vm || browser')
library engine_2d.test.physic.engine;

import 'dart:async' show Stream;
import 'dart:math' show Rectangle;

import 'package:test/test.dart';

import 'package:engine_2d/physic.dart';
import 'package:engine_2d/game_objects.dart';

import 'basic_engine.dart';

void main() {
  group('PhysicEngine', () {
    PhysicEngine engine;

    setUp(() {
      engine = new BasicEngine();
    });

    test('.width retrieves the right boundaries', () {
      expect(engine.width, equals(0));
    });

    test('.height retrieves the right boundaries', () {
      expect(engine.width, equals(0));
    });

    test('.onResize retrieves the resize stream', () {
      expect(engine.onResize, new isInstanceOf<Stream<Rectangle<int>>>());
    });

    test(
        '.onEntityHitBorderStreamController retrieves the entity hits border stream',
        () {
      expect(engine.onEntityHitBorder, new isInstanceOf<Stream<Entity>>());
    });

    test('.updateBoundaries() redefines the boundaries size and broadcast', () {
      // ignore: strong_mode_down_cast_composite
      engine.onResize.listen(expectAsync((Rectangle<int> boundaries) {
        expect(boundaries, equals(new Rectangle<int>(0, 0, 100, 100)));
      }, count: 1));

      engine.updateBoundaries(100, 100);
    });

    test('.dispose() cleans up everything', () {
      engine.dispose();

      // ignore: invalid_use_of_protected_member
      expect(engine.onResizeController.isClosed, isTrue);
      // ignore: invalid_use_of_protected_member
      expect(engine.onEntityHitBorderStreamController.isClosed, isTrue);
    });
  });
}
