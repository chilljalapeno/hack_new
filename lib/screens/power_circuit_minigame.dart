import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/components/ui_header.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/constants.dart';

enum WireColor { green, blue, red }

class PowerCircuitMinigame extends World with HasGameReference<HackGame> {
  final int panelNumber;
  final Function(int) onComplete;

  List<_PowerNode> leftNodes = [];
  List<_PowerNode> rightNodes = [];
  List<_WireConnection> connections = [];
  late _ManualPanel manualPanel;
  late _PowerButton powerButton;

  Map<WireColor, List<WireColor>> wiringRules = {};
  List<WireColor> activeColors = [];
  Set<String> requiredConnections = {};
  Set<String> currentConnections = {};

  PowerCircuitMinigame({required this.panelNumber, required this.onComplete});

  @override
  Future<void> onLoad() async {
    final screenWidth = GameDimensions.gameWidth;
    final screenHeight = GameDimensions.gameHeight;
    // Inner container bounds (match _addContainer insets)
    final double _containerTop =
        GameDimensions.circuitContainerMarginTop +
        GameDimensions.circuitContainerBorderWidth;
    final double _containerRight =
        screenWidth -
        GameDimensions.circuitContainerMarginHorizontal -
        GameDimensions.circuitContainerBorderWidth;
    final double _containerBottom =
        screenHeight -
        GameDimensions.circuitContainerMarginBottom -
        GameDimensions.circuitContainerBorderWidth;

    // Setup rules for this panel
    _setupPanelRules();

    // Background
    final background = RectangleComponent(
      size: Vector2(screenWidth, screenHeight),
      position: Vector2(0, 0),
      paint: Paint()..color = Color(0xFF001219),
    );
    add(background);

    // Add matrix pattern overlay
    add(_MatrixBackground(size: Vector2(screenWidth, screenHeight)));

    // Container panel (behind content)
    _addContainer(screenWidth, screenHeight);

    // Header
    _addHeader(screenWidth);

    // Alert bar
    _addAlertBar(screenWidth);

    // Wiring manual panel
    // Place the manual panel inside the container with a right margin
    final double _manualWidth = GameDimensions.circuitManualWidth;
    final double _rightMargin = GameDimensions.circuitManualRightMargin;
    final double _manualLeft = _containerRight - _rightMargin - _manualWidth;
    manualPanel = _ManualPanel(
      position: Vector2(_manualLeft, _containerTop + 170),
      size: Vector2(
        GameDimensions.circuitManualWidth,
        GameDimensions.circuitManualHeight,
      ),
      rules: wiringRules,
      level: panelNumber,
    );
    add(manualPanel);

    // Calculate center position between the two columns for button alignment
    final double manualLeftEdge =
        screenWidth -
        GameDimensions.circuitManualWidth -
        GameDimensions.circuitManualRightMargin;
    final double hospitalPowerGap = 60.0;
    final double availableSpace =
        manualLeftEdge - GameDimensions.circuitContainerMarginHorizontal;
    final double centerOfColumns =
        GameDimensions.circuitContainerMarginHorizontal +
        (availableSpace - hospitalPowerGap) / 2;

    // Power nodes
    _addPowerNodes(screenWidth, screenHeight);

    // Power button - centered between columns and positioned above bottom border
    powerButton = _PowerButton(
      // Center between Emergency Power and Hospital Power columns
      position: Vector2(
        centerOfColumns,
        _containerBottom - GameDimensions.circuitButtonBottomMargin - 40,
      ),
      size: Vector2(
        GameDimensions.circuitButtonWidth,
        GameDimensions.circuitButtonHeight,
      ),
      onTap: _onPowerButtonPressed,
    );
    add(powerButton);
  }

  void _addContainer(double screenWidth, double screenHeight) {
    // Dimensions with margins similar to reference
    final Vector2 outerSize = Vector2(
      GameDimensions.circuitContainerWidth,
      GameDimensions.circuitContainerHeight,
    );
    final Vector2 outerPos = Vector2(
      GameDimensions.circuitContainerMarginHorizontal,
      GameDimensions.circuitContainerMarginTop,
    );
    // Outer acts as border
    add(
      RoundedRectangle(
        size: outerSize,
        position: outerPos,
        radius: GameDimensions.largeBorderRadius,
        color: const Color(0xFF6DC5D9), // border color
      ),
    );
    // Inner fill slightly inset to reveal border
    add(
      RoundedRectangle(
        size:
            outerSize -
            Vector2(
              GameDimensions.circuitContainerBorderWidth * 2,
              GameDimensions.circuitContainerBorderWidth * 2,
            ),
        position:
            outerPos +
            Vector2(
              GameDimensions.circuitContainerBorderWidth,
              GameDimensions.circuitContainerBorderWidth,
            ),
        radius: GameDimensions.largeBorderRadius,
        color: const Color.fromARGB(255, 3, 34, 45), // darker panel fill
      ),
    );
  }

