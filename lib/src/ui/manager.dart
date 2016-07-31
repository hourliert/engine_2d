// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.ui.manager;

import 'dart:html';
import 'dart:async';

import 'package:engine_2d/common.dart';

class UiManager implements Disposable {
  Element _mountPoint;

  UiManager(this._mountPoint);

  Stream<MouseEvent> get onClick => _mountPoint.onClick;
  Stream<MouseEvent> get onMouseMove => _mountPoint.onMouseMove;

  @override
  void dispose() {}
}
