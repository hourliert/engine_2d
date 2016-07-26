library engine_2d.src.stores.store;

class Store<T> {
  List<T> _store;

  EntityStore() {
    _store = new List<T>();
  }

  /// Gets the bullet list
  List<T> get entities => _store;

  /// Adds a bullet to the store
  void add(T b) {
    _store.add(b);
  }

  /// Removes the specified bullet from the store
  void remove(T b) {
    _store.remove(b);
  }
}
