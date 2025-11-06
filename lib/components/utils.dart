import 'package:flame/components.dart';

class Utils {
  static double scaleImages({
    required Vector2 boxSize,
    required Vector2 imageSize,
  }) {
    double imageAspect = imageSize.x / imageSize.y;
    double boxAspect = boxSize.x / boxSize.y;
    double scale;

    if (imageAspect > boxAspect) {
      scale = boxSize.x / imageSize.x;
    } else {
      scale = boxSize.y / imageSize.y;
    }
    return scale;
  }
}
