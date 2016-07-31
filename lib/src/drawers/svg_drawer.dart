// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.renderers.svg;

import 'dart:html' show Element;
import 'dart:math' show Rectangle;
import 'dart:svg' show SvgElement;

import 'package:engine_2d/drawers.dart' show Drawer;
import 'package:engine_2d/game_objects.dart';

class SvgDrawer extends Drawer {
  SvgElement _svg;

  @override
  void createDom(Element parentElement) {
    _svg = new SvgElement.tag('svg');
    _svg.style.width = parentElement.client.width.toString();
    _svg.style.height = parentElement.client.height.toString();

    parentElement.append(_svg);
  }

  @override
  void destroyDom() {
    _svg.remove();
  }

  @override
  void updateSize(Rectangle<int> boundaries) {
    _svg.style.width = boundaries.width.toString();
    _svg.style.height = boundaries.height.toString();
  }

  @override
  void beforeRender() {
    while (_svg.hasChildNodes()) {
      _svg.firstChild.remove();
    }
  }

  @override
  void afterRender() {}

  @override
  void drawCircle(Circle circle) {
    SvgElement svgCircle = new SvgElement.tag('circle')
      ..attributes['cx'] = (circle.position.x).toString()
      ..attributes['cy'] = (circle.position.y).toString()
      ..attributes['r'] = circle.radius.toString()
      ..attributes['fill'] = circle.color;

    _svg.append(svgCircle);
  }

  @override
  void drawEntities(List<Entity> entities) {
    for (Circle circle in entities) {
      SvgElement svgCircle = new SvgElement.tag('circle')
        ..attributes['cx'] = (circle.position.x).toString()
        ..attributes['cy'] = (circle.position.y).toString()
        ..attributes['r'] = circle.radius.toString()
        ..attributes['fill'] = circle.color;

      _svg.append(svgCircle);
    }
  }
}
