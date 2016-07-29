library engine_2d.src.core.engine_options;

import 'dart:html';

import 'package:engine_2d/drawers.dart';

class EngineOptions {
  DrawerType drawerType;
  Element mountPoint;

  EngineOptions({this.mountPoint, this.drawerType: DrawerType.canvas});
}
