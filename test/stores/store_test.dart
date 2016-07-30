// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('vm || browser')
library engine_2d.test.stores.store;

import 'package:test/test.dart';

import 'package:engine_2d/stores.dart';

void main() {
  group('Store', () {
    Store<int> store;

    setUp(() {
      store = new Store<int>();
    });

    test('.data retrieves the store data', () {
      expect(store.data, equals(<int>[]));
    });

    test('.add() adds an int to the store', () {
      store.add(5);

      expect(store.data, equals(<int>[5]));
    });

    test('.remove() removes an int from the store', () {
      store.add(5);
      expect(store.remove(5), isTrue);

      expect(store.data, equals(<int>[]));
    });

    test('.remove() removes an undefined element', () {
      expect(store.remove(5), isFalse);
    });
  });
}
