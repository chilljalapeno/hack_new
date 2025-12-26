import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flutter/material.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/main_container.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';
import 'package:hack_improved/misc/ui.dart';

class LevelThree extends World {
  late UI ui;
  LevelThree();

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    ui = UI();
    add(ui);

    add(
      MainContainer(
        child: ColumnComponent(
          size: Vector2(1500, 850),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          gap: 48,
          children: [
            CountdownTimerComponent(
              size: Vector2(900, 100),
              isHeader: true,
              color: Colors.transparent,
            ),
            CountdownTimerComponent(
              size: Vector2(900, 350),
              isHeader: false,
              color: Colors.red,
            )..add(
              GlowEffect(
                24.0,
                EffectController(
                  duration: 1.0,
                  infinite: true,
                  reverseDuration: 1.0,
                ),
              ),
            ),
            RandomCounterTextComponent(),
            ContinueButton(),
          ],
        ),
      ),
    );
  }
}

class CountdownTimerComponent extends RectangleComponent {
  double _remaining = 300.0;
  double _elapsed = 0.0;
  late TextComponent timerText;
  bool isHeader;
  Color color;

  final Color color1 = const Color(0xFF6DC5D9);
  final Color color2 = const Color(0xFFE9894E);
  final Color color3 = const Color(0xFFCA441A);

  CountdownTimerComponent({
    required this.color,
    required this.isHeader,
    required Vector2 size,
  }) : super(size: size) {
    timerText = TextComponent(
      text: _formatTime(_remaining),
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFF6DC5D9),
          fontSize: 398,
          fontFamily: "BeautifulPoliceOfficer",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    if (isHeader) {
      timerText = TextComponent(
        text: "Emergency meeting\n    Time is ticking",
        anchor: Anchor.center,
        position: size / 2,
        textRenderer: TextPaint(
          style: const TextStyle(color: Color(0xFF6DC5D9), fontSize: 50),
        ),
      );
    }
    add(timerText);
  }

  static String _formatTime(double seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds.toInt() % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_remaining > 0) {
      _remaining -= dt;
      if (_remaining < 0) _remaining = 0.0;
      _elapsed += dt;

      // Change text color at intervals
      Color currentColor = color1;
      if (_elapsed > 20) {
        currentColor = color3;
      } else if (_elapsed > 10) {
        currentColor = color2;
      }
      if (!isHeader) {
        timerText.textRenderer = TextPaint(
          style: TextStyle(
            color: currentColor,
            fontSize: 398,
            fontFamily: "BeautifulPoliceOfficer",
            fontWeight: FontWeight.bold,
          ),
        );
        timerText.text = _formatTime(_remaining);
      } else {
        timerText.textRenderer = TextPaint(
          style: TextStyle(color: currentColor, fontSize: 50),
        );
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = this.paint..color = color;
    final rrect = RRect.fromRectAndRadius(size.toRect(), Radius.circular(16));
    canvas.drawRRect(rrect, paint);
    super.render(canvas);
  }
}

class ContinueButton extends PositionComponent {
  ContinueButton() : super(size: Vector2(408, 108));
  @override
  Future<void> onLoad() async {
    final text = TextComponent(
      text: "Continue",
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 48, color: Color(0xFF6DC5D9)),
      ),
    );
    final row = RowComponent(
      size: Vector2(400, 100),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [text],
    );
    final inner = RoundedRectangle(
      size: Vector2(400, 100),
      color: ThemeColors.mainContainerBg,
      radius: 16,
      position: Vector2(4, 4),
      children: [row],
    );
    final outer = RoundedRectangle(
      size: Vector2(408, 108),
      color: ThemeColors.mainContainerOutline,
      radius: 16,
      children: [inner],
    );

    add(outer);
  }
}

class RandomCounterTextComponent extends TextComponent {
  Random _random = Random();
  int _currentValue = 0;
  final int _maxValue = 7934;
  late Timer _timer;

  RandomCounterTextComponent({int fontSize = 48})
    : super(
        text: '0' + " Deaths",
        textRenderer: TextPaint(
          style: TextStyle(
            color: Colors.red,
            fontSize: fontSize.toDouble(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ) {
    _timer = Timer(
      7,
      repeat: true,
      onTick: () {
        if (_currentValue < _maxValue) {
          final increment = _random.nextInt(50) + 1; // Random between 1 and 50
          _currentValue = (_currentValue + increment).clamp(0, _maxValue);
          text = _currentValue.toString() + " Deaths";
        }
      },
    );
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
