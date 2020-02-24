import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/flame/custom-body-component.dart';

import '../utils.dart';

class Ground {
  static const LIST_LENGTH = 4;

  List<GroundComponent> list = new List(LIST_LENGTH);

  Ground(box2d) {
    for( var i = 0 ; i < LIST_LENGTH; i++ ) {
      list[i] = GroundComponent(box2d, i);
    }
  }
}

class GroundComponent extends CustomBodyComponent {
  static const VELOCITY = 60.0;
  static const SPRITE_WIDTH = 200;
  static const SPRITE_HEIGHT = 70;

  double height;
  double width;
  ImagesLoader images = new ImagesLoader();
  
  GroundComponent(box2d, position) : super(box2d) {
    images.load('ground-grass', 'ground/ground-grass.png');
    height = tileSize;
    width = SPRITE_WIDTH * height / SPRITE_HEIGHT;

    final shape = new PolygonShape();
    shape.setAsBoxXY(width / 2, height / 2);
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
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
      body.setTransform(Vector2((body.position.x + width * Ground.LIST_LENGTH) - VELOCITY * t, body.position.y), 0);
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
      image: images.get('ground-grass'),
      fit: BoxFit.fill,
    );
  }
}