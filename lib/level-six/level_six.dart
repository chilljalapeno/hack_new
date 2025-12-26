import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/level-six/email_header.dart';
import 'package:hack_improved/level-six/inbox_header.dart';
import 'package:hack_improved/level-six/inbox_overlay.dart';
import 'package:hack_improved/level-six/opened_email1.dart';
import 'package:hack_improved/level-six/opened_email2.dart';
import 'package:hack_improved/level-six/opened_email3.dart';
import 'package:hack_improved/level-six/opened_email4.dart';
import 'package:hack_improved/level-six/opened_email5.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/main_container.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';
import 'package:hack_improved/misc/ui.dart';

// Todo Add emailHeaders content
// Create a router to switch from EmailHeader to OpenedEmail
class LevelSix extends World {
  late Inbox inbox;
  late InboxOverlay inboxOverlay;
  late UI ui;

  @override
  Future<void> onLoad() async {
    inbox = Inbox();
    inboxOverlay = InboxOverlay();
    ui = UI();

    add(ui);
    await add(inbox);

    add(inboxOverlay);
  }
}

class Inbox extends PositionComponent
    with FlameBlocListenable<LevelSixBloc, LevelSixState> {
  late InboxHeader inboxHeader;
  late EmailHeader email1;
  late EmailHeader email2;
  late EmailHeader email3;
  late EmailHeader email4;
  late EmailHeader email5;

  late OpenedEmail1 openedEmail1;
  late OpenedEmail2 openedEmail2;
  late OpenedEmail3 openedEmail3;
  late OpenedEmail4 openedEmail4;
  late OpenedEmail5 openedEmail5;

  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    email1 = EmailHeader(
      fromEmail: "planning.secreteriat@st-aegis.hos",
      subjectEmail: "Call appointment manager - listen to voicemail",
      dateEmail: "Today, 8:35 AM",
      emailNumber: 1,
    );
    email2 = EmailHeader(
      fromEmail: "Microsoft security \t<security@microsoftrrv.com>",
      subjectEmail:
          "Action required: Unusual sign-in activity - Verify your account",
      dateEmail: "Today 2.34 AM",
      emailNumber: 2,
    );
    email3 = EmailHeader(
      fromEmail: "hr@ziekenhuis-rotterdam.nl",
      subjectEmail: "New salary arrangement - see attachment",
      dateEmail: "Yesterday 12.47 AM",
      emailNumber: 3,
    );
    email4 = EmailHeader(
      fromEmail: "IT Department <it.support@st.aegis.com>",
      subjectEmail: "Planned system maintenance this weekend",
      dateEmail: "Today, 9:15",
      emailNumber: 4,
    );
    email5 = EmailHeader(
      fromEmail: "Company Newsletter <newsletter@st.aegis.com>",
      subjectEmail: "Monthly update – December",
      dateEmail: "Yesterday, 4:30 PM",
      emailNumber: 5,
    );

    // Phishing
    openedEmail1 = OpenedEmail1(
      fromEmail: "planning.secreteriat@st-aegis.hos",
      subjectEmail: "Call appointment manager - listen to voicemail",
      dateEmail: "Today, 8:35 AM",
    );
    openedEmail2 = OpenedEmail2(
      fromEmail: "Microsoft security \t<security@microsoftrrv.com>",
      subjectEmail:
          "Action required: Unusual sign-in activity - Verify your account",
      dateEmail: "Today 2.34 AM",
    );
    openedEmail3 = OpenedEmail3(
      fromEmail: "hr@ziekenhuis-rotterdam.nl",
      subjectEmail: "New salary arrangement - see attachment",
      dateEmail: "Yesterday 12.47 AM",
    );
    //---
    // Safe
    openedEmail4 = OpenedEmail4(
      fromEmail: "IT Department <it.support@st.aegis.com>",
      subjectEmail: "Planned system maintenance this weekend",
      dateEmail: "Today, 9:15",
    );
    openedEmail5 = OpenedEmail5(
      fromEmail: "Company Newsletter <newsletter@st.aegis.com>",
      subjectEmail: "Monthly update – December",
      dateEmail: "Yesterday, 4:30 PM",
    );
    //---
    EndScreen endScreen = EndScreen();
    //
    inboxHeader = InboxHeader(content: "Inbox - Harper Collins");
    add(inboxHeader);
    ContinueButton continueButton = ContinueButton();
    continueButton.position = Vector2(
      1920 / 2 - continueButton.size.x / 2,
      980,
    );
    router = RouterComponent(
      initialRoute: "home",
      routes: {
        "home": Route(
          () => PositionComponent(
            size: Vector2(1920, 1080),
            children: [
              MainContainer(
                  child: ColumnComponent(
                    size: Vector2(1500, 740),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    gap: 12,
                    children: [email1, email2, email3, email4, email5],
                  ),
                )
                ..size = Vector2(1500, 740)
                ..position = Vector2(210, 180),
              continueButton,
            ],
          ),
        ),
        "openedEmail1": Route(() => openedEmail1),
        "openedEmail2": Route(() => openedEmail2),
        "openedEmail3": Route(() => openedEmail3),
        "openedEmail4": Route(() => openedEmail4),
        "openedEmail5": Route(() => openedEmail5),
        "endScreen": Route(() => endScreen),
      },
    );
    add(router);
  }
}

