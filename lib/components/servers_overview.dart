import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame/text.dart' as flame;
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/blocs/level_two_bloc.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/components/utils.dart';
import 'package:hack_improved/constants.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/models/server_type.dart';

class ServerOverview extends PositionComponent {
  ServerOverview() : super(size: Vector2(1500, 850));

  @override
  Future<void> onLoad() async {
    ServersOverviewHeader header = ServersOverviewHeader();
    ServerSection serverSection = ServerSection(size: size - Vector2(300, 300));
    CheckButton check = CheckButton();
    PositionComponent topSpacer = PositionComponent(size: Vector2(0, 48));
    ColumnComponent headerWSpacer = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [topSpacer, header],
    );

    ColumnComponent column = ColumnComponent(
      size: size - Vector2(0, 48),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [headerWSpacer, serverSection, check],
    );
    add(column);
    return super.onLoad();
  }
}

class ServersOverviewHeader extends PositionComponent with HasGameReference {
  ServersOverviewHeader() : super(size: Vector2(900, 124));
  @override
  Future<void> onLoad() async {
    TextComponent text = TextComponent(
      text: "Alert: Malware detected".toUpperCase(),
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 40,
          color: ThemeColors.headerBarStatusInfectedText,
        ),
      ),
    );
    TextComponent text2 = TextComponent(
      text: "Identify Infected Servers".toUpperCase(),

      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 40,
          color: ThemeColors.headerBarStatusInfectedText,
        ),
      ),
    );
    SpriteComponent alertIcon = SpriteComponent.fromImage(
      game.images.fromCache("alert_icon.png"),
    );
    alertIcon.size *= Utils.scaleImages(
      boxSize: Vector2(80, 80),
      imageSize: alertIcon.size,
    );

    PositionComponent spacer = PositionComponent(size: Vector2(0, 0));
    ColumnComponent column = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [text, text2],
    );
    RowComponent row = RowComponent(
      size: size,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: 48,
      children: [spacer, alertIcon, column],
    );
    RoundedRectangle inner = RoundedRectangle(
      radius: 16,
      color: ThemeColors.mainContainerHeaderBg,
      position: Vector2(3, 3),
      size: size,
      children: [row],
    );
    RoundedRectangle outer = RoundedRectangle(
      radius: 16,
      size: size + Vector2(6, 6),
      color: ThemeColors.mainContainerHeaderOutline,
      children: [inner],
    );

    add(outer);
  }
}

class CheckButton extends PositionComponent
    with TapCallbacks, HasGameReference<HackGame> {
  CheckButton() : super(size: Vector2(550, 80));

  @override
  Future<void> onLoad() async {
    TextComponent text = TextComponent(
      text: "Check Server Status",
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 32,
          color: ThemeColors.checkServerStatusText,
        ),
      ),
    );
    RoundedRectangle rectangle = RoundedRectangle(
      radius: 16,
      size: size,
      color: ThemeColors.checkServerStatusBg,
      children: [
        RowComponent(
          size: size,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [text],
        ),
      ],
    );
    add(rectangle);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add("ServerStatus", priority: 1);
  }
}

class ServerBox extends PositionComponent
    with
        HasGameReference<HackGame>,
        TapCallbacks,
        FlameBlocListenable<LevelTwoBloc, LevelTwoState> {
  SpriteComponent sprite;
  final int serverNumber;

  ServerBox({
    required this.sprite,
    required this.serverNumber,
    required super.position,
    required super.size,
  });

  @override
  void update(double dt) {
    if (bloc.state is Initial) {
      switch ((bloc.state as Initial).servers[serverNumber]) {
        case ServerType.unknown:
          remove(sprite);
          sprite = SpriteComponent.fromImage(
            game.images.fromCache("blue_server.png"),
            paint: Paint()
              ..colorFilter = ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
          );
          add(sprite);
        case ServerType.safe:
          remove(sprite);
          sprite = SpriteComponent.fromImage(
            game.images.fromCache("green_server.png"),
          );
          add(sprite);
        case ServerType.infected:
          remove(sprite);
          sprite = SpriteComponent.fromImage(
            game.images.fromCache("red_server.png"),
          );
          add(sprite);
      }
    }
    super.update(dt);
  }

  @override
  Future<void> onLoad() async {
    add(sprite);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.levelTwo.router.pushNamed("server$serverNumber");
  }
}

class ServerSection extends PositionComponent
    with
        HasGameReference<HackGame>,
        FlameBlocListenable<LevelTwoBloc, LevelTwoState> {
  late SpriteComponent sprite;
  late int serverNumber;

  ServerSection({required super.size});

  @override
  Future<void> onLoad() async {
    int rowNoIcons = 4;
    int colNoIcons = 2;
    Vector2 iconSize = Vector2(257, 194);

    final double spaceX = (size.x - iconSize.x * rowNoIcons) / (rowNoIcons + 1);
    final double spaceY = (size.y - iconSize.y * colNoIcons) / (colNoIcons + 1);

    double x = spaceX, y = spaceY;

    for (int i = 0; i < 8; i++) {
      serverNumber = i;
      sprite = SpriteComponent.fromImage(
        game.images.fromCache("blue_server.png"),
        paint: Paint()
          ..colorFilter = ColorFilter.mode(Colors.grey, BlendMode.saturation),
      );

      sprite.size *= Utils.scaleImages(
        boxSize: iconSize,
        imageSize: sprite.size,
      );

      add(
        ServerBox(
          serverNumber: i,
          sprite: sprite,
          position: Vector2(x, y),
          size: iconSize,
        ),
      );

      x += spaceX + iconSize.x;
      if (i != 0 && (i + 1) % rowNoIcons == 0) {
        x = spaceX;
        y += spaceY + iconSize.y;
      }
    }
    return super.onLoad();
  }
}
