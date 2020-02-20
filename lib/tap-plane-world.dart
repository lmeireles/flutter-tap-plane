import 'package:flame/box2d/box2d_component.dart';

import 'components/ground.dart';

class TapPlaneWorld extends Box2DComponent {

  TapPlaneWorld() : super(scale: 1.0);

  void initializeWorld() {
    add(GroundComponent(this, 0));
    add(GroundComponent(this, 1));
  }

  @override
  void update(t) {
    super.update(t);
  }
}