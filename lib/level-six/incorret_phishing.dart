import 'package:flame/events.dart';
import "package:flame/experimental.dart" hide RoundedRectangle;
import "package:flutter/material.dart";
import "package:flame/components.dart";
import "package:hack_improved/misc/constants.dart";
import "package:hack_improved/misc/rounded_rectangle.dart";

class IncorrectPhishing extends PositionComponent with TapCallbacks {
  IncorrectPhishing() : super(size: Vector2(1920, 1080));

  @override
  void onTapDown(TapDownEvent event) {
    parent!.remove(this);
  }

  @override
  Future<void> onLoad() async {
    TextComponent header = TextComponent(
      text: "Incorrect, Try Again!",
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 48,
          color: ThemeColors.infectedButtonOutline,
        ),
      ),
    );

    TextComponent text1 = TextComponent(
      text: "You did not identify all the phishing indicators.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text2 = TextComponent(
      text: "Look for suspicious details in the email.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );

    ColumnComponent textColumn = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      size: Vector2(800, 400),
      gap: 16,
      children: [header, text1, text2],
    );

    RoundedRectangle inner = RoundedRectangle(
      size: Vector2(800, 400),
      color: Color(0xCC111D2F),
      radius: 16,
      position: Vector2(3, 3),
      children: [textColumn],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: Vector2(806, 406),
      color: Color(0xCCCA431A),
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
