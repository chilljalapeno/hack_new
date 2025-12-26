import 'package:flame/components.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/level-six/phishing_button.dart';
import 'package:hack_improved/level-six/safe_button.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/main_container.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';

class OpenedEmail4 extends PositionComponent
    with FlameBlocListenable<LevelSixBloc, LevelSixState> {
  late Email4Content emailContent;
  late PhishingButton phishing;
  late SafeButton safe;
  String fromEmail;
  String subjectEmail;
  String dateEmail;
  int numberOfSelected = 0;

  @override
  void onNewState(LevelSixState state) {
    numberOfSelected = state.numberOfSelected1;
    super.onNewState(state);
  }

  @override
  // TODO: implement debugMode
  bool get debugMode => false;

  OpenedEmail4({
    required this.fromEmail,
    required this.subjectEmail,
    required this.dateEmail,
  }) : super(size: Vector2(1500, 724));

  @override
  Future<void> onLoad() async {
    emailContent = Email4Content();

    // -- EmailHeader
    // size: Vector2(1206, 134)
    RowComponent fromEmailHeader = RowComponent(
      size: Vector2(1206 - 48, 30),
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

    RowComponent subjectEmailHeader = RowComponent(
      size: Vector2(1206 - 48, 30),
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

    RowComponent dateEmailHeader = RowComponent(
      size: Vector2(1206 - 48, 30),
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

    RoundedRectangle innerEmailHeader = RoundedRectangle(
      size: Vector2(1200, 134),
      color: ThemeColors.mainContainerBg,
      position: Vector2(3, 3),
      radius: 8,
      children: [
        ColumnComponent(
          size: Vector2(1200, 134),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [fromEmailHeader, subjectEmailHeader, dateEmailHeader],
        ),
      ],
    );

    RoundedRectangle outerEmailHeader = RoundedRectangle(
      size: Vector2(1206, 140),
      color: ThemeColors.mainContainerOutline,
      radius: 8,
      children: [innerEmailHeader],
    );
    // ---

    phishing = PhishingButton(
      emailNumber: 4,
      numberOfSelected: numberOfSelected,
    );
    safe = SafeButton(emailNumber: 4, numberOfSelected: numberOfSelected);

    RoundedRectangle inner = RoundedRectangle(
      size: Vector2(1206, 524),
      color: ThemeColors.mainContainerBg,
      position: Vector2(3, 3),
      radius: 8,
      children: [emailContent],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: Vector2(1212, 530),
      color: ThemeColors.mainContainerOutline,
      radius: 8,
      children: [inner],
    );

    TextComponent text = TextComponent(
      text: "Tap suspicious elements to highlight them",
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 24,
          color: ThemeColors.checkServerStatusText,
        ),
      ),
    );

    RowComponent buttons = RowComponent(
      size: Vector2(1920, 300),
      position: Vector2(0, 850),
      gap: 48,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [safe, phishing],
    );

    ColumnComponent column = ColumnComponent(
      size: Vector2(1500, 740),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [outerEmailHeader, outer, text],
    );

    MainContainer mainContainer = MainContainer(child: column)
      ..size = Vector2(1500, 740)
      ..position = Vector2(210, 180);

    add(mainContainer);
    add(buttons);
  }
}

class Email4Content extends PositionComponent with HasGameReference {
  Email4Content() : super(size: Vector2(1200, 300));

  @override
  Future<void> onLoad() async {
    TextComponent mailIntro = TextComponent(
      text: "Dear Employee, ",
      textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
    );

    ColumnComponent mailContent = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          text:
              "Please be advised of planned system maintenance this weekend, Saturday from 10PM to 2AM.",
          textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
        ),
        TextComponent(
          text: "Services may be temporarily unavailable.",
          textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
        ),
      ],
    );

    ColumnComponent last = ColumnComponent(
      children: [
        TextComponent(
          text: "Thank you,",
          textRenderer: TextPaint(
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        TextComponent(
          text: "IT Department",
          textRenderer: TextPaint(
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ],
    );

    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      gap: 32,
      children: [mailIntro, mailContent, last],
    )..position = Vector2(50, 50);

    add(column);
  }
}
