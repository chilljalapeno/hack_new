import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/components/utils.dart';
import "package:hack_improved/constants.dart";
import 'package:flame/components.dart';
import 'package:flame/text.dart' as flame;

class UiHeader extends PositionComponent {
  UiHeader() : super(position: Vector2(96, 0), size: Vector2(1800, 100));

  @override
  // TODO: implement debugMode
  bool get debugMode => false;

  @override
  void onLoad() {
    Clock clock = Clock();
    HeaderText headerText = HeaderText();
    HeaderIcons headerIcons = HeaderIcons();

    RowComponent headerWithSpacer = RowComponent(
      children: [
        PositionComponent(size: Vector2(109, 0)),
        headerText,
      ],
    );

    RowComponent row = RowComponent(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      size: size,
      children: [clock, headerWithSpacer, headerIcons],
    );

    add(row);
  }
}

class HeaderText extends TextComponent {
  HeaderText()
    : super(
        text: "Server Network",
        textRenderer: TextPaint(
          style: flame.TextStyle(fontSize: 40, color: ThemeColors.uiHeader),
        ),
      );
}

class HeaderIcons extends PositionComponent with HasGameReference {
  HeaderIcons() : super(size: Vector2(300, 100));

  @override
  Future<void> onLoad() async {
    SpriteComponent battery = SpriteComponent.fromImage(
      game.images.fromCache("battery.png"),
    );
    SpriteComponent connection = SpriteComponent.fromImage(
      game.images.fromCache("connection.png"),
    );
    SpriteComponent wifi = SpriteComponent.fromImage(
      game.images.fromCache("wifi.png"),
    );

    // Box to fit the sprites
    double boxW = 50;
    double boxH = 100;

    final batteryImageSize = Vector2(
      battery.sprite!.image.width.toDouble(),
      battery.sprite!.image.height.toDouble(),
    );
    final connectionImageSize = Vector2(
      connection.sprite!.image.width.toDouble(),
      connection.sprite!.image.height.toDouble(),
    );
    final wifiImageSize = Vector2(
      wifi.sprite!.image.width.toDouble(),
      wifi.sprite!.image.height.toDouble(),
    );

    battery.size =
        batteryImageSize *
        Utils.scaleImages(
          boxSize: Vector2(boxW, boxH),
          imageSize: batteryImageSize,
        );
    connection.size =
        connectionImageSize *
        Utils.scaleImages(
          boxSize: Vector2(boxW, boxH),
          imageSize: connectionImageSize,
        );
    wifi.size =
        wifiImageSize *
        Utils.scaleImages(
          boxSize: Vector2(boxW, boxH),
          imageSize: wifiImageSize,
        );

    RowComponent row = RowComponent(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      size: size,
      children: [connection, wifi, battery],
    );

    add(row);
  }
}

class Clock extends TextComponent {
  Clock()
    : super(
        text: "",
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 32, color: ThemeColors.uiHeader),
        ),
        size: Vector2(100, 100),
      );

  @override
  void update(double dt) {
    super.update(dt);
    // Get current time and format as HH:MM:SS
    final now = DateTime.now();
    final timeString =
        "${now.hour.toString().padLeft(2, '0')}:"
        "${now.minute.toString().padLeft(2, '0')}";
    text = timeString;
  }
}
