import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/flame/custom-body-component.dart';

import '../utils.dart';

class Plane extends CustomBodyComponent {
  static const VELOCITY = 30.0;
  static const NUMBER_OF_SPRITES = 3;

  double oldX = 0;
  double oldY = 0;
  double deltaChangeSprite = 0.0;
  int activeSprite = 1;
  String direction = 'neutral'; // down / neutral / up

  ImagesLoader images = new ImagesLoader();

  Plane(box2d) : super(box2d) {
    _loadImages();
    _createBody();
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = tileSize / 1.5;
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.01;
    fixtureDef.density = 0.03;

    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(-(viewport.width / 4), 0);
    bodyDef.bullet = true;
    bodyDef.type = BodyType.DYNAMIC;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void _loadImages() {
    images.load('plane-1-neutral', 'plane/plane-1.png');
    images.load('plane-2-neutral', 'plane/plane-2.png');
    images.load('plane-3-neutral', 'plane/plane-3.png');
    images.load('plane-1-up', 'plane/plane-1-up.png');
    images.load('plane-2-up', 'plane/plane-2-up.png');
    images.load('plane-3-up', 'plane/plane-3-up.png');
    images.load('plane-1-down', 'plane/plane-1-down.png');
    images.load('plane-2-down', 'plane/plane-2-down.png');
    images.load('plane-3-down', 'plane/plane-3-down.png');
  }

  void onTap() {
    Vector2 force = new Vector2(0, VELOCITY)..scale(175);
    body.applyLinearImpulse(force, center, true);
  }

  @override
  void update(double t) {
    if (deltaChangeSprite > 0.08) {
      activeSprite = activeSprite < NUMBER_OF_SPRITES ? ++activeSprite : 1;
      deltaChangeSprite = 0;
    } else {
      deltaChangeSprite += t;
    }

    if (oldY - body.position.y <= -0.9) {
      direction = 'up';
    }
    else if (oldY - body.position.y >= 0.9) {
      direction = 'down';
    } else {
      direction = 'neutral';
    }
    
    if (oldX < body.position.x) {
      body.applyTorque(10.0);
    } else {
      body.applyTorque(-10.0);
    }
    oldX = body.position.x;
    oldY = body.position.y;
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    if (images.isLoading) return;

    paintImage(
      canvas: canvas,
      rect: new Rect.fromCircle(center: center, radius: radius),
      image: images.get("plane-$activeSprite-$direction"),
      fit: BoxFit.fill,
    );
  }
}