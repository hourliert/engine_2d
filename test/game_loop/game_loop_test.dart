// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('browser')
library engine_2d.test.game_loop;

import 'dart:async';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/physic.dart';
import 'package:engine_2d/game_loop.dart';

import 'game_loop_mock.dart';

void main() {
  group('GameLoop', () {
    Renderer renderer;
    PhysicEngine engine;
    GameLoop loop;

    setUp(() {
      renderer = new MockRenderer();
      engine = new MockPhysicEngine();
      loop = new GameLoop(renderer, engine);
    });

    tearDown(() {
      loop.dispose();
    });

    test('.dispose() cleans up everything', () {
      loop.dispose();
      expect(loop.isRunning, isFalse);
    });

    test('.start() starts the loop', () async {
      // ignore: unawaited_futures
      loop.start();

      await new Future<Null>.delayed(const Duration(milliseconds: 100), () {
        verify(engine.nextPositions(any));
        verify(renderer.render());
      });
    });

    test('.stop() interupts the loop', () {
      loop.stop();
      expect(loop.isRunning, isFalse);
    });
  });
}
