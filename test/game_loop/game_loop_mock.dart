// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library engine_2d.test.game_loop.mocks;

import 'package:mockito/mockito.dart';
import 'package:engine_2d/renderer.dart';
import 'package:engine_2d/physic.dart';

class MockRenderer extends Mock implements Renderer {}

class MockPhysicEngine extends Mock implements PhysicEngine {}
