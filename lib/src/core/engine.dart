library engine_2d.src.core.engine;

import 'package:engine_2d/core.dart';
import 'package:engine_2d/physic.dart';
import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/stores.dart';
import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/game_loop.dart';

class Engine2d {
  EntityStore _store;
  PhysicEngine _physicEngine;
  Renderer _renderer;
  Drawer _drawer;
  GameLoop _gameLoop;

  Engine2d(EngineOptions options) {
    switch (options.drawerType) {
      case DrawerType.CANVAS:
        _drawer = new CanvasDrawer();
        break;
      case DrawerType.SVG:
        _drawer = new SvgDrawer();
        break;
    }

    _drawer.createDom(options.mountPoint);

    _store = new EntityStore();
    _physicEngine = new BallisticEngine(_store);
    _renderer = new Renderer(_drawer, _store);
    _gameLoop = new GameLoop(_renderer, _physicEngine);
  }

  EntityStore get store => _store;
  GameLoop get loop => _gameLoop;
}
