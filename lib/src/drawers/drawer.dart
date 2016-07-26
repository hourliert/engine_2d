library engine_2d.src.drawers.drawer;

import 'dart:html' show Element;
import 'dart:math' show Rectangle;

import 'package:engine_2d/game_objects.dart' show Circle;

abstract class Drawer {
  void createDom(Element parentElement);
  void destroyDom();
  void updateSize(Rectangle<int> boundaries);
  void clearStage();
  void drawCircle(Circle circle);
}
