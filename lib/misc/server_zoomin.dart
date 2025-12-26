import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame/text.dart' as flame;
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/level_two/bloc/level_two_bloc.dart';
import 'package:hack_improved/level_two/models/server_type.dart';
import 'package:hack_improved/misc/constants.dart';
import 'package:hack_improved/misc/moving_lines.dart';
import 'package:hack_improved/misc/rounded_rectangle.dart';
import 'package:hack_improved/misc/utils.dart';

enum NetworkStatus { unknown, normal, overload }

enum FirewallStatus { secure, unknown, open }

enum ButtonType { safe, infected }

class ServerZoomIn extends PositionComponent {
  final int serverNumber;
  final NetworkStatus networkStatus;
  final FirewallStatus firewallStatus;

  ServerZoomIn({
    required this.serverNumber,
    required this.networkStatus,
    required this.firewallStatus,
  }) : super(
         size: Vector2(1500, 850) - Vector2(96, 96),
         position: Vector2(48, 48),
       );

  final serversType = <ServerType>[
    ServerType.infected,
    ServerType.infected,
    ServerType.safe,
    ServerType.infected,
    ServerType.safe,
    ServerType.safe,
    ServerType.infected,
    ServerType.safe,
  ];

  @override
  Future<void> onLoad() async {
    assert(serversType.length == 8, "The number of server types should be 8");
    ServerZoomInHeader header = ServerZoomInHeader(
      serverNumber: serverNumber,
      serverType: serversType[serverNumber],
    );

    ServerZoomInCpuNetworkFirewall rightSide = ServerZoomInCpuNetworkFirewall(
      networkStatus: networkStatus,
      firewallStatus: firewallStatus,
    );

    ServerZoomInLog log = ServerZoomInLog(
      serverNumber: serverNumber,
      tSize: Vector2(1000, rightSide.size.y - 200),
    );

    ServerZoomInButton button = ServerZoomInButton(
      textColor: ThemeColors.safeButtonText,
      outlineColor: ThemeColors.safeButtonOutline,
      bgColor: ThemeColors.safeButtonBg,
      text: "Safe",
      type: ButtonType.safe,
      serverNumber: serverNumber,
      image: "check.png",
    );
    ServerZoomInButton button3 = ServerZoomInButton(
      textColor: ThemeColors.infectedButtonText,
      outlineColor: ThemeColors.infectedButtonOutline,
      bgColor: ThemeColors.infectedButtonBg,
      text: "Infected",
      type: ButtonType.infected,
      serverNumber: serverNumber,
      image: "alert_icon.png",
    );

    RowComponent buttons = RowComponent(
      size: Vector2(log.size.x, 152),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [button, button3],
    );

    ColumnComponent leftSide = ColumnComponent(
      size: Vector2(log.size.x, rightSide.size.y),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [log, buttons],
    );

    RowComponent sides = RowComponent(
      size: Vector2(size.x, rightSide.size.y),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [leftSide, rightSide],
    );

    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [header, sides],
    );

    add(column);
  }
}

class ServerZoomInHeader extends PositionComponent {
  final int serverNumber;
  final ServerType serverType;
  ServerZoomInHeader({required this.serverNumber, required this.serverType})
    : super(size: Vector2(900, 100));

  @override
  Future<void> onLoad() async {
    Color textColor = switch (serverType) {
      ServerType.safe => ThemeColors.headerBarStatusSafeText,
      ServerType.infected => ThemeColors.headerBarStatusInfectedText,
      ServerType.unknown => ThemeColors.headerBarStatusUnknownText,
    };
    Color bgColor = switch (serverType) {
      ServerType.safe => ThemeColors.headerBarStatusSafeBg,
      ServerType.infected => ThemeColors.headerBarStatusInfectedBg,
      ServerType.unknown => ThemeColors.headerBarStatusUnknownBg,
    };
    Color outlineColor = switch (serverType) {
      ServerType.safe => ThemeColors.headerBarStatusSafeOutline,
      ServerType.infected => ThemeColors.headerBarStatusInfectedOutline,
      ServerType.unknown => ThemeColors.headerBarStatusUnknownOutline,
    };

    String content = switch (serverType) {
      ServerType.safe => "Server ${serverNumber + 1} - Identified safe",
      ServerType.infected => "Server ${serverNumber + 1} - Identified infected",
      ServerType.unknown => "Server ${serverNumber + 1} - Identified unknown",
    };

    TextComponent text = TextComponent(
      text: content,
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 48, color: textColor),
      ),
    );
    RowComponent row = RowComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: 48,
      children: [text],
    );
    RoundedRectangle inner = RoundedRectangle(
      radius: 8,
      color: bgColor,
      position: Vector2(3, 3),
      size: size,
      children: [row],
    );
    RoundedRectangle outer = RoundedRectangle(
      radius: 8,
      size: size + Vector2(6, 6),
      color: outlineColor,
      children: [inner],
    );
    add(outer);
  }
}

