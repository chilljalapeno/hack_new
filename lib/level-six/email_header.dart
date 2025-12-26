import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';

class EmailHeader extends PositionComponent
    with
        HasGameReference<HackGame>,
        TapCallbacks,
        FlameBlocListenable<LevelSixBloc, LevelSixState> {
  String fromEmail;
  String subjectEmail;
  String dateEmail;
  int emailNumber;
  bool isClicked = false;
  Color borderColor = ThemeColors.mainContainerOutline;
  RoundedRectangle outer = RoundedRectangle(
    size: Vector2(1206, 140),
    color: ThemeColors.mainContainerOutline,
    radius: 8,
  );

  RoundedRectangle inner = RoundedRectangle(
    size: Vector2(1200, 134),
    color: ThemeColors.mainContainerBg,
    position: Vector2(3, 3),
    radius: 8,
  );

  EmailHeader({
    required this.fromEmail,
    required this.subjectEmail,
    required this.dateEmail,
    required this.emailNumber,
  }) : super(size: Vector2(1206, 134));

  @override
  void update(double dt) {
    if (isClicked) {
      remove(outer);
      outer = RoundedRectangle(
        size: Vector2(1206, 140),
        radius: 8,
        color: switch (emailNumber) {
          1 || 2 || 3 => ThemeColors.infectedButtonOutline,
          _ => ThemeColors.safeButtonOutline,
        },
      );
      outer.add(inner);
      add(outer);
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isClicked) {
      game.levelSix.inbox.router.pushNamed("openedEmail$emailNumber");
      isClicked = true;
    }
  }

  @override
  Future<void> onLoad() async {
    RowComponent from = RowComponent(
      size: Vector2(size.x - 48, 30),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PositionComponent(
          size: Vector2(150, 30),
          children: [
            TextComponent(
              size: Vector2(100, 30),
              text: "From:",
              textRenderer: TextPaint(
                style: TextStyle(
                  fontSize: 32,
                  color: ThemeColors.checkServerStatusText,
                ),
              ),
            ),
          ],
        ),
        TextComponent(
          text: fromEmail,
          textRenderer: TextPaint(
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ],
    );

    RowComponent subject = RowComponent(
      size: Vector2(size.x - 48, 30),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PositionComponent(
          size: Vector2(150, 30),
          children: [
            TextComponent(
              text: "Subject:",
              textRenderer: TextPaint(
                style: TextStyle(
                  fontSize: 32,
                  color: ThemeColors.checkServerStatusText,
                ),
              ),
            ),
          ],
        ),
        TextComponent(
          text: subjectEmail,
          textRenderer: TextPaint(
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ],
    );

    RowComponent date = RowComponent(
      size: Vector2(size.x - 48, 30),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PositionComponent(
          size: Vector2(150, 30),
          children: [
            TextComponent(
              text: "Date:",
              textRenderer: TextPaint(
                style: TextStyle(
                  fontSize: 32,
                  color: ThemeColors.checkServerStatusText,
                ),
              ),
            ),
          ],
        ),
        TextComponent(
          text: dateEmail,
          textRenderer: TextPaint(
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ],
    );

    inner = RoundedRectangle(
      size: Vector2(1200, 134),
      color: ThemeColors.mainContainerBg,
      position: Vector2(3, 3),
      radius: 8,
    );

    inner.add(
      ColumnComponent(
        size: Vector2(1200, 134),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [from, subject, date],
      ),
    );
    outer.add(inner);
    add(outer);
  }
}
