// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.renderer.texture;

import 'dart:html';

class Texture {
  ImageData _imageData;
  List<int> _buffer;
  int _width;
  int _height;

  Texture(this._imageData) {
    _buffer = _imageData.data;
    _width = _imageData.width;
    _height = _imageData.height;
  }

  ImageData get imageData => _imageData;
  List<int> get buffer => _buffer;
  int get width => _width;
  int get height => _height;
}
