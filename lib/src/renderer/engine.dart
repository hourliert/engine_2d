library engine_2d.src.renderer.engine;

import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/game_objects.dart';
import 'package:engine_2d/stores.dart';

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
      case EntityType.CIRCLE:
        _drawer.drawCircle(entity);
        break;
    }
  }
}
