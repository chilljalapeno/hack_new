import 'package:flame/components.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/level-six/phishing_button.dart';
import 'package:hack_improved/level-six/safe_button.dart';
import 'package:hack_improved/level-six/tofind_values.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/main_container.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';

class OpenedEmail2 extends PositionComponent
    with FlameBlocListenable<LevelSixBloc, LevelSixState> {
  late Email2Content emailContent;
  late PhishingButton phishing;
  late SafeButton safe;
  String fromEmail;
  String subjectEmail;
  String dateEmail;
  int numberOfSelected = 0;

  @override
  void onNewState(LevelSixState state) {
    numberOfSelected = bloc.state.numberOfSelected2;
    super.onNewState(state);
  }

  @override
  // TODO: implement debugMode
  bool get debugMode => false;

  OpenedEmail2({
    required this.fromEmail,
    required this.subjectEmail,
    required this.dateEmail,
  }) : super(size: Vector2(1500, 724));

  @override
  Future<void> onLoad() async {
    emailContent = Email2Content();
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
        ToFindValues(
          emailNumber: 2,
          content: TextComponent(
            text: fromEmail,
            textRenderer: TextPaint(
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
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
        ToFindValues(
          emailNumber: 2,
          content: TextComponent(
            text: dateEmail,
            textRenderer: TextPaint(
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
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
      emailNumber: 2,
      numberOfSelected: numberOfSelected,
    );
    safe = SafeButton(emailNumber: 2, numberOfSelected: numberOfSelected);

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

class Email2Content extends PositionComponent with HasGameReference {
  Email2Content() : super(size: Vector2(1200, 300));

  @override
  Future<void> onLoad() async {
    RectangleComponent verifyButton = RectangleComponent(
      size: Vector2(400, 100),
      paint: Paint()..color = Colors.blue,
      children: [
        RowComponent(
          size: Vector2(400, 100),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextComponent(
              text: "Verify Button",
              textRenderer: TextPaint(
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );

    TextComponent mailIntro = TextComponent(
      text: "Dear Microsoft user,",
      textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
    );

    TextComponent toPress2 = TextComponent(
      text: " within 10 minutes ",
      textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
    );

    ToFindValues toFind2 = ToFindValues(content: toPress2, emailNumber: 2);
    ToFindValues toFind3 = ToFindValues(content: verifyButton, emailNumber: 2);

    RowComponent qrRow = RowComponent(
      size: Vector2(size.x, 200),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [toFind3],
    );

    ColumnComponent mailContent = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          text:
              "We have detected an unusual sign-in attempt for your account. To protect your",
          textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
        ),
        TextComponent(
          text:
              "account, click 'Verify' to sign in again and complete the verification",
          textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
        ),
      ],
    );

    RowComponent last = RowComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextComponent(
          text: "If you do not confirm ",
          textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
        ),
        toFind2,
        TextComponent(
          text: "your account will be temporarily locked",
          textRenderer: TextPaint(style: TextStyle(fontSize: 24)),
        ),
      ],
    );

    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      gap: 32,
      children: [mailIntro, mailContent, qrRow, last],
    )..position = Vector2(50, 50);

    add(column);
  }
}
