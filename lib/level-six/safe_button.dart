import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/level-six/correct.dart';
import 'package:hack_improved/level-six/incorret_phishing.dart';

class SafeButton extends PositionComponent
    with
        TapCallbacks,
        HasGameReference<HackGame>,
        FlameBlocListenable<LevelSixBloc, LevelSixState> {
  int emailNumber;
  int numberOfSelected;
  SafeButton({required this.emailNumber, required this.numberOfSelected})
    : super(size: Vector2(350, 100));

  @override
  Future<void> onLoad() async {
    SpriteComponent background = SpriteComponent.fromImage(
      size: Vector2(350, 100),
      game.images.fromCache("safebutton.png"),
    );
    add(background);
  }

  @override
  void onTapDown(TapDownEvent event) {
    switch (emailNumber) {
      case 1:
        if (bloc.state.email1 == 0) {
          parent!.parent!.add(Correct());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 2:
        if (bloc.state.email2 == 0) {
          parent!.parent!.add(Correct());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 3:
        if (bloc.state.email3 == 0) {
          parent!.parent!.add(Correct());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 4:
        if (bloc.state.email4 == 0) {
          parent!.parent!.add(Correct());
          Future.delayed(
            Duration(milliseconds: 1000),
            () => game.levelSix.inbox.router.pop(),
          );
        } else {
          parent!.parent!.add(IncorrectPhishing());
        }
        break;
      case 5:
        if (bloc.state.email5 == 0) {
          parent!.parent!.add(Correct());
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
