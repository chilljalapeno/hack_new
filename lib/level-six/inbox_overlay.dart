import 'package:flame/events.dart';
import "package:flame/experimental.dart" hide RoundedRectangle;
import "package:flutter/material.dart";
import "package:flame/components.dart";
import "package:hack_improved/misc/constants.dart";
import "package:hack_improved/misc/rounded_rectangle.dart";

class InboxOverlay extends PositionComponent with TapCallbacks {
  InboxOverlay() : super(size: Vector2(1920, 1080));

  @override
  void onTapDown(TapDownEvent event) {
    parent!.remove(this);
  }

  @override
  Future<void> onLoad() async {
    TextComponent header = TextComponent(
      text: "Email Access Granted",
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 48,
          color: ThemeColors.checkServerStatusText,
        ),
      ),
    );

    TextComponent text1 = TextComponent(
      text: "You now have access to the employee’s inbox.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text2 = TextComponent(
      text: "Your task is to identify how the attacker gained entry.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text3 = TextComponent(
      text:
          "Review the emails carefully and determine which messages are \nlegitimate and which are phishing attempts.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text4 = TextComponent(
      text:
          "Look for subtle warning signs — urgency, unusual senders, \nunexpected attachments, or suspicious links.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );
    TextComponent text5 = TextComponent(
      text: "Select each email and decide whether it is Safe or Phishing.",
      textRenderer: TextPaint(style: TextStyle(fontSize: 32)),
    );

    ColumnComponent textColumn = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      position: Vector2(48, 0),
      size: Vector2(1000, 600),
      children: [header, text1, text2, text3, text4, text5],
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
