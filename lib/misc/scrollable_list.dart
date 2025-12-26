// import 'dart:ui';

// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flutter/painting.dart';

// class ListItemComponent extends PositionComponent {
//   ListItemComponent({
//     required this.component,
//     required double width,
//     required double height,
//   }) {
//     size = Vector2(width, height);
//   }

//   final PositionComponent component;

//   late final TextPaint _textPaint = TextPaint(
//     style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
//   );

//   @override
//   void render(Canvas canvas) {
//     final bgPaint = Paint()..color = const Color(0xFF333333);
//     canvas.drawRect(size.toRect(), bgPaint);

//     _textPaint.render(canvas, text, Vector2(8, size.y / 2 - 10));
//   }
// }

// class ScrollableListComponent<T> extends PositionComponent with DragCallbacks {
//   ScrollableListComponent({
//     required this.viewportSize,
//     required this.itemHeight,
//     required this.items,
//   }) {
//     size = viewportSize.clone();
//   }

//   final Vector2 viewportSize;
//   final double itemHeight;
//   final List<T> items;

//   double scrollOffset = 0.0;

//   final List<ListItemComponent> _children = [];

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();

//     for (var i = 0; i < items.length; i++) {
//       final child = ListItemComponent(
//         // text: items[i],
//         width: viewportSize.x,
//         height: itemHeight,
//       )..position = Vector2(0, i * itemHeight);
//       _children.add(child);
//     }
//   }

//   double get _contentHeight => items.length * itemHeight;

//   double get _maxScrollOffset =>
//       (_contentHeight - viewportSize.y).clamp(0.0, double.infinity);

//   void _clampScrollOffset() {
//     if (scrollOffset < 0) scrollOffset = 0;
//     if (scrollOffset > _maxScrollOffset) scrollOffset = _maxScrollOffset;
//   }

//   @override
//   void render(Canvas canvas) {
//     // Viewport background
//     final bg = Paint()..color = const Color(0x88000000);
//     canvas.drawRect(size.toRect(), bg);

//     canvas.save();
//     canvas.clipRect(size.toRect());
//     canvas.translate(0, -scrollOffset);

//     final firstVisible = (scrollOffset ~/ itemHeight).clamp(0, items.length);
//     final lastVisible = ((scrollOffset + viewportSize.y) ~/ itemHeight + 1)
//         .clamp(0, items.length);

//     for (var i = firstVisible; i < lastVisible; i++) {
//       final child = _children[i];
//       canvas.save();
//       canvas.translate(child.x, child.y);
//       child.render(canvas);
//       canvas.restore();
//     }

//     canvas.restore();
//   }

//   @override
//   void onDragUpdate(DragUpdateEvent event) {
//     // localDelta already accounts for camera/zoom in new API.[web:136]
//     final dy = event.localDelta.y;
//     scrollOffset -= dy;
//     _clampScrollOffset();
//   }
// }
//

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class ScrollList<T extends PositionComponent> extends PositionComponent
    with DragCallbacks {
  ScrollList({
    required Vector2 viewportSize,
    required this.itemHeight,
    required List<T> items,
  }) : _items = items {
    size = viewportSize;
    anchor = Anchor.topLeft;
  }

  final double itemHeight;
  final List<T> _items; // not in the game tree anywhere else
  double scrollOffset = 0;

  double get _contentHeight => _items.length * itemHeight;
  double get _maxScroll =>
      (_contentHeight - size.y).clamp(0.0, double.infinity);

  void _clampScroll() {
    if (scrollOffset < 0) scrollOffset = 0;
    if (scrollOffset > _maxScroll) scrollOffset = _maxScroll;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    for (var i = 0; i < _items.length; i++) {
      final c = _items[i]
        ..anchor = Anchor.topLeft
        ..position = Vector2(0, i * itemHeight);
      // Do NOT add(c); keep them only in _items.
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(position.x, position.y);

    // Background.
    final bg = Paint()..color = const Color(0xFF222222);
    canvas.drawRect(size.toRect(), bg);

    // Clip + scroll.
    canvas.save();
    canvas.clipRect(size.toRect());
    canvas.translate(0, -scrollOffset);

    final firstVisible = (scrollOffset ~/ itemHeight).clamp(0, _items.length);
    final lastVisible = ((scrollOffset + size.y) ~/ itemHeight + 1).clamp(
      0,
      _items.length,
    );

    for (var i = firstVisible; i < lastVisible; i++) {
      final child = _items[i];

      canvas.save();
      canvas.translate(child.position.x, child.position.y);
      child.render(canvas); // single render path
      canvas.restore();
    }

    canvas.restore();
    canvas.restore();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    scrollOffset -= event.localDelta.y;
    _clampScroll();
  }
}
