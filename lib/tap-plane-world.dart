import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter_tap_plane/components/background.dart';
import 'package:flutter_tap_plane/components/ground.dart';

class TapPlaneWorld extends Box2DComponent {

  TapPlaneWorld() : super(scale: 1.0);

  void initializeWorld() {
    addAll(new Background(this).list);
    addAll(new Ground(this).list);
  }

  @override
  void update(t) {
    super.update(t);
  }
}