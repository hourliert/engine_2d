// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:engine_2d/engine_2d.dart';

void main() {
  DivElement mountPoint = querySelector('#mount');
  int sw = mountPoint.client.width;
  int sh = mountPoint.client.height;
  SpanElement nbGo = querySelector('#nb_go');
  Random rng = new Random(123456789);

  Engine2d engine = new Engine2d(new EngineOptions(
      drawerType: DrawerType.optimizedCanvas, mountPoint: mountPoint));

//  engine.physic.onEntityHitBorder.listen((Entity e) {
//    engine.store.remove(e);
//    nbGo.setInnerHtml('${engine.store.data.length}');
//  });

  Texture circleTexture =
      engine.renderer.createCircleTexture(new Circle(radius: 10, color: 'red'));

  engine.ui.onClick.listen((MouseEvent e) {
    for (int i = 0; i < 1; i++) {
      Circle circle = new Circle(
          position: new Point<int>(e.client.x, e.client.y),
          speed: (rng.nextDouble() * 0.5) + 0.5,
          angle: rng.nextDouble() * 2 * PI,
          radius: 10,
          color: 'red',
          texture: circleTexture);

      engine.store.add(circle);
    }

    nbGo.setInnerHtml('${engine.store.data.length}');
  });

  window.onKeyPress.listen((KeyboardEvent e) {
    if (e.keyCode == KeyCode.P) {
      if (engine.loop.isRunning) {
        engine.loop.stop();
      } else {
        engine.loop.start();
      }
    }
  });

  Stream<int> generator =
      new Stream<int>.periodic(const Duration(milliseconds: 30), (int _) {
    for (int i = 0; i < 5; i++) {
      Circle circle = new Circle(
          position: new Point<int>(rng.nextInt(sw), rng.nextInt(sh)),
          speed: 0.5,
          angle: rng.nextDouble() * 2 * PI,
          radius: 10,
          color: 'red',
          texture: circleTexture);

      engine.store.add(circle);
    }

    nbGo.setInnerHtml('${engine.store.data.length}');
  });

  generator.listen((int _) {});

  engine.initialize();
}
