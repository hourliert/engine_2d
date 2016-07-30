// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.renderer.engine;

import 'package:engine_2d/drawers.dart' show Drawer;
import 'package:engine_2d/game_objects.dart' show Entity, EntityType;
import 'package:engine_2d/stores.dart' show EntityStore;

class Renderer {
  Drawer _drawer;
  EntityStore _entityStore;

  Renderer(this._drawer, this._entityStore);

  void render() {
    _drawer.clearStage();
    _entityStore.data.forEach(_renderEntity);
  }

  void _renderEntity(Entity entity) {
    switch (entity.type) {
      case EntityType.circle:
        _drawer.drawCircle(entity);
        break;
    }
  }
}