  void _setupPanelRules() {
    switch (panelNumber) {
      case 1:
        activeColors = [WireColor.green, WireColor.blue];
        wiringRules = {
          WireColor.green: [WireColor.blue],
          WireColor.blue: [WireColor.red],
          WireColor.red: [WireColor.green], // decoy
        };
        requiredConnections = {'green-blue', 'blue-red'};
        break;
      case 2:
        activeColors = [WireColor.red, WireColor.blue];
        wiringRules = {
          WireColor.red: [WireColor.blue, WireColor.red],
          WireColor.green: [WireColor.red], // decoy
          WireColor.blue: [WireColor.blue],
        };
        requiredConnections = {'red-blue', 'red-red', 'blue-blue'};
        break;
      case 3:
        activeColors = [WireColor.green, WireColor.red];
        wiringRules = {
          WireColor.green: [WireColor.green, WireColor.red],
          WireColor.blue: [WireColor.green], // decoy
          WireColor.red: [WireColor.red],
        };
        requiredConnections = {'green-green', 'green-red', 'red-red'};
        break;
      case 4:
        activeColors = [WireColor.red, WireColor.green];
        wiringRules = {
          WireColor.blue: [WireColor.red, WireColor.blue], // decoys
          WireColor.red: [WireColor.green],
          WireColor.green: [WireColor.red],
        };
        requiredConnections = {'red-green', 'green-red'};
        break;
    }
  }

