// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.test.drawers.basic_drawer;

import 'dart:html' show Element;
import 'dart:math' show Rectangle;

import 'package:mockito/mockito.dart';

import 'package:engine_2d/drawers.dart' show Drawer;
import 'package:engine_2d/game_objects.dart' show Circle;

class BasicDrawer extends Drawer {
  Drawer _mock;

  BasicDrawer() {
    _mock = new MockBasicDrawer();
  }

  Drawer get mock => _mock;

  @override
  void beforeRender() {
    _mock.beforeRender();
  }

  @override
  void afterRender() {
    _mock.afterRender();
  }

  @override
  void createDom(Element parentElement) {
    _mock.createDom(parentElement);
  }

  @override
  void destroyDom() {
    _mock.destroyDom();
  }

  @override
  void drawCircle(Circle circle) {
    _mock.drawCircle(circle);
  }

  @override
  void updateSize(Rectangle<int> boundaries) {
    _mock.updateSize(boundaries);
  }
}

class MockBasicDrawer extends Mock implements BasicDrawer {}
