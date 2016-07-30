// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.src.stores.store;

class Store<T> {
  List<T> _store;

  Store() {
    _store = new List<T>();
  }

  /// Gets the bullet list
  List<T> get data => _store;

  /// Adds a bullet to the store
  void add(T b) {
    _store.add(b);
  }

  /// Removes the specified bullet from the store
  bool remove(T b) {
    return _store.remove(b);
  }
}