  void _addHeader(double screenWidth) {
    // Status bar
    add(UiHeader());

    // Title
    add(
      TextComponent(
        text: 'Emergency Power',
        textRenderer: TextPaint(
          style: TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: Vector2(screenWidth / 2, GameDimensions.circuitTitleY),
        anchor: Anchor.center,
      ),
    );
  }

  void _addAlertBar(double screenWidth) {
    // Red background box
    final alertBox = RectangleComponent(
      position: Vector2(
        GameDimensions.circuitAlertMargin,
        GameDimensions.circuitAlertY,
      ),
      size: Vector2(
        screenWidth - GameDimensions.circuitAlertMargin * 2,
        GameDimensions.circuitAlertHeight,
      ),
      paint: Paint()..color = Color(0xFF671412),
    );
    add(alertBox);

    // Outline
    final alertOutline = RectangleComponent(
      position: Vector2(
        GameDimensions.circuitAlertMargin,
        GameDimensions.circuitAlertY,
      ),
      size: Vector2(
        screenWidth - GameDimensions.circuitAlertMargin * 2,
        GameDimensions.circuitAlertHeight,
      ),
      paint: Paint()
        ..color = Color(0xFFCA431A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = GameDimensions.outlineWidth,
    );
    add(alertOutline);

    // Alert text
    add(
      TextComponent(
        text: 'Connect the wires according to the manual',
        textRenderer: TextPaint(
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: Vector2(
          screenWidth / 2,
          GameDimensions.circuitAlertY + GameDimensions.circuitAlertHeight / 2,
        ),
        anchor: Anchor.center,
      ),
    );
  }

  void _addPowerNodes(double screenWidth, double screenHeight) {
    final double contentTop = GameDimensions.circuitNodeStartY;
    final double nodeDiameter = GameDimensions.circuitNodeDiameter;
    final double spacing = GameDimensions.circuitNodeSpacing;

    // Calculate center positions for each column
    // Position columns closer together and more towards the center of the screen
    final double manualLeftEdge =
        screenWidth -
        GameDimensions.circuitManualWidth -
        GameDimensions.circuitManualRightMargin;
    final double hospitalPowerGap =
        60.0; // Gap between Hospital Power and manual

    // Calculate available space between left margin and manual
    final double availableSpace =
        manualLeftEdge - GameDimensions.circuitContainerMarginHorizontal;
    final double columnSpacing = 600.0; // Space between the two columns

    // Center the two columns in the available space
    final double centerOfColumns =
        GameDimensions.circuitContainerMarginHorizontal +
        (availableSpace - hospitalPowerGap) / 2;
    final double leftColumnCenterX = centerOfColumns - columnSpacing / 2;
    final double rightColumnCenterX = centerOfColumns + columnSpacing / 2;

    final double startY = contentTop;
    final double headingY = startY - 40;

    // Left side - Emergency Power (only active colors)
    add(
      TextComponent(
        text: 'Emergency Power',
        textRenderer: TextPaint(
          style: TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        position: Vector2(leftColumnCenterX, headingY),
        anchor: Anchor.center,
      ),
    );

    for (int i = 0; i < activeColors.length; i++) {
      final node = _PowerNode(
        color: activeColors[i],
        position: Vector2(leftColumnCenterX, startY + 40 + (i * spacing)),
        isLeft: true,
        onDragStartCallback: _onNodeDragStart,
        onDragUpdateCallback: _onNodeDragUpdate,
        onDragEndCallback: _onNodeDragEnd,
        nodeDiameter: nodeDiameter,
      );
      leftNodes.add(node);
      add(node);
    }

    // Right side - Hospital Power (all three colors)
    add(
      TextComponent(
        text: 'Hospital Power',
        textRenderer: TextPaint(
          style: TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        position: Vector2(rightColumnCenterX, headingY),
        anchor: Anchor.center,
      ),
    );

    final allColors = [WireColor.green, WireColor.blue, WireColor.red];
    for (int i = 0; i < allColors.length; i++) {
      final node = _PowerNode(
        color: allColors[i],
        position: Vector2(rightColumnCenterX, startY + 40 + (i * spacing)),
        isLeft: false,
        nodeDiameter: nodeDiameter,
      );
      rightNodes.add(node);
      add(node);
    }
  }

  _PowerNode? _dragStartNode;
  _WireConnection? _currentDragWire;

  void _onNodeDragStart(_PowerNode node, Vector2 position) {
    _dragStartNode = node;
    _currentDragWire = _WireConnection(
      start: node.position.clone(),
      end: position,
      color: node.color,
      isTemporary: true,
    );
    add(_currentDragWire!);
  }

  void _onNodeDragUpdate(Vector2 position) {
    if (_currentDragWire != null) {
      _currentDragWire!.end = position;
    }
  }

  void _onNodeDragEnd(Vector2 position) {
    if (_dragStartNode == null || _currentDragWire == null) return;

    // Check if dropped on a right node
    _PowerNode? targetNode;
    for (var node in rightNodes) {
      if ((node.position - position).length < 40) {
        targetNode = node;
        break;
      }
    }

    // Remove temporary wire
    remove(_currentDragWire!);
    _currentDragWire = null;

    if (targetNode != null) {
      _createConnection(_dragStartNode!, targetNode);
    }

    _dragStartNode = null;
  }

  void _createConnection(_PowerNode start, _PowerNode end) {
    final connectionKey =
        '${_colorToString(start.color)}-${_colorToString(end.color)}';

    // Check if this connection already exists
    if (currentConnections.contains(connectionKey)) {
      return;
    }

    // Validate against wiring rules
    final validTargets = wiringRules[start.color] ?? [];
    final isValid = validTargets.contains(end.color);

    if (isValid) {
      // Create permanent connection
      final wire = _WireConnection(
        start: start.position.clone(),
        end: end.position.clone(),
        color: start.color,
        isTemporary: false,
      );
      connections.add(wire);
      add(wire);

      currentConnections.add(connectionKey);

      // Check if all required connections are complete
      _checkCompletion();
    } else {
      // Show error feedback
      final errorWire = _WireConnection(
        start: start.position.clone(),
        end: end.position.clone(),
        color: start.color,
        isTemporary: true,
        isError: true,
      );
      add(errorWire);

      // Remove error wire after brief flash
      Future.delayed(Duration(milliseconds: 300), () {
        remove(errorWire);
      });
    }
  }

  void _checkCompletion() {
    if (currentConnections.containsAll(requiredConnections) &&
        requiredConnections.containsAll(currentConnections)) {
      powerButton.activate();
    } else {
      powerButton.deactivate();
    }
  }

  void _onPowerButtonPressed() {
    if (powerButton.isActive) {
      // Animate wires lighting up
      for (var wire in connections) {
        wire.lightUp();
      }

      // Wait for animation then return to dashboard
      Future.delayed(Duration(milliseconds: 800), () {
        onComplete(panelNumber);
      });
    }
  }

  String _colorToString(WireColor color) {
    switch (color) {
      case WireColor.green:
        return 'green';
      case WireColor.blue:
        return 'blue';
      case WireColor.red:
        return 'red';
    }
  }
}

// Power Node Component
class _PowerNode extends PositionComponent with DragCallbacks {
  final WireColor color;
  final bool isLeft;
  final Function(_PowerNode, Vector2)? onDragStartCallback;
  final Function(Vector2)? onDragUpdateCallback;
  final Function(Vector2)? onDragEndCallback;
  final double nodeDiameter;

  Vector2? _lastDragPosition;

  _PowerNode({
    required this.color,
    required Vector2 position,
    required this.isLeft,
    this.onDragStartCallback,
    this.onDragUpdateCallback,
    this.onDragEndCallback,
    this.nodeDiameter = 120,
  }) : super(
         position: position,
         size: Vector2(nodeDiameter, nodeDiameter),
         anchor: Anchor.center,
       );

  @override
  Future<void> onLoad() async {
    final double outerRadius = nodeDiameter * 0.42; // glow circle
    final double mainRadius = nodeDiameter * 0.30; // main filled circle
    final double labelOffset = nodeDiameter * 0.22;
    // Outer glow circle
    final glowCircle = CircleComponent(
      radius: outerRadius,
      paint: Paint()..color = _getColor().withValues(alpha: 0.3),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(glowCircle);

    // Add pulsing effect to glow circle
    glowCircle.add(
      ScaleEffect.by(
        Vector2.all(1.2),
        EffectController(duration: 1.0, reverseDuration: 1.0, infinite: true),
      ),
    );

    // Main circle
    final mainCircle = CircleComponent(
      radius: mainRadius,
      paint: Paint()..color = _getColor(),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(mainCircle);

    // Add subtle pulsing effect to main circle
    mainCircle.add(
      ScaleEffect.by(
        Vector2.all(1.1),
        EffectController(duration: 1.2, reverseDuration: 1.2, infinite: true),
      ),
    );

    // Label
    add(
      TextComponent(
        text: _getColorName(),
        textRenderer: TextPaint(
          style: TextStyle(
            color: Colors.white,
            fontSize: (nodeDiameter * 0.20).clamp(16, 22),
            fontWeight: FontWeight.bold,
          ),
        ),
        position: Vector2(size.x / 2, size.y + labelOffset),
        anchor: Anchor.center,
      ),
    );
  }

  Color _getColor() {
    switch (color) {
      case WireColor.green:
        return Color(0xFF009E5E);
      case WireColor.blue:
        return Color(0xFF028AAA);
      case WireColor.red:
        return Color(0xFFB62D18);
    }
  }

  String _getColorName() {
    switch (color) {
      case WireColor.green:
        return 'Green';
      case WireColor.blue:
        return 'Blue';
      case WireColor.red:
        return 'Red';
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (isLeft && onDragStartCallback != null) {
      _lastDragPosition = event.localPosition + position;
      onDragStartCallback!(this, _lastDragPosition!);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (isLeft && onDragUpdateCallback != null) {
      _lastDragPosition = event.localEndPosition + position;
      onDragUpdateCallback!(_lastDragPosition!);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (isLeft && onDragEndCallback != null && _lastDragPosition != null) {
      onDragEndCallback!(_lastDragPosition!);
    }
  }
}

// Wire Connection Component
class _WireConnection extends PositionComponent {
  Vector2 start;
  Vector2 end;
  final WireColor color;
  final bool isTemporary;
  final bool isError;
  bool isLit = false;

  _WireConnection({
    required this.start,
    required this.end,
    required this.color,
    this.isTemporary = false,
    this.isError = false,
  });

  void lightUp() {
    isLit = true;
  }

  @override
  void render(Canvas canvas) {
    final wireColor = _getColor();

    // Draw glow effect
    if (!isTemporary || isError) {
      final glowPaint = Paint()
        ..color = (isError ? Colors.red : wireColor).withValues(alpha: 0.5)
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, isLit ? 12 : 6);
      canvas.drawLine(start.toOffset(), end.toOffset(), glowPaint);
    }

    // Draw main wire
    final wirePaint = Paint()
      ..color = isError ? Colors.red : wireColor
      ..strokeWidth = isLit ? 8 : 4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start.toOffset(), end.toOffset(), wirePaint);
  }

  Color _getColor() {
    switch (color) {
      case WireColor.green:
        return Color(0xFF009E5E);
      case WireColor.blue:
        return Color(0xFF028AAA);
      case WireColor.red:
        return Color(0xFFB62D18);
    }
  }
}

// Wiring Manual Panel
class _ManualPanel extends PositionComponent {
  final Map<WireColor, List<WireColor>> rules;
  final int level;

  _ManualPanel({
    required Vector2 position,
    required Vector2 size,
    required this.rules,
    required this.level,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    // Panel background
    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = Color(0xFF0D4761).withValues(alpha: 0.7),
      ),
    );

    // Border
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = Color(0xFF6DC5D9)
          ..style = PaintingStyle.stroke
          ..strokeWidth = GameDimensions.outlineWidth,
      ),
    );

    // Title
    add(
      TextComponent(
        text: 'Wiring Manual',
        textRenderer: TextPaint(
          style: TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: Vector2(size.x / 2, 40),
        anchor: Anchor.center,
      ),
    );
    add(
      TextComponent(
        text: 'Level $level',
        textRenderer: TextPaint(
          style: TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        position: Vector2(size.x / 2, 72),
        anchor: Anchor.center,
      ),
    );

    // Rules list with per-word coloring
    double yPos = 110;
    rules.forEach((fromColor, toColors) {
      for (var toColor in toColors) {
        final row = RowComponent(
          size: Vector2(size.x - 60, 40),
          position: Vector2(30, yPos),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          gap: 8,
          children: [
            TextComponent(
              text: _colorName(fromColor),
              textRenderer: TextPaint(
                style: TextStyle(
                  color: _getColorValue(fromColor),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextComponent(
              text: '→',
              textRenderer: TextPaint(
                style: TextStyle(
                  color: const Color(0xFF6DC5D9),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextComponent(
              text: _colorName(toColor),
              textRenderer: TextPaint(
                style: TextStyle(
                  color: _getColorValue(toColor),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
        add(row);
        yPos += 50;
      }
    });
  }

  String _colorName(WireColor color) {
    switch (color) {
      case WireColor.green:
        return 'Green';
      case WireColor.blue:
        return 'Blue';
      case WireColor.red:
        return 'Red';
    }
  }

  Color _getColorValue(WireColor color) {
    switch (color) {
      case WireColor.green:
        return Color(0xFF009E5E);
      case WireColor.blue:
        return Color(0xFF028AAA);
      case WireColor.red:
        return Color(0xFFB62D18);
    }
  }
}

// Power Button Component
class _PowerButton extends PositionComponent with TapCallbacks {
  bool isActive = false;
  final Function() onTap;

  _PowerButton({
    required Vector2 position,
    required Vector2 size,
    required this.onTap,
  }) : super(position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _updateButton();
  }

  void activate() {
    if (!isActive) {
      isActive = true;
      _updateButton();
    }
  }

  void deactivate() {
    if (isActive) {
      isActive = false;
      _updateButton();
    }
  }

  void _updateButton() {
    removeAll(children);

    // Background
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = isActive
              ? Color(0xFF0D4761)
              : Color(0xFF0D4761).withValues(alpha: 0.3),
      ),
    );

    // Border
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = isActive
              ? Color(0xFF6DC5D9)
              : Color(0xFF6DC5D9).withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = GameDimensions.outlineWidth,
      ),
    );

    // Text
    add(
      TextComponent(
        text: 'Turn Power On',
        textRenderer: TextPaint(
          style: TextStyle(
            color: isActive
                ? Color(0xFF6DC5D9)
                : Color(0xFF6DC5D9).withValues(alpha: 0.3),
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        position: size / 2,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isActive) {
      onTap();
    }
  }
}

// Matrix-style background component
class _MatrixBackground extends PositionComponent {
  _MatrixBackground({required Vector2 size}) : super(size: size);

  @override
  Future<void> onLoad() async {
    for (double x = 0; x < size.x; x += 30) {
      add(_MatrixColumn(position: Vector2(x, 0), height: size.y));
    }
  }
}

class _MatrixColumn extends PositionComponent {
  final double height;
  double offset = 0;

  _MatrixColumn({required Vector2 position, required this.height})
    : super(position: position) {
    offset = (position.x * 10) % height;
  }

  @override
  void render(Canvas canvas) {
    final textPaint = TextPaint(
      style: TextStyle(
        color: Color(0xFF00FF41).withValues(alpha: 0.1),
        fontSize: 12,
        fontFamily: 'monospace',
      ),
    );

    for (double y = offset % 40; y < height; y += 40) {
      if (y % 80 == 0) {
        final char = ['0', '1', '|', '/', '\\'][(position.x + y) ~/ 10 % 5];
        textPaint.render(canvas, char, Vector2(0, y));
      }
    }
  }
}
