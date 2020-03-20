import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/tap-plane-game.dart';

class CustomBodyComponent extends BodyComponent {
  double tileSize;

  CustomBodyComponent(Box2DComponent box) : super(box) {
    tileSize = box.viewport.width / TapPlaneGame.TILES_PER_WIDTH;
  }

  @override
  void resize(Size size) {
    tileSize = size.width / TapPlaneGame.TILES_PER_WIDTH;
    super.resize(size);
  }
}