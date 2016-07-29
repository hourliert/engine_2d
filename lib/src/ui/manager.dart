library engine_2d.src.ui.manager;

import 'dart:html';
import 'dart:async';

import 'package:engine_2d/common.dart';

class UiManager implements Disposable {
  Element _mountPoint;

  StreamController<MouseEvent> _onClickController;

  StreamSubscription<MouseEvent> _onClickSubscription;

  UiManager(this._mountPoint) {
    _onClickController = new StreamController<MouseEvent>.broadcast();

    _onClickSubscription = _mountPoint.onClick.listen(_onClick);
  }

  Stream<MouseEvent> get onClick => _onClickController.stream;

  void _onClick(MouseEvent e) {
    _onClickController.add(e);
  }

  @override
  void dispose() {
    _onClickSubscription.cancel();
    _onClickController.close();
  }
}