class ContinueButton extends PositionComponent
    with TapCallbacks, HasGameReference<HackGame> {
  ContinueButton() : super(size: Vector2(308, 68));
  @override
  Future<void> onLoad() async {
    final text = TextComponent(
      text: "Continue",
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 32, color: Color(0xFF6DC5D9)),
      ),
    );
    final row = RowComponent(
      size: Vector2(300, 60),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [text],
    );
    final inner = RoundedRectangle(
      size: Vector2(300, 60),
      color: ThemeColors.mainContainerBg,
      radius: 16,
      position: Vector2(4, 4),
      children: [row],
    );
    final outer = RoundedRectangle(
      size: Vector2(308, 68),
      color: ThemeColors.mainContainerOutline,
      radius: 16,
      children: [inner],
    );
    add(outer);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.levelSix.inbox.email1.isClicked &&
        game.levelSix.inbox.email2.isClicked &&
        game.levelSix.inbox.email3.isClicked &&
        game.levelSix.inbox.email4.isClicked &&
        game.levelSix.inbox.email5.isClicked) {
      game.levelSix.inbox.remove(game.levelSix.inbox.inboxHeader);
      game.levelSix.inbox.router.pushNamed("endScreen");
    }
    super.onTapDown(event);
  }
}

class EndScreen extends PositionComponent {
  EndScreen();

  @override
  Future<void> onLoad() async {
    add(InboxHeader(content: "MISSION ACCOMPLISHED! HACKER IDENTIFIED"));
    add(
      PositionComponent(
        size: Vector2(1920, 1080),
        children: [
          MainContainer(
              child: ColumnComponent(
                size: Vector2(1500, 740),
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                gap: 12,
                children: [
                  TextComponent(
                    text:
                        "Congratulations! You successfully traced the breach back to a few emails",
                    textRenderer: TextPaint(
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  TextComponent(
                    text:
                        "and identified the hacker’s entry point. St. Aegis Hospital’s systems are",
                    textRenderer: TextPaint(
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  TextComponent(
                    text:
                        "now secure. Your actions have protected sensitive patient data.",
                    textRenderer: TextPaint(
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  TextComponent(
                    text:
                        "CYBERSECURITY TIP: Always verify the sender’s email address and be cautious",
                    textRenderer: TextPaint(
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  TextComponent(
                    text:
                        "of urgent requests or unexpected attachments.Cybersecurity is everyone’s",
                    textRenderer: TextPaint(
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  TextComponent(
                    text: "responsibility.",
                    textRenderer: TextPaint(
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
            ..size = Vector2(1500, 740)
            ..position = Vector2(210, 180),
        ],
      ),
    );
  }
}
