import 'dart:ui';
import 'package:flame/components.dart';

class RoundedRectangle extends PositionComponent {
  final double radius;
  final Color color;

  RoundedRectangle({
    required Vector2 size,
    required this.color,
    required this.radius,
    super.children,
    Vector2? position,
    Anchor anchor = Anchor.topLeft,
  }) : super(size: size, position: position ?? Vector2.zero(), anchor: anchor);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      Radius.circular(radius),
    );
    final paint = Paint()..color = color;
    canvas.drawRRect(rrect, paint);
  }
}
