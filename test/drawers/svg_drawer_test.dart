// Copyright Thomas Hourlier. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

@TestOn('browser')
library engine_2d.test.drawers.svg_drawer;

import 'dart:html';
import 'dart:svg' hide Point;
import 'dart:math' show Rectangle, Point;

import 'package:test/test.dart';

import 'package:engine_2d/drawers.dart';
import 'package:engine_2d/game_objects.dart';

void main() {
  group('SvgDrawer', () {
    Drawer drawer;
    DivElement parentContainer;

    setUp(() {
      parentContainer = new DivElement();

      parentContainer.style.width = '100px';
      parentContainer.style.height = '100px';

      querySelector('body').append(parentContainer);

      drawer = new SvgDrawer();
    });

    tearDown(() {
      parentContainer.remove();
    });

    tearDownAll(() {
      querySelectorAll('svg').forEach((Element e) => e.remove());
    });

    test('.createDom() initializes the DOM', () {
      drawer.createDom(parentContainer);

      SvgElement svg = parentContainer.firstChild;
      expect(querySelector('svg'), equals(svg));

      expect(svg.style.width, equals('100px'));
      expect(svg.style.height, equals('100px'));
    });

    test('.destroyDom() cleans up everything the DOM', () {
      drawer.createDom(parentContainer);
      drawer.destroyDom();

      SvgElement svg = parentContainer.firstChild;

      expect(svg, equals(null));
      expect(querySelector('svg'), equals(null));
    });

    group('With Dom Initialized', () {
      Function setupSvg = () {
        SvgElement svg = parentContainer.firstChild;

        for (int i = 0; i < 10; i++) {
          SvgElement svgCircle = new SvgElement.tag('circle')
            ..attributes['cx'] = i.toString()
            ..attributes['cy'] = i.toString()
            ..attributes['r'] = (2 * i).toString();

          svg.append(svgCircle);
        }
      };

      setUp(() {
        drawer.createDom(parentContainer);
      });

      tearDown(() {
        drawer.destroyDom();
      });

      test('.updateSizes() updates the DOM size', () {
        SvgElement svg = parentContainer.firstChild;
        Rectangle<int> boundaries = new Rectangle<int>(0, 0, 150, 120);

        drawer.updateSize(boundaries);

        expect(svg.style.width, equals('150px'));
        expect(svg.style.height, equals('120px'));
      });

      test('.clearStage() removes all svg child', () {
        SvgElement svg = parentContainer.firstChild;

        setupSvg();

        expect(svg.childNodes.length, equals(10));

        drawer.clearStage();

        expect(svg.childNodes.length, equals(0));
      });

      test('.drawCircle() adds a circle to the svg canvas', () {
        SvgElement svg = parentContainer.firstChild;
        int x = 10, y = 9, r = 3, s = 3, T = 3;

        drawer.drawCircle(new Circle(
            position: new Point<int>(x, y),
            radius: r,
            color: 'blue',
            speed: s,
            angle: T));

        SvgElement circle = svg.firstChild;

        expect(
            circle.attributes,
            equals(<String, String>{
              'cx': x.toString(),
              'cy': y.toString(),
              'fill': 'blue',
              'r': r.toString()
            }));
      });
    });
  });
}
