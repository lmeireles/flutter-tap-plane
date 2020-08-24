import 'dart:ui';
import 'dart:math';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/flame/custom-body-component.dart';

import '../utils.dart';

class Obstacle {
  static const LIST_LENGTH = 4;

  Map<String, ObstacleComponent> map = new Map();

  Obstacle(box2d) {
    for( var i = 0 ; i < LIST_LENGTH; i++ ) {
      map.putIfAbsent("${i}down", () => new ObstacleComponent(box2d, i, 'down', this));
      map.putIfAbsent("${i}up", () => new ObstacleComponent(box2d, i, 'up', this));
    }
  }
}

class ObstacleComponent extends CustomBodyComponent {
  static const VELOCITY = 60.0;
  static const SPACING = 190;
  static const SPRITE_WIDTH = 48.0;
  static const SPRITE_HEIGHT = 346.0;

  String type;
  int order;
  double height;
  double width;
  Obstacle obstacle;
  ImagesLoader images = new ImagesLoader();
  Random rand = new Random();
  
  ObstacleComponent(box2d, order, type, obstacle) : super(box2d) {
    images.load('obstacle-grass', 'obstacles/grass-1.png');

    this.obstacle = obstacle;
    this.order = order;
    this.type = type;
    height = SPRITE_HEIGHT;
    width = SPRITE_WIDTH * height / SPRITE_HEIGHT;

    final shape = new PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.2;

    final bodyDef = new BodyDef();
    bodyDef.type = BodyType.STATIC;

    if (type == 'up') {
      double y = randomPosition();
      bodyDef.position = new Vector2(basicXStart(), y);
      this.obstacle.map.update("${order}down", (cmp) {
        cmp.body.setTransform(Vector2(basicXStart(), calculateLowerPosition(y)), 0);
        return cmp;
      });
    }

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  @override
  void update(double t) {
    if (body.position.x + width * 3 < -(viewport.width / 2 + width)) {
      if (type == 'up') {
        double x = body.position.x + (obstacle.map.length / 2) * (width + SPACING);

        body.setTransform(Vector2(x, body.position.y), 0);
        obstacle.map.update("${order}down", (cmp) {
          cmp.body.setTransform(Vector2(x, cmp.body.position.y), 0);
          return cmp;
        });
      }
    } else {
      body.setTransform(Vector2(body.position.x - VELOCITY * t, body.position.y), 0);
    }
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {
    if (images.isLoading) return;

    // white background
    //super.renderPolygon(canvas, points);

    paintImage(
      canvas: canvas,
      rect: new Rect.fromPoints(points[0], points[2]),
      image: images.get('obstacle-grass'),
      fit: BoxFit.fill,
    );
  }

  double basicXStart() => (viewport.width / 2) + (width + SPACING) * order;
  double randomPosition() => ((viewport.height / 2 + height / 2) - rand.nextDouble() * (viewport.height / 1.2));
  double calculateLowerPosition(y) => y - SPACING - height;
}