import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hack_improved/hack_game.dart';

class LockWorldTransition extends Component with HasGameReference<HackGame> {
  late SpriteComponent splashBg;
  late SpriteComponent lockBg;
  late SpriteComponent lockOpenedBg;
  late SpriteComponent fadedLockBg;

  static final bgSize = Vector2(1920, 1080);
  static final lockSize = Vector2(768, 768);

  @override
  Future<void> onLoad() async {
    splashBg = SpriteComponent()
      ..sprite = await game.loadSprite('splash_background.png')
      ..size = bgSize
      ..position = Vector2.zero();

    final centerPos = Vector2(
      (bgSize.x - lockSize.x) / 2,
      (bgSize.y - lockSize.y) / 2,
    );

    lockBg = SpriteComponent()
      ..sprite = await game.loadSprite('lock_open.png')
      ..size = lockSize
      ..position = centerPos;
    lockOpenedBg = SpriteComponent()
      ..sprite = await game.loadSprite('lock_half.png')
      ..size = lockSize
      ..position = centerPos
      ..opacity = 0;
    fadedLockBg = SpriteComponent()
      ..sprite = await game.loadSprite('lock_closed.png')
      ..size = lockSize
      ..position = centerPos
      ..opacity = 0;

    add(splashBg);
    add(lockBg);
    add(lockOpenedBg);
    add(fadedLockBg);

    await FlameAudio.audioCache.load('lock.mp3');
    Future.delayed(Duration(milliseconds: 400), _runTransition);
  }

  Future<void> _runTransition() async {
    FlameAudio.play('lock.mp3');

    await lockBg.add(OpacityEffect.to(0, EffectController(duration: 1.7)));
    await lockOpenedBg.add(
      OpacityEffect.to(1, EffectController(duration: 1.7)),
    );
    await Future.delayed(Duration(milliseconds: 600));
    await lockOpenedBg.add(
      OpacityEffect.to(0, EffectController(duration: 1.7)),
    );
    await fadedLockBg.add(OpacityEffect.to(1, EffectController(duration: 1.7)));
    await Future.delayed(Duration(milliseconds: 700));
    await fadedLockBg.add(OpacityEffect.to(0, EffectController(duration: 1.5)));

    removeFromParent();
    game.add(game.levelThree);
  }
}
