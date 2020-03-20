import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_tap_plane/tap-plane-world.dart';

class TapPlaneGame extends Game with TapDetector {
  static const TILES_PER_WIDTH = 9.0;

  final TapPlaneWorld tapPlaneWorld = new TapPlaneWorld();

  TapPlaneGame() {
    tapPlaneWorld.initializeWorld();
  }

  @override
  void render(Canvas canvas) {
    tapPlaneWorld.render(canvas);
  }

  @override
  void update(double t) {
    tapPlaneWorld.update(t);
  }

  @override
  void resize(Size size) {
    tapPlaneWorld.resize(size);
  }

  @override
  void onTap() {
    tapPlaneWorld.onTap();
  }
}