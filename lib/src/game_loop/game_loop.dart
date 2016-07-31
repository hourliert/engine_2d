// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.game_loop;

import 'dart:html';
import 'dart:async';

import 'package:engine_2d/physic.dart';
import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/common.dart';

class GameLoop implements Disposable {
  Renderer _renderer;
  PhysicEngine _physicEngine;

  DateTime _lastFrameTime;

  bool _isRunning;

  GameLoop(this._renderer, this._physicEngine) {
    _isRunning = false;
  }

  bool get isRunning => _isRunning;

  Future<Null> start([num _]) async {
    if (isRunning) return;
    _isRunning = true;
    _lastFrameTime = new DateTime.now();

    Stream<num> animationFrameStream = _getAnimationFrameStream();

    await for (num _ in animationFrameStream) {
      if (!isRunning) {
        break;
      }

      DateTime now = new DateTime.now();
      Duration timeBudget = now.difference(_lastFrameTime);
      _lastFrameTime = now;

      _step(timeBudget);
    }
  }

  void stop() {
    _isRunning = false;
  }

  void _step(Duration timeBudget) {
    _physicEngine.nextPositions(timeBudget);
    _renderer.render();
  }

  Stream<num> _getAnimationFrameStream() async* {
    while (true) {
      yield await window.animationFrame;
    }
  }

  @override
  void dispose() {
    stop();
  }
}
