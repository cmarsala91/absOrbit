import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'color_palette.dart';

class PieChart {
  PieChart(this.pies);

  factory PieChart.empty(Size size) {
    return PieChart(<Pie>[]);
  }

  factory PieChart.random(Size size, Random random) {
    const pieWidthFraction = 0.75;
    const minPieDistance = 20.0;
    final pieCount = random.nextInt((size.width / minPieDistance).floor()) + 1;
    final pieDistance = size.width / (1 + pieCount);
    final pieWidth = pieDistance * pieWidthFraction;
    final startX = pieDistance - pieWidth / 2;
    final color = ColorPalette.primary.random(random);
    final pies = List.generate(
      pieCount,
      (i) => Pie(
        startX + i * pieDistance,
        pieWidth,
        random.nextDouble() * 6.283,
        color,
      ),
    );
    return PieChart(pies);
  }

  final List<Pie> pies;

  static PieChart lerp(PieChart begin, PieChart end, double t) {
    final pieCount = max(begin.pies.length, end.pies.length);
    final pies = List.generate(
        pieCount,
          (i) => Pie.lerp(
        begin._pieOrNull(i) ?? end.pies[i].collapsed,
        end._pieOrNull(i) ?? begin.pies[i].collapsed,
        t,
      ),
    );
    return PieChart(pies);
  }

  Pie _pieOrNull(int index) => (index < pies.length ? pies[index] : null);
}

class PieChartTween extends Tween<PieChart> {
  PieChartTween(PieChart begin, PieChart end) : super(begin: begin, end: end);

  @override
  PieChart lerp(double t) => PieChart.lerp(begin, end, t);
}

class Pie {
  final double x;
  final double diameter;
  final double arcLength;
  final Color color;

  Pie(this.x, this.diameter, this.arcLength, this.color);

  Pie get collapsed => Pie(x, 0.0, 0.0, color);

  static Pie lerp(Pie begin, Pie end, double t) {
    return Pie(
      lerpDouble(begin.x, end.x, t),
      lerpDouble(begin.diameter, end.diameter, t),
      lerpDouble(begin.arcLength, end.arcLength, t),
      Color.lerp(begin.color, end.color, t),
    );
  }
}

class PieTween extends Tween<Pie> {
  PieTween(Pie begin, Pie end) : super(begin: begin, end: end);

  @override
  Pie lerp(double t) => Pie.lerp(begin, end, t);
}

class PieChartPainter extends CustomPainter {
  final Animation<PieChart> animation;

  PieChartPainter(Animation<PieChart> animation)
    : animation = animation,
      super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final chart = animation.value;
    for (final Pie in chart.pies) {
      paint.color = Pie.color;
      canvas.drawArc(
        Rect.fromLTWH(
            Pie.x,
            size.height - Pie.diameter,
            Pie.diameter,
            Pie.diameter),
        0,
        Pie.arcLength,
        true,
        paint);

    }
  }

  @override
  bool shouldRepaint(PieChartPainter old) => false;
}