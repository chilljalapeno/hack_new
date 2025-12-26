import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/level-six/correct_phishing.dart';
import 'package:hack_improved/level-six/incorret_phishing.dart';

class PhishingButton extends PositionComponent
    with
        TapCallbacks,
        HasGameReference<HackGame>,
        FlameBlocListenable<LevelSixBloc, LevelSixState> {
  final int emailNumber;
  int numberOfSelected;

  PhishingButton({required this.emailNumber, required this.numberOfSelected})
    : super(size: Vector2(350, 100));

  @override
  Future<void> onLoad() async {
    SpriteComponent background = SpriteComponent.fromImage(
      size: Vector2(350, 100),
      game.images.fromCache("phishingbutton.png"),
    );
    add(background);
  }

  @override
  void onTapDown(TapDownEvent event) {
    bloc.add(
      LevelSixEvent.phishing(
        emailNumber: emailNumber,
        numberOfSelected: numberOfSelected,
      ),
    );

    switch (emailNumber) {
      case 1:
        if (bloc.state.email1 == bloc.state.numberOfSelected1 &&
            bloc.state.email1 != 0) {
          parent!.parent!.add(CorrectPhishing());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 2:
        if (bloc.state.email2 == bloc.state.numberOfSelected2 &&
            bloc.state.email2 != 0) {
          parent!.parent!.add(CorrectPhishing());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 3:
        if (bloc.state.email3 == bloc.state.numberOfSelected3 &&
            bloc.state.email3 != 0) {
          parent!.parent!.add(CorrectPhishing());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 4:
        if (bloc.state.email4 == bloc.state.numberOfSelected4 &&
            bloc.state.email4 != 0) {
          parent!.parent!.add(CorrectPhishing());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 5:
        if (bloc.state.email5 == bloc.state.numberOfSelected5 &&
            bloc.state.email5 != 0) {
          parent!.parent!.add(CorrectPhishing());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
    }
  }
}