class ServerZoomInButton extends PositionComponent
    with
        HasGameReference<HackGame>,
        TapCallbacks,
        FlameBlocReader<LevelTwoBloc, LevelTwoState> {
  final Color bgColor;
  final Color textColor;
  final Color outlineColor;
  final String text;
  final String image;
  final int serverNumber;
  final ButtonType type;

  ServerZoomInButton({
    required this.bgColor,
    required this.textColor,
    required this.outlineColor,
    required this.text,
    required this.image,
    required this.serverNumber,
    required this.type,
  }) : super(size: Vector2(400, 125));

  @override
  Future<void> onLoad() async {
    final content = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 40, color: textColor),
      ),
    );
    final iconSize = Vector2(64, 64);
    final icon = SpriteComponent.fromImage(game.images.fromCache(image));
    icon.size *= Utils.scaleImages(boxSize: iconSize, imageSize: icon.size);

    final row = RowComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: 24,
      children: [icon, content],
    );

    final inner = RoundedRectangle(
      size: size - Vector2(6, 6),
      position: Vector2(3, 3),
      color: bgColor,
      radius: 16,
      children: [row],
    );
    final outer = RoundedRectangle(
      size: size,
      color: outlineColor,
      radius: 16,
      children: [inner],
    );
    add(outer);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.levelTwo.router.pop();
    switch (type) {
      case ButtonType.safe:
        bloc.add(LevelTwoEvent.safe(serverNumber: serverNumber));
        break;
      case ButtonType.infected:
        bloc.add(LevelTwoEvent.infected(serverNumber: serverNumber));
        break;
    }
  }
}

class ServerZoomInCpuNetworkFirewall extends PositionComponent {
  final NetworkStatus networkStatus;
  final FirewallStatus firewallStatus;

  ServerZoomInCpuNetworkFirewall({
    required this.networkStatus,
    required this.firewallStatus,
  }) : super(size: Vector2(300, 850 - 100 - 144));

  @override
  Future<void> onLoad() async {
    RoundedRectangle inner = RoundedRectangle(
      size: size - Vector2(6, 6),
      position: Vector2(3, 3),
      color: ThemeColors.mainContainerBg,
      radius: 16,
    );
    RoundedRectangle outer = RoundedRectangle(
      size: size,
      color: ThemeColors.mainContainerOutline,
      radius: 16,
      children: [inner],
    );

    final Color networkColor = switch (networkStatus) {
      NetworkStatus.unknown => ThemeColors.headerBarStatusUnknownText,
      NetworkStatus.normal => ThemeColors.headerBarStatusSafeText,
      NetworkStatus.overload => ThemeColors.headerBarStatusInfectedText,
    };

    final String networkText = switch (networkStatus) {
      NetworkStatus.unknown => "UNKNOWN",
      NetworkStatus.normal => "NORMAL",
      NetworkStatus.overload => "OVERLOAD",
    };

    final Color firewallColor = switch (firewallStatus) {
      FirewallStatus.unknown => ThemeColors.headerBarStatusUnknownText,
      FirewallStatus.secure => ThemeColors.headerBarStatusSafeText,
      FirewallStatus.open => ThemeColors.headerBarStatusInfectedText,
    };

    final String firewallText = switch (firewallStatus) {
      FirewallStatus.unknown => "UNKNOWN",
      FirewallStatus.secure => "NORMAL",
      FirewallStatus.open => "OVERLOAD",
    };

    ColumnComponent network = ColumnComponent(
      size: Vector2(size.x, 110),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextComponent(
          text: "NETWORK",
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 48, color: networkColor),
          ),
        ),
        TextComponent(
          text: networkText,
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 48, color: networkColor),
          ),
        ),
      ],
    );

    ColumnComponent firewall = ColumnComponent(
      size: Vector2(size.x, 110),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextComponent(
          text: "FIREWALL",
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 48, color: firewallColor),
          ),
        ),
        TextComponent(
          text: firewallText,
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 48, color: firewallColor),
          ),
        ),
      ],
    );

    RandomLoadingBarsComponent cpuAnimation = RandomLoadingBarsComponent(
      barWidth: size.x * 0.7,
      barHeight: 14,
      barGap: 4,
      barCount: 3,
      bgColor: const Color(0xFF212121),
      fillColor: ThemeColors.uiHeader,
      animationSpeed: 84,
      cornerRadius: 8,
    );

    TextComponent cpuText = TextComponent(
      text: "CPU",
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 48, color: Color(0xFFC1C18E)),
      ),
    );

    ColumnComponent cpu = ColumnComponent(
      size: Vector2(size.x, cpuText.size.y + cpuAnimation.size.y),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [cpuText, cpuAnimation],
    );

    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [cpu, network, firewall],
    );

    outer.add(column);

    add(outer);
  }
}

