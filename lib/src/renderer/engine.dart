// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.renderer.engine;

import 'dart:developer';
import 'dart:html';
import 'dart:math';

import 'package:engine_2d/drawers.dart' show Drawer;
import 'package:engine_2d/game_objects.dart' show Entity, EntityType, Circle;
import 'package:engine_2d/stores.dart' show EntityStore;

import 'texture.dart';

class Renderer {
  Drawer _drawer;
  EntityStore _entityStore;

  Renderer(this._drawer, this._entityStore);

  Texture createCircleTexture(Circle c) {
    int radius = c.radius, size = radius * 2;

    CanvasElement shadow = new CanvasElement(width: size, height: size);
    CanvasRenderingContext2D ctx = shadow.context2D;

    ctx
      ..beginPath()
      ..arc(radius, radius, radius, 0, 2 * PI)
      ..fillStyle = c.color
      ..fill();

    ImageData imageData = ctx.getImageData(0, 0, size, size);

    return new Texture(imageData);
  }

  void render() {
//    Timeline.timeSync('render', () {
    _drawer.beforeRender();
    _drawer.drawEntities(_entityStore.data);
//    _entityStore.data.forEach(_renderEntity);
    _drawer.afterRender();
//    });
  }

  void _renderEntity(Entity entity) {
    switch (entity.type) {
      case EntityType.circle:
        _drawer.drawCircle(entity);
        break;
    }
  }
}
