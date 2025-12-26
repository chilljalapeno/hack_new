import 'package:flame/events.dart';
import "package:flame/experimental.dart" hide RoundedRectangle;
import "package:flutter/material.dart";
import "package:flame/components.dart";
import "package:hack_improved/misc/constants.dart";
import "package:hack_improved/misc/rounded_rectangle.dart";

class Correct extends PositionComponent with TapCallbacks {
  Correct() : super(size: Vector2(1920, 1080));

  @override
  void onTapDown(TapDownEvent event) {
    parent!.remove(this);
  }

  @override
  Future<void> onLoad() async {
    TextComponent header = TextComponent(
      text: "Correct this is not phishing",
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 48, color: ThemeColors.safeButtonOutline),
      ),
    );

    ColumnComponent textColumn = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      position: Vector2(48, 0),
      size: Vector2(606, 200),
      children: [header],
    );

    RoundedRectangle inner = RoundedRectangle(
      size: Vector2(700, 200),
      color: Color(0xCC111D2F),
      radius: 16,
      position: Vector2(3, 3),
      children: [textColumn],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: Vector2(706, 206),
      color: Color(0xCC0D4761),
      radius: 16,
      children: [inner],
    );

    RowComponent row = RowComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      size: Vector2(1920, 1080),
      children: [outer],
    );

    RectangleComponent background = RectangleComponent(
      size: Vector2(1920, 1080),
      position: Vector2(0, 0),
      paint: Paint()..color = Colors.transparent,
      children: [row],
    );

    add(background);
  }
}
