import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/flame/custom-body-component.dart';

import '../utils.dart';

class Background {
  List<BackgroundComponent> list = new List();

  Background(box2d) {
    list.add(BackgroundComponent(box2d, 0));
    list.add(BackgroundComponent(box2d, 1));
  }
}

class BackgroundComponent extends CustomBodyComponent {
  static const VELOCITY = 20.0;
  static const SPRITE_WIDTH = 800;
  static const SPRITE_HEIGHT = 480;

  double height;
  double width;
  ImagesLoader images = new ImagesLoader();
  
  BackgroundComponent(box2d, position) : super(box2d) {
    images.load('background', 'bg/background.png');
    height = viewport.height;
    width = SPRITE_WIDTH * height / SPRITE_HEIGHT;

    final shape = new PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.friction = 0.2;

    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2((-(viewport.width / 2) + width / 2) + (width * position), -(viewport.height / 2) + height / 2);
    bodyDef.type = BodyType.STATIC;

    this.body = world.createBody(bodyDef)

      ..createFixtureFromFixtureDef(fixtureDef);
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
      image: images.get('background'),
      fit: BoxFit.fill,
    );
  }
}