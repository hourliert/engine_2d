// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('browser')
library engine_2d.test.game_loop;

import 'dart:html';
import 'dart:math';

import 'package:test/test.dart';

import 'package:engine_2d/engine_2d.dart';

void main() {
  group('Engine', () {
    Engine2d engine;
    DivElement parentContainer;

    setUp(() {
      parentContainer = new DivElement();

      parentContainer.style.width = '100px';
      parentContainer.style.height = '100px';

      querySelector('body').append(parentContainer);

      engine = new Engine2d(new EngineOptions(
          mountPoint: parentContainer, drawerType: DrawerType.canvas));
    });

    tearDown(() {
      parentContainer.remove();
    });

    test('.initialize() boots up everything', () {
      engine.initialize();

      expect(
          engine.physic.boundaries, equals(new Rectangle<int>(0, 0, 100, 100)));
      expect(querySelector('canvas'), equals(parentContainer.firstChild));
    });

    test('.dispose() cleans up everything', () {
      engine.initialize();
      engine.dispose();

      expect(engine.loop.isRunning, isFalse);
      expect(querySelector('canvas'), isNull);
    });
  });
}
