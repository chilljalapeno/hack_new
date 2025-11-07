import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:hack_improved/blocs/level_two_bloc.dart';
import 'package:hack_improved/level_two.dart';

class HackGame extends FlameGame {
  late CameraComponent cam;
  late LevelTwo levelTwo;

  HackGame();

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    await _loadLevels();
    return super.onLoad();
  }

  Future<void> _loadLevels() async {
    add(FpsTextComponent());
    levelTwo = LevelTwo();

    cam = CameraComponent.withFixedResolution(
      world: levelTwo,
      width: 1920,
      height: 1080,
    );

    cam.viewfinder.anchor = Anchor.topLeft;

    await add(
      FlameBlocProvider<LevelTwoBloc, LevelTwoState>(
        create: () => LevelTwoBloc(),
        children: [cam, levelTwo],
      ),
    );
  }
}
