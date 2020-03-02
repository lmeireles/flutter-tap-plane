import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter_tap_plane/components/background.dart';
import 'package:flutter_tap_plane/components/ground.dart';
import 'package:flutter_tap_plane/components/obstacle.dart';
import 'package:flutter_tap_plane/components/plane.dart';

class TapPlaneWorld extends Box2DComponent {

  Plane plane;
  TapPlaneWorld() : super(scale: 1.0, gravity: -150.0);

  void initializeWorld() {
    add(new Background(this));
    addAll(new Obstacle(this).map.values.toList());
    addAll(new Ground(this).list);
    add(plane = new Plane(this));
  }

  @override
  void update(t) {
    super.update(t);
  }

  void onTap() {
    plane.onTap();
  }
}