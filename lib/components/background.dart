import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/viewport.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

class Background extends BodyComponent{
  List<BackgroundComponent> list = new List();

  Background(Box2DComponent box2d) : super(box2d) {
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.STATIC;
    body = world.createBody(bodyDef);

    list.add(BackgroundComponent(viewport, 0));
    list.add(BackgroundComponent(viewport, 1));
  }

  @override
  void update(double t) {
    list.forEach((bg) => bg.update(t));
  }
  @override
  void render(Canvas canvas) {
    list.forEach((bg) => bg.render(canvas));
  }
}

class BackgroundComponent extends SpriteComponent {
  static const VELOCITY = 20.0;
  static const SPRITE_WIDTH = 800;
  static const SPRITE_HEIGHT = 480;

  Vector2 position;
  Viewport viewport;
  
  BackgroundComponent(Viewport viewport, order) : super() {
    this.viewport = viewport;
    height = viewport.height;
    width = SPRITE_WIDTH * height / SPRITE_HEIGHT;
    sprite = Sprite('bg/background.png');

    position = new Vector2(0 + (width * order), 0);
  }

  @override
  void update(double t) {
    if (position.x + width < 0){
      position.x = (position.x + width * 2) - VELOCITY * t;
    } else {
      position.x = position.x - VELOCITY * t;
    }
  }

  @override
  void render(Canvas canvas) {
    if (!loaded()) return;

    paintImage(
      canvas: canvas,
      rect: new Rect.fromLTWH(position.x, position.y, width, height),
      image: sprite.image,
      fit: BoxFit.fill,
    );
  }
}