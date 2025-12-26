import 'package:flame/components.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flutter/material.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';

class InboxHeader extends PositionComponent {
  final String content;
  InboxHeader({required this.content}) : super(position: Vector2(210, 80));

  @override
  Future<void> onLoad() async {
    TextComponent text = TextComponent(
      text: content,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 40,
          color: ThemeColors.checkServerStatusText,
        ),
      ),
    );

    RoundedRectangle inner = RoundedRectangle(
      size: Vector2(1500, 80),
      color: ThemeColors.mainContainerBg,
      position: Vector2(3, 3),
      radius: 8,
      children: [
        RowComponent(
          size: Vector2(1500, 80),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [text],
        ),
      ],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: Vector2(1506, 86),
      color: ThemeColors.mainContainerOutline,
      radius: 8,
      children: [inner],
    );
    add(outer);
  }
}
