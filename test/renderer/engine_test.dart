// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('browser')
library engine_2d.test.renderer.engine;

import 'dart:math' show Point;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/stores.dart';
import 'package:engine_2d/game_objects.dart';

import 'renderer_mock.dart';

void main() {
  group('Renderer', () {
    Renderer renderer;
    Drawer drawer;
    EntityStore store;
    Circle aloneCircle;

    setUp(() {
      drawer = new MockDrawer();
      store = new MockEntityStore();
      renderer = new Renderer(drawer, store);
      aloneCircle = new Circle(
          position: new Point<int>(10, 20),
          speed: 0.5,
          angle: 3,
          radius: 4,
          color: 'black');

      when(store.data).thenReturn(<Entity>[aloneCircle]);
    });

    test('.render() clears the stage and renders each entity', () {
      renderer.render();

      verify(drawer.beforeRender());
      verify(drawer.drawCircle(aloneCircle));
    });
  });
}