class ServerZoomInLog extends PositionComponent with HasGameReference {
  Vector2 tSize;
  int serverNumber;
  ServerZoomInLog({required this.tSize, required this.serverNumber})
    : super(size: tSize);

  final server0Text = <String>[
    "Unknown program started: temp_sync.tmp",
    "Short connection made to an external address",
    "Staff login failed three times in a row",
    "Firewall setting changed without approval",
  ];
  final server1Text = <String>[
    "Installed file found: export_tool.exe",
    "Network unusually active around 03:00",
    "User account opened from another department",
    "Large data transfer sent outside the hospital",
  ];
  final server2Text = <String>[
    "Backup finished successfully",
    "Login attempt from night shift — password correct",
    "Brief network spike at 02:55 (auto-resolved)",
    "CPU load stable",
  ];
  final server3Text = <String>[
    "Failed login from unknown location",
    "New file created: svc_update.dat",
    "System reached out to an unlisted IP address",
    "Virus scanner briefly showed a warning, then cleared",
  ];
  final server4Text = <String>[
    "Printer in Ward C reported repeated errors",
    "Restart completed after small delay",
    "Backup completed, minor warning: “checksum mismatch”",
    "No unusual network connections detected",
  ];
  final server5Text = <String>[
    "Nurse logged in with correct credentials",
    "Scheduled update installed overnight",
    "CPU usage normal (18%)",
    "Short connection drop automatically fixed",
  ];
  final server6Text = <String>[
    "Unknown file active: network_probe.exe",
    "Login from unrecognized tablet at 02:34",
    "Sending large data packets outside network",
    "Security log entries partially deleted",
  ];
  final server7Text = <String>[
    "Failed login from unknown location",
    "New file created: svc_update.dat",
    "System reached out to an unlisted IP address",
    "Virus scanner briefly showed a warning, then cleared",
  ];

  final serverIcons = ["folder.png", "node.png", "human.png", "arrows.png"];

  @override
  Future<void> onLoad() async {
    final Map<int, List<String>> serversText = {
      0: server0Text,
      1: server1Text,
      2: server2Text,
      3: server3Text,
      4: server4Text,
      5: server5Text,
      6: server6Text,
      7: server7Text,
    };

    PositionComponent spacer = PositionComponent(size: Vector2(16, 50));
    TextComponent header = TextComponent(
      text: "Server log",
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 40, color: ThemeColors.logText),
      ),
    );
    RowComponent row = RowComponent(children: [spacer, header], gap: 8);
    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [row],
    );

    for (int i = 0; i < 4; i += 1) {
      // Icon and scaling
      SpriteComponent sprite = SpriteComponent.fromImage(
        game.images.fromCache(serverIcons[i]),
      );
      final Vector2 scaleBox = Vector2(50, 50);
      sprite.size *= Utils.scaleImages(
        boxSize: scaleBox,
        imageSize: sprite.size,
      );

      TextComponent text = TextComponent(
        text: serversText[serverNumber]![i],
        textRenderer: TextPaint(
          style: flame.TextStyle(fontSize: 32, color: ThemeColors.logText),
        ),
      );

      PositionComponent spacer = PositionComponent(size: Vector2(16, 50));
      RowComponent row = RowComponent(
        size: Vector2(size.x, 50),
        gap: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [spacer, sprite, text],
      );
      column.add(row);
    }

    RoundedRectangle inner = RoundedRectangle(
      radius: 8,
      position: Vector2(3, 3),
      size: size - Vector2(6, 6),
      color: ThemeColors.mainContainerBg,
      children: [column],
    );
    RoundedRectangle outer = RoundedRectangle(
      radius: 8,
      position: position,
      size: size,
      color: ThemeColors.mainContainerOutline,
      children: [inner],
    );

    add(outer);
  }
}
