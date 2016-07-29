// Copyright (c) 2016, Thomas Hourlier. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:engine_2d/engine_2d.dart';

main() {
  DivElement mountPoint = querySelector('#mount');
  SpanElement nbGo = querySelector('#nb_go');
  Random rng = new Random(123456789);

  Engine2d engine = new Engine2d(
      new EngineOptions(drawerType: DrawerType.CANVAS, mountPoint: mountPoint));

  engine.physic.onEntityHitBorder.listen((Entity e) {
    engine.store.remove(e);
    nbGo.setInnerHtml('${engine.store.entities.length}');
  });

  engine.ui.onClick.listen((MouseEvent e) {
    for (int i = 0; i < 50; i++) {
      Circle circle = new Circle(
          position: new Point<int>(e.client.x, e.client.y),
          speed: (rng.nextDouble() * 0.5) + 0.5,
          angle: rng.nextDouble() * 2 * PI,
          color: 'red',
          radius: 10);

      engine.store.add(circle);
    }

    nbGo.setInnerHtml('${engine.store.entities.length}');
  });

  engine.initialize();

  new Future.delayed(const Duration(seconds: 10), () {
    print('dispos');
    engine.dispose();
    engine = null;
  });
}
