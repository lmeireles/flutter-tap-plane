import 'package:flutter/material.dart';
import 'package:flutter_tap_plane/tap-plane-game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TapPlaneGame().widget);
}