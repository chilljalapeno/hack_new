import 'package:flame/events.dart';
import "package:flame/experimental.dart" hide RoundedRectangle;
import "package:flutter/material.dart";
import "package:flame/components.dart";
import "package:hack_improved/misc/constants.dart";
import "package:hack_improved/misc/rounded_rectangle.dart";

class CorrectPhishing extends PositionComponent with TapCallbacks {
  CorrectPhishing() : super(size: Vector2(1920, 1080));

  @override
  void onTapDown(TapDownEvent event) {
    parent!.remove(this);
  }

  @override
  Future<void> onLoad() async {
    TextComponent header = TextComponent(
      text: "Correct this is phishing",
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 48, color: ThemeColors.safeButtonOutline),
      ),
    );

    TextComponent text1 = TextComponent(
      text: "Because of:",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text2 = TextComponent(
      text: "Suspicious sender address:",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text3 = TextComponent(
      text: "The email does not originate from an official hospital domain.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );

    TextComponent text4 = TextComponent(
      text: "Urgent language: The message pressures the user to act",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );

    TextComponent text5 = TextComponent(
      text: "immediately without verification.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );

    TextComponent text6 = TextComponent(
      text: "Malicious QR code: Scanning QR codes from emails can redirect ",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text7 = TextComponent(
      text: "to fake login pages or malware instead of official systems.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );

    ColumnComponent textColumn = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      position: Vector2(48, 0),
      size: Vector2(1000, 600),
      gap: 4,
      children: [header, text1, text2, text3, text4, text5, text6, text7],
    );

    RoundedRectangle inner = RoundedRectangle(
      size: Vector2(1048, 600),
      color: Color(0xCC111D2F),
      radius: 16,
      position: Vector2(3, 3),
      children: [textColumn],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: Vector2(1054, 606),
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
