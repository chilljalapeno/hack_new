import 'package:flame/components.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame/text.dart' as flame;
import 'package:flutter/widgets.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/components/server_zoomin.dart';
import 'package:hack_improved/constants.dart';

class EndScreen extends PositionComponent {
  EndScreen()
    : super(
        size: Vector2(1500, 850) - Vector2(96, 96),
        position: Vector2(210, 148) + Vector2(48, 48),
      );

  @override
  Future<void> onLoad() async {
    EndScreenHeader header = EndScreenHeader();

    ServerCard card1 = ServerCard(
      serverType: ServerType.infected,
      code: 'CXTSF',
      serverNumber: '1',
    );
    ServerCard card2 = ServerCard(
      serverType: ServerType.infected,
      code: 'CXTSF',
      serverNumber: '2',
    );
    ServerCard card3 = ServerCard(
      serverType: ServerType.safe,
      code: 'CXTSF',
      serverNumber: '3',
    );
    ServerCard card4 = ServerCard(
      serverType: ServerType.infected,
      code: 'CXTSF',
      serverNumber: '4',
    );
    ServerCard card5 = ServerCard(
      serverType: ServerType.safe,
      code: 'CXTSF',
      serverNumber: '5',
    );
    ServerCard card6 = ServerCard(
      serverType: ServerType.safe,
      code: 'CXTSF',
      serverNumber: '6',
    );
    ServerCard card7 = ServerCard(
      serverType: ServerType.infected,
      code: 'CXTSF',
      serverNumber: '7',
    );
    ServerCard card8 = ServerCard(
      serverType: ServerType.safe,
      code: 'CXTSF',
      serverNumber: '8',
    );

    ColumnComponent leftColumn = ColumnComponent(
      size: Vector2(500, 320) + Vector2(0, 60),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [card1, card2, card3, card4],
    );
    ColumnComponent rightColumn = ColumnComponent(
      size: Vector2(500, 320) + Vector2(0, 60),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [card5, card6, card7, card8],
    );

    RowComponent cardRows = RowComponent(
      size: Vector2(
        leftColumn.size.x + rightColumn.size.x + 60,
        leftColumn.size.y,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [leftColumn, rightColumn],
    );

    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        header,
        cardRows,
        RowComponent(
          size: Vector2(1060, 100),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ServerButtons(content: "Back to servers", color: Color(0x1A0D4761)),
            ServerButtons(
              content: "Confirm Server shutdown",
              color: Color(0xFF0D4761),
            ),
          ],
        ),
      ],
    );

    add(column);
  }
}

class ServerButtons extends PositionComponent {
  String content;
  Color color;
  ServerButtons({required this.content, required this.color})
    : super(size: Vector2(500, 80));

  @override
  Future<void> onLoad() async {
    RowComponent text = RowComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextComponent(
          text: content,
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 40, color: Color(0xFF6DC5D9)),
          ),
        ),
      ],
    );
    RoundedRectangle inner = RoundedRectangle(
      size: size,
      position: Vector2(3, 3),
      color: color,
      radius: 16,
      children: [text],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: size + Vector2(6, 6),
      color: ThemeColors.mainContainerOutline,
      radius: 16,
      children: [inner],
    );
    add(outer);
  }
}

class ServerCard extends PositionComponent {
  ServerType serverType;
  String code;
  String serverNumber;

  ServerCard({
    required this.serverType,
    required this.code,
    required this.serverNumber,
  }) : super(size: Vector2(500, 80));

  @override
  Future<void> onLoad() async {
    Color bgColor = switch (serverType) {
      ServerType.safe => ThemeColors.mainContainerBg,
      ServerType.infected => ThemeColors.infectedButtonBg,
      ServerType.unknown => ThemeColors.safeButtonBg,
    };
    Color outlineColor = switch (serverType) {
      ServerType.safe => ThemeColors.mainContainerOutline,
      ServerType.infected => ThemeColors.mainContainerHeaderOutline,
      ServerType.unknown => ThemeColors.mainContainerOutline,
    };
    Color textColor = switch (serverType) {
      ServerType.safe => ThemeColors.uiHeader,
      ServerType.infected => ThemeColors.headerBarStatusInfectedText,
      ServerType.unknown => ThemeColors.headerBarStatusUnknownText,
    };

    RowComponent text = RowComponent(
      size: Vector2(size.x - 32, size.y),
      position: Vector2(16, 0),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        TextComponent(
          text: "Server  $serverNumber",
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 40, color: textColor),
          ),
        ),
        TextComponent(
          text: code,
          textRenderer: TextPaint(
            style: flame.TextStyle(fontSize: 40, color: textColor),
          ),
        ),
      ],
    );

    RoundedRectangle inner = RoundedRectangle(
      size: size,
      position: Vector2(3, 3),
      color: bgColor,
      radius: 16,
      children: [text],
    );

    RoundedRectangle outer = RoundedRectangle(
      size: size + Vector2(6, 6),
      color: outlineColor,
      radius: 16,
      children: [inner],
    );

    add(outer);
  }
}

class EndScreenHeader extends PositionComponent {
  EndScreenHeader() : super(size: Vector2(900, 100));

  @override
  Future<void> onLoad() async {
    TextComponent firstText = TextComponent(
      text: "COMMUNICATE THE SHUTDOWN CODES OF",
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 32, color: ThemeColors.uiHeader),
      ),
    );
    TextComponent secondText = TextComponent(
      text: "OF THE INFECTED SERVERS TO SHUT THEM DOWN",
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 32, color: ThemeColors.uiHeader),
      ),
    );
    ColumnComponent column = ColumnComponent(
      size: size,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [firstText, secondText],
    );
    RoundedRectangle innerHeader = RoundedRectangle(
      size: size,
      position: Vector2(3, 3),
      color: ThemeColors.mainContainerBg,
      radius: 8,
      children: [column],
    );
    RoundedRectangle outerHeader = RoundedRectangle(
      size: size + Vector2(6, 6),
      color: ThemeColors.mainContainerOutline,
      radius: 8,
      children: [innerHeader],
    );

    add(outerHeader);
  }
}
