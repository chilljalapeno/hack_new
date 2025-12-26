import 'package:flame/components.dart';
import 'package:hack_improved/misc/ui_header.dart';

class UI extends PositionComponent with HasGameReference {
  UI() : super(size: Vector2(1920, 1080));
  @override
  Future<void> onLoad() async {
    UiHeader uiHeader = UiHeader();

    final background = SpriteComponent(
      sprite: Sprite(game.images.fromCache("splash_background.png")),
      size: size,
      priority: -1,
    );
    add(background);
    add(uiHeader);
  }
}
