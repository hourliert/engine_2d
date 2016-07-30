// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('browser')
library engine_2d.test.drawers.canvas_drawer;

import 'dart:html';
import 'dart:math' show Rectangle, Point, pow;

import 'package:test/test.dart';

import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/game_objects.dart';

void main() {
  group('CanvasDrawer', () {
    Drawer drawer;
    DivElement parentContainer;

    setUp(() {
      parentContainer = new DivElement();

      parentContainer.style.width = '100px';
      parentContainer.style.height = '100px';

      querySelector('body').append(parentContainer);

      drawer = new CanvasDrawer();
    });

    tearDown(() {
      parentContainer.remove();
    });

    tearDownAll(() {
      querySelectorAll('canvas').forEach((Element e) => e.remove());
    });

    test('.createDom() initializes the DOM', () {
      drawer.createDom(parentContainer);

      CanvasElement canvas = parentContainer.firstChild;
      expect(querySelector('canvas'), equals(canvas));

      expect(canvas.width, 100);
      expect(canvas.height, 100);
    });

    test('.destroyDom() cleans up everything the DOM', () {
      drawer.createDom(parentContainer);
      drawer.destroyDom();

      CanvasElement canvas = parentContainer.firstChild;

      expect(canvas, equals(null));
      expect(querySelector('canvas'), equals(null));
    });

    group('With Dom Initialized', () {
      ImageData getImageData(CanvasElement canvas) {
        CanvasElement canvas = parentContainer.firstChild;
        CanvasRenderingContext2D ctx = canvas.context2D;
        int sw = canvas.width;
        int sh = canvas.height;

        return ctx.getImageData(0, 0, sw, sh);
      }

      setUp(() {
        drawer.createDom(parentContainer);
      });

      tearDown(() {
        drawer.destroyDom();
      });

      test('.updateSizes() updates the DOM size', () {
        CanvasElement canvas = parentContainer.firstChild;
        Rectangle<int> boundaries = new Rectangle<int>(0, 0, 150, 120);

        drawer.updateSize(boundaries);

        expect(canvas.width, 150);
        expect(canvas.height, 120);
      });

      test('.clearStage() clears the stage', () {
        CanvasElement canvas = parentContainer.firstChild;

        drawer.clearStage();

        ImageData imageData = getImageData(canvas);
        List<int> data = imageData.data;
        int sw = imageData.width;
        int sh = imageData.height;

        for (int i = 0; i < sw; i++) {
          for (int j = 0; j < sh; j++) {
            int index = 4 * (i + j * sw);

            expect(data[index], equals(0));
            expect(data[index + 1], equals(0));
            expect(data[index + 2], equals(0));
            expect(data[index + 3], equals(0));
          }
        }
      });

      test('.drawCircle() adds a circle to the stage', () {
        CanvasElement canvas = parentContainer.firstChild;
        int x = 10, y = 9, r = 3, s = 3, T = 3;

        drawer.drawCircle(new Circle(
            position: new Point<int>(x, y),
            radius: r,
            color: 'red',
            speed: s,
            angle: T));

        ImageData imageData = getImageData(canvas);
        int sw = imageData.width;
        int sh = imageData.height;
        List<int> data = imageData.data;

        for (int i = 0; i < sw; i++) {
          for (int j = 0; j < sh; j++) {
            int index = 4 * (i + j * sw);

            if (pow((i - x).abs(), 2) + pow((j - y).abs(), 2) < pow(r, 2)) {
              expect(data[index], equals(255));
              expect(data[index + 1], equals(0));
              expect(data[index + 2], equals(0));
            }
          }
        }
      });
    });
  });
}
