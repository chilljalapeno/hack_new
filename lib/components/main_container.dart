import 'package:flame/components.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/constants.dart';

class MainContainer extends PositionComponent {
  PositionComponent child;
  MainContainer({required this.child})
    : super(
        size: Vector2(
          GameDimensions.mainContainerWidth,
          GameDimensions.mainContainerHeight,
        ),
        position: Vector2(
          GameDimensions.mainContainerMarginHorizontal,
          GameDimensions.mainContainerMarginTop,
        ),
      );

  @override
  Future<void> onLoad() async {
    //Shape of the main container
    RoundedRectangle inner = RoundedRectangle(
      radius: GameDimensions.borderRadius,
      color: ThemeColors.mainContainerBg,
      position: Vector2(
        GameDimensions.outlineWidth,
        GameDimensions.outlineWidth,
      ),
      size: size,
    );
    RoundedRectangle outer = RoundedRectangle(
      radius: GameDimensions.borderRadius,
      size:
          size +
          Vector2(
            GameDimensions.outlineWidth * 2,
            GameDimensions.outlineWidth * 2,
          ),
      color: ThemeColors.mainContainerOutline,
      children: [inner],
    );

    add(outer);
    add(child);
  }
}
