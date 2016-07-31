// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.renderers.optimized_canvas;

import 'dart:developer';
import 'dart:html'
    show Element, CanvasElement, CanvasRenderingContext2D, ImageData;
import 'dart:math';

import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/drawers.dart' show Drawer;
import 'package:engine_2d/game_objects.dart' show Circle, Entity;

class OptimizedCanvasDrawer extends Drawer {
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  ImageData _imageData;
  List<int> _buffer;
  int _sw;
  int _sh;

  @override
  void createDom(Element parentElement) {
    _sw = parentElement.client.width;
    _sh = parentElement.client.height;

    _canvas = new CanvasElement(width: _sw, height: _sh);
    _ctx = _canvas.context2D;
    _imageData = _ctx.getImageData(0, 0, _sw, _sh);
    _buffer = _imageData.data;

    parentElement.append(_canvas);
  }

  @override
  void destroyDom() {
    _canvas.remove();
  }

  @override
  void updateSize(Rectangle<int> boundaries) {
    _sw = boundaries.width;
    _sh = boundaries.height;

    _canvas.width = _sw;
    _canvas.height = _sh;
  }

  @override
  void beforeRender() {
//    Timeline.timeSync('beforeRender', () {
    List<int> data = _imageData.data;

    for (int i = 0; i < _sw; i++) {
      for (int j = 0; j < _sh; j++) {
        int pixelIndex = i + j * _sw, compositeIndex = pixelIndex * 4;

        data[compositeIndex] = 0;
        data[compositeIndex + 1] = 0;
        data[compositeIndex + 2] = 0;
        data[compositeIndex + 3] = 0;
      }
    }
//    });
  }

  @override
  void afterRender() {
//    Timeline.timeSync('afterRender', () {
    _ctx.putImageData(_imageData, 0, 0);
//    });
  }

  @override
  void drawCircle(Circle circle) {
//    Timeline.timeSync('drawCircle', () {
    int x = circle.position.x, y = circle.position.y, r = circle.radius;
    Texture tex = circle.texture;
    List<int> textureBuffer = tex.buffer;

    for (int i = 0, ii = tex.width; i < ii; i++) {
      for (int j = 0, jj = tex.height; j < jj; j++) {
        int xInImage = x - r + i, yInImage = y - r + j;

        if (xInImage >= 0 &&
            yInImage >= 0 &&
            xInImage < _sw &&
            yInImage < _sh) {
          int index = (xInImage + yInImage * _sw) * 4;
          int textureIndex = (i + j * ii) * 4;

          _buffer[index] = textureBuffer[textureIndex];
          _buffer[index + 1] = textureBuffer[textureIndex + 1];
          _buffer[index + 2] = textureBuffer[textureIndex + 2];
          _buffer[index + 3] = textureBuffer[textureIndex + 3];
        }
      }
    }
//    });
  }

  @override
  void drawEntities(List<Entity> circles) {
//    Timeline.timeSync('drawCircle', () {
    for (Circle circle in circles) {
      int x = circle.position.x, y = circle.position.y, r = circle.radius;
      Texture tex = circle.texture;
      List<int> textureBuffer = tex.buffer;

      for (int i = 0, ii = tex.width; i < ii; i++) {
        for (int j = 0, jj = tex.height; j < jj; j++) {
          int xInImage = x - r + i, yInImage = y - r + j;

          if (xInImage >= 0 &&
              yInImage >= 0 &&
              xInImage < _sw &&
              yInImage < _sh) {
            int pixelIndex = xInImage + yInImage * _sw,
                compositeIndex = pixelIndex * 4;
            int textureIndex = (i + j * ii) * 4;

            _buffer[compositeIndex] = textureBuffer[textureIndex];
            _buffer[compositeIndex + 1] = textureBuffer[textureIndex + 1];
            _buffer[compositeIndex + 2] = textureBuffer[textureIndex + 2];
            _buffer[compositeIndex + 3] = textureBuffer[textureIndex + 3];
          }
        }
      }
    }
//    });
  }
}
