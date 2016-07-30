// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.renderers.canvas;

import 'dart:html' show Element, CanvasElement, CanvasRenderingContext2D;
import 'dart:math' show Rectangle, PI;

import 'package:engine_2d/drawers.dart' show Drawer;
import 'package:engine_2d/game_objects.dart' show Circle;

class CanvasDrawer extends Drawer {
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;

  @override
  void createDom(Element parentElement) {
    _canvas = new CanvasElement(
        width: parentElement.client.width, height: parentElement.client.height);
    _ctx = _canvas.context2D;

    parentElement.append(_canvas);
  }

  @override
  void destroyDom() {
    _canvas.remove();
  }

  @override
  void updateSize(Rectangle<int> boundaries) {
    _canvas.width = boundaries.width;
    _canvas.height = boundaries.height;
  }

  @override
  void clearStage() {
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
  }

  @override
  void drawCircle(Circle circle) {
    _ctx
      ..save()
      ..beginPath()
      ..arc(circle.position.x, circle.position.y, circle.radius, 0, 2 * PI)
      ..fillStyle = circle.color
      ..fill()
      ..restore();
  }
}
