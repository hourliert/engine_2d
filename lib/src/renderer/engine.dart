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
    _entityStore.entities.forEach(_renderEntity);
  }

  void _renderEntity(Entity entity) {
    switch (entity.type) {
      case EntityType.circle:
        _drawer.drawCircle(entity);
        break;
    }
  }
}
