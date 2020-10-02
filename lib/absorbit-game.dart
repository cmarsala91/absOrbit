import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/anchor.dart';

import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Palette {
  static final Paint _white = Paint()..color = Colors.red;
  static final Paint _grey = Paint()..color = Colors.blue;

}

class AbsorbitGame extends BaseGame with HasTapableComponents {
  final double squareSize = 128;
  bool running = true;

  AbsorbitGame() {
    add(Square()
      ..x = 100
      ..y = 100);
  }
}

class Square extends PositionComponent with Tapable {

  bool _beenPressed = false;

  Square({double y = 100, double x = 100}) {
    width = height = 100;
    this.x = x;
    this.y = y;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), _beenPressed ? Palette._grey : Palette._white);
  }

  @override
  void onTapUp(TapUpDetails details) {
    _beenPressed = false;
  }

  @override
  void onTapDown(TapDownDetails details) {
    _beenPressed = true;
  }

  @override
  void onTapCancel() {
    _beenPressed = false;
  }
}