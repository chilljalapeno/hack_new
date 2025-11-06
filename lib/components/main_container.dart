import 'package:flame/components.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/constants.dart';

class MainContainer extends PositionComponent {
  PositionComponent child;
  MainContainer({required this.child})
    : super(size: Vector2(1500, 850), position: Vector2(210, 148));

  @override
  Future<void> onLoad() async {
    //Shape of the main container
    RoundedRectangle inner = RoundedRectangle(
      radius: 8,
      color: ThemeColors.mainContainerBg,
      position: Vector2(3, 3),
      size: size,
    );
    RoundedRectangle outer = RoundedRectangle(
      radius: 8,
      size: size + Vector2(6, 6),
      color: ThemeColors.mainContainerOutline,
      children: [inner],
    );

    add(outer);
    add(child);
  }
}
