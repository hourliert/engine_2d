// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.core.engine_options;

import 'dart:html';

import 'package:engine_2d/drawers.dart';

class EngineOptions {
  DrawerType drawerType;
  Element mountPoint;

  EngineOptions({this.mountPoint, this.drawerType: DrawerType.canvas});
}
