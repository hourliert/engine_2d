// Copyright (c) 2016, Thomas Hourlier. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';

import 'package:engine_2d/engine_2d.dart';

main() {
  DivElement mountPoint = querySelector('#mount');

  Engine2d engine = new Engine2d(
      new EngineOptions(drawerType: DrawerType.CANVAS, mountPoint: mountPoint));

  Circle circle = new Circle(
      position: new Point<int>(100, 100),
      speed: 0.5,
      angle: 1,
      color: 'black',
      radius: 4);

  engine.store.add(circle);
  engine.loop.start();
}
