import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/flame/custom-body-component.dart';

import '../utils.dart';

class Plane extends CustomBodyComponent {
  static const VELOCITY = 60.0;
  static const SPRITE_WIDTH = 88;
  static const SPRITE_HEIGHT = 73;

  ImagesLoader images = new ImagesLoader();
  double height;
  double width;

  Plane(box2d) : super(box2d) {
    _loadImages();

    height = tileSize;
    width = SPRITE_WIDTH * height / SPRITE_HEIGHT;

    final shape = new PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.2;

    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(- width / 2, -(viewport.height / 2) + height / 2);
    bodyDef.type = BodyType.STATIC;

    this.body = world.createBody(bodyDef)

      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void _loadImages() {
    images.load('plane-1', 'plane/plane-1.png');
    images.load('plane-2', 'plane/plane-2.png');
    images.load('plane-3', 'plane/plane-3.png');
  }

  @override
  void update(double t) {
    if (body.position.x + width / 2 < -(viewport.width)){
      body.setTransform(Vector2((body.position.x + width * 2) - VELOCITY * t, body.position.y), 0);
    } else {
      body.setTransform(Vector2(body.position.x - VELOCITY * t, body.position.y), 0);
    }
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {
    if (images.isLoading) return;

    paintImage(
      canvas: canvas,
      rect: new Rect.fromPoints(points[0], points[2]),
      image: images.get('ground-rock'),
      fit: BoxFit.fill,
    );
  }
}