library engine_2d.test.renderer.mocks;

import 'package:mockito/mockito.dart';
import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/stores.dart';
import 'package:engine_2d/game_objects.dart';

class MockDrawer extends Mock implements Drawer {}

class MockEntityStore extends Mock implements EntityStore {}

class MockCircle extends Mock implements Circle {}
