// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('browser')
library engine_2d.test.drawers.drawer;

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'basic_drawer.dart';

void main() {
  group('Drawer', () {
    BasicDrawer drawer;

    setUp(() {
      drawer = new BasicDrawer();

      when(drawer.destroyDom()).thenReturn(null);
    });

    test('.dispose() cleans up everything', () {
      drawer.dispose();
      verify(drawer.mock.destroyDom());
    });
  });
}
