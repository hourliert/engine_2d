// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.drawers.drawer;

import 'dart:html' show Element;
import 'dart:math' show Rectangle;

import 'package:engine_2d/common.dart';
import 'package:engine_2d/game_objects.dart' show Circle;

abstract class Drawer implements Disposable {
  void createDom(Element parentElement);
  void destroyDom();
  void updateSize(Rectangle<int> boundaries);
  void clearStage();
  void drawCircle(Circle circle);

  @override
  void dispose() {
    destroyDom();
  }
}
