import 'package:flame/events.dart';
import "package:flame/components.dart";
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/level-six/bloc/level_six_bloc.dart';
import 'package:hack_improved/misc/constants.dart';

class ToFindValues extends PositionComponent
    with TapCallbacks, FlameBlocListenable<LevelSixBloc, LevelSixState> {
  PositionComponent content;
  late RectangleComponent outer;
  int emailNumber;

  ToFindValues({required this.content, required this.emailNumber}) : super();
  bool isActive = false;

  @override
  Future<void> onLoad() async {
    size = content.size + Vector2(6, 6);
    RectangleComponent inner = RectangleComponent(
      size: content.size,
      paint: Paint()..color = ThemeColors.mainContainerBg,
      position: Vector2(3, 3),
      children: [content],
    );
    outer = RectangleComponent(
      size: content.size + Vector2(6, 6),
      paint: Paint()..color = Colors.transparent,
      children: [inner],
    );
    add(outer);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isActive) {
      outer.paint.color = Colors.red;
    } else {
      outer.paint.color = Colors.transparent;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    bloc.add(
      LevelSixEvent.change(
        emailNumber: emailNumber,
        increase: isActive ? -1 : 1,
      ),
    );
    isActive = !isActive;
  }
}
