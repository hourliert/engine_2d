// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.core.engine;

import 'dart:html' show Element;

import 'package:engine_2d/core.dart';
import 'package:engine_2d/physic.dart';
import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/stores.dart';
import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/game_loop.dart';
import 'package:engine_2d/common.dart';
import 'package:engine_2d/ui.dart';

class Engine2d implements Initializable, Disposable {
  EngineOptions _config;
  EntityStore _store;
  PhysicEngine _physicEngine;
  Renderer _renderer;
  Drawer _drawer;
  GameLoop _gameLoop;
  UiManager _uiManager;

  Engine2d(this._config) {
    switch (_config.drawerType) {
      case DrawerType.canvas:
        _drawer = new CanvasDrawer();
        break;
      case DrawerType.svg:
        _drawer = new SvgDrawer();
        break;
      case DrawerType.optimizedCanvas:
        _drawer = new OptimizedCanvasDrawer();
        break;
    }

    _store = new EntityStore();
    _physicEngine = new BouncingBoxEngine(_store);
    _renderer = new Renderer(_drawer, _store);
    _gameLoop = new GameLoop(_renderer, _physicEngine);
    _uiManager = new UiManager(_config.mountPoint);
  }

  EntityStore get store => _store;
  GameLoop get loop => _gameLoop;
  PhysicEngine get physic => _physicEngine;
  UiManager get ui => _uiManager;
  Renderer get renderer => _renderer;

  @override
  void initialize() {
    Element mountPoint = _config.mountPoint;

    _drawer.createDom(mountPoint);
    _physicEngine.updateBoundaries(
        mountPoint.client.width, mountPoint.client.height);
    _gameLoop.start();
  }

  @override
  void dispose() {
    _gameLoop.dispose();
    _drawer.dispose();
    _physicEngine.dispose();
    _uiManager.dispose();
  }
}
