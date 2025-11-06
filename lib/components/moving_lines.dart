import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RandomLoadingBarsComponent extends PositionComponent {
  RandomLoadingBarsComponent({
    required this.barWidth,
    this.barHeight = 18,
    this.barGap = 4,
    this.barCount = 3,
    this.bgColor = const Color(0xFF212121),
    this.fillColor = const Color(0xFF00F5D4),
    this.animationSpeed = 48.0,
    this.cornerRadius = 8.0, // <-- Add edge radius parameter
    this.randomSeed,
  }) : super(
         size: Vector2(
           barWidth,
           barCount * barHeight + (barCount - 1) * barGap,
         ),
         anchor: Anchor.topLeft,
       );

  final double barWidth;
  final double barHeight;
  final double barGap;
  final int barCount;
  final Color bgColor;
  final Color fillColor;
  final double animationSpeed;
  final double cornerRadius;
  final int? randomSeed;

  late final Paint _bgPaint = Paint()..color = bgColor;
  late final Paint _fillPaint = Paint()..color = fillColor;

  final Random _rng = Random();
  late final List<_BarState> _bars;

  @override
  Future<void> onLoad() async {
    _bars = List.generate(barCount, (_) {
      final value = _rng.nextDouble() * 100;
      final target = _rng.nextDouble() * 100;
      final timer = 0.0;
      final interval = 0.75 + _rng.nextDouble() * 2.5;
      return _BarState(value, target, timer, interval);
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (final bar in _bars) {
      if ((bar.value - bar.target).abs() < 1.5) {
        bar.value = bar.target;
      } else if (bar.value < bar.target) {
        bar.value = min(bar.value + animationSpeed * dt, bar.target);
      } else {
        bar.value = max(bar.value - animationSpeed * dt, bar.target);
      }
      bar.timer += dt;
      if (bar.timer >= bar.interval) {
        bar.target = _rng.nextDouble() * 100;
        bar.timer = 0.0;
        bar.interval = 0.75 + _rng.nextDouble() * 2.5;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final radius = Radius.circular(cornerRadius);
    for (int i = 0; i < _bars.length; i++) {
      final y = i * (barHeight + barGap);
      final barRect = Rect.fromLTWH(0, y.toDouble(), barWidth, barHeight);
      final barRRect = RRect.fromRectAndRadius(barRect, radius);
      canvas.drawRRect(barRRect, _bgPaint);

      final fillWidth = barWidth * (_bars[i].value / 100.0);
      if (fillWidth > 0) {
        final fillRect = Rect.fromLTWH(0, y.toDouble(), fillWidth, barHeight);
        // For partial fill, make sure we don’t get a pill shape when nearly empty
        final fillRRect = RRect.fromRectAndCorners(
          fillRect,
          topLeft: radius,
          bottomLeft: radius,
          topRight: fillWidth < barWidth
              ? Radius.circular(min(cornerRadius, fillWidth / 2))
              : radius,
          bottomRight: fillWidth < barWidth
              ? Radius.circular(min(cornerRadius, fillWidth / 2))
              : radius,
        );
        canvas.drawRRect(fillRRect, _fillPaint);
      }
    }
  }
}

class _BarState {
  _BarState(this.value, this.target, this.timer, this.interval);
  double value;
  double target;
  double timer;
  double interval;
}
