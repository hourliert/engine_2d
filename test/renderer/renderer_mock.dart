// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.test.renderer.mocks;

import 'package:mockito/mockito.dart';
import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/stores.dart';
import 'package:engine_2d/game_objects.dart';

class MockDrawer extends Mock implements Drawer {}

class MockEntityStore extends Mock implements EntityStore {}

class MockCircle extends Mock implements Circle {}
