import 'dart:ui';
import 'package:flutter_tap_plane/tap-plane-game.dart';

class Plane {
  static const int SPEED = 9;
  final TapPlaneGame game;

  Rect planeRect;
  Paint planePaint;
  bool isAlive = true;
  bool isFalling = true;

  Plane(this.game, double x, double y) {
    //planeRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    planePaint = Paint();
    planePaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawRect(planeRect, planePaint);
  }

  void update(double t) {
//    if (isAlive) {
//      if (isFalling) {
//        planeRect = planeRect.translate(0, game.tileSize * SPEED * t);
//      } else {
//        planeRect = planeRect.translate(0, -(game.tileSize * SPEED * t));
//      }
//    }
  }

  void onTapDown() {
    isFalling = false;
  }

  void onTapUp() {
    isFalling = true;
  }
}