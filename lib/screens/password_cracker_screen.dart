import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flutter/material.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/components/utils.dart';
import 'package:hack_improved/constants.dart';
import 'package:hack_improved/hack_game.dart';

/// Password Cracker screen for Level 5 Phase 3
/// Player uses collected clues to guess the employee's password
class PasswordCrackerScreen extends World with HasGameReference<HackGame> {
  bool _showOverlay = true;
  String _currentAttempt = '';
  bool _isCorrect = false;
  _PasswordDisplay? _passwordDisplay;
  _StatusText? _statusText;
  _PasswordInput? _passwordInput;
  _ActionButton? _actionButton;

  // The correct password
  static const String correctPassword = 'Cooper1972';

  // Clues to display (passed from LinkedIn screen)
  final Set<String> cluesFound;

  PasswordCrackerScreen({required this.cluesFound});

  // Expose input methods for overlay
  void updateInputText(String text) {
    _currentAttempt = text;
    _passwordInput?.setText(text);
  }

  void unfocusInput() {
    _passwordInput?._hasFocus = false;
    _passwordInput?._buildContent();
  }

  // Expose input box position and size for overlay alignment
  Vector2 get inputBoxPosition =>
      _passwordInput?.absolutePosition ?? Vector2(GameDimensions.gameWidth / 2 - 225, 460);
  Vector2 get inputBoxSize => _passwordInput?.size ?? Vector2(450, 60);

  String get currentInputText => _currentAttempt;

  @override
  Future<void> onLoad() async {
    final screenWidth = GameDimensions.gameWidth;
    final screenHeight = GameDimensions.gameHeight;

    // Background with binary code pattern
    add(
      SpriteComponent(
        sprite: Sprite(
          game.images.fromCache('phase0_icons/hacker_background.png'),
        ),
        size: Vector2(screenWidth, screenHeight),
        position: Vector2(0, 0),
      ),
    );

    // Header
    add(_PasswordCrackerHeader());

    // Main container
    add(
      RoundedRectangle(
        size: Vector2(screenWidth - 120, screenHeight - 120),
        position: Vector2(60, 80),
        color: ThemeColors.mainContainerBg,
        radius: GameDimensions.borderRadius,
      ),
    );

    // Instruction box
    await _addInstructionBox();

    // Password display boxes
    _passwordDisplay = _PasswordDisplay(
      position: Vector2(screenWidth / 2, 320),
      charCount: correctPassword.length,
    );
    add(_passwordDisplay!);

    // Status text (hidden until first attempt)
    _statusText = _StatusText(
      position: Vector2(screenWidth / 2, 240),
    );
    add(_statusText!);

    // Password input field
    _passwordInput = _PasswordInput(
      position: Vector2(screenWidth / 2 - 225, 460),
      onTextChanged: _onTextChanged,
    );
    add(_passwordInput!);

    // Verify Login / Continue button
    _actionButton = _ActionButton(
      position: Vector2(screenWidth / 2 - 150, 560),
      onTap: _onActionButtonTap,
    );
    add(_actionButton!);

    // Clues found section
    await _addCluesSection();

    // Show explanation overlay on first load
    if (_showOverlay) {
      add(_ExplanationOverlay(onDismiss: _dismissOverlay));
    }

    return super.onLoad();
  }

  void _dismissOverlay() {
    _showOverlay = false;
    final overlay = children.whereType<_ExplanationOverlay>().firstOrNull;
    overlay?.removeFromParent();
  }

  void _onTextChanged(String text) {
    _currentAttempt = text;
  }

  void _onActionButtonTap() {
    if (_isCorrect) {
      // Continue to next level/screen
      debugPrint('Password correct! Continue to next screen');
      // TODO: Navigate to next screen after password cracker
    } else {
      // Verify the password attempt
      _verifyPassword();
    }
  }

  void _verifyPassword() {
    if (_currentAttempt.isEmpty) return;

    // Pad or truncate to match password length
    final attempt = _currentAttempt.padRight(correctPassword.length).substring(
      0,
      correctPassword.length,
    );

    // Check each character
    final results = <bool>[];
    for (int i = 0; i < correctPassword.length; i++) {
      final attemptChar = attempt[i].toUpperCase();
      final correctChar = correctPassword[i].toUpperCase();
      results.add(attemptChar == correctChar);
    }

    // Check if all correct
    _isCorrect = results.every((r) => r);

    // Update display
    _passwordDisplay?.updateDisplay(attempt, results);
    _statusText?.updateStatus(_isCorrect);
    _actionButton?.updateButtonState(_isCorrect);

    // Clear input after attempt
    _passwordInput?.clearInput();
  }

  Future<void> _addInstructionBox() async {
    final screenWidth = GameDimensions.gameWidth;

    // Instruction container
    add(
      _BorderedBox(
        size: Vector2(700, 80),
        position: Vector2((screenWidth - 700) / 2, 105),
        fillColor: const Color(0xFF1A2A3A),
        borderColor: const Color(0xFF3A5A7A),
      ),
    );

    // Instruction text line 1
    add(
      TextComponent(
        text: 'Find the correct password based on',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(screenWidth / 2, 125),
        anchor: Anchor.center,
      ),
    );

    // Instruction text line 2
    add(
      TextComponent(
        text: 'earlier employee information',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(screenWidth / 2, 155),
        anchor: Anchor.center,
      ),
    );
  }

  Future<void> _addCluesSection() async {
    final screenWidth = GameDimensions.gameWidth;
    final containerWidth = screenWidth - 120;

    // Clues container
    add(
      _BorderedBox(
        size: Vector2(containerWidth - 40, 150),
        position: Vector2(80, 680),
        fillColor: const Color(0xFF1A2A3A),
        borderColor: const Color(0xFF3A5A7A),
      ),
    );

    // "Clues found:" label
    add(
      TextComponent(
        text: 'Clues found:',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(110, 700),
      ),
    );

    // The clues are displayed statically since they were all collected
    // before reaching this screen

    // Build the clues display - Row 1
    final row1Clues = ['Harper Collins', '1972', 'Rotterdam'];
    final row1Text = row1Clues.join('  ');
    add(
      TextComponent(
        text: row1Text,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(280, 700),
      ),
    );

    // Row 2
    final row2Clues = ['Photography', 'Sailing', 'Jazz Music'];
    final row2Text = row2Clues.join('  ');
    add(
      TextComponent(
        text: row2Text,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(280, 735),
      ),
    );

    // Row 3
    final row3Clues = ['Golden Retriever', 'Cooper', '26-11'];
    final row3Text = row3Clues.join('  ');
    add(
      TextComponent(
        text: row3Text,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(280, 770),
      ),
    );
  }
}

/// Header for Password Cracker screen
class _PasswordCrackerHeader extends PositionComponent {
  _PasswordCrackerHeader()
    : super(
        position: Vector2(GameDimensions.headerHorizontalMargin, 0),
        size: Vector2(GameDimensions.headerWidth, GameDimensions.headerHeight),
      );

  @override
  Future<void> onLoad() async {
    final clock = _ClockComponent();
    final headerText = TextComponent(
      text: 'Password Cracker',
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 40, color: ThemeColors.uiHeader),
      ),
    );
    final headerIcons = _HeaderIcons();

    final headerWithSpacer = RowComponent(
      children: [
        PositionComponent(size: Vector2(GameDimensions.headerIconsSpacing, 0)),
        headerText,
      ],
    );

    final row = RowComponent(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      size: size,
      children: [clock, headerWithSpacer, headerIcons],
    );

    add(row);
  }
}

class _ClockComponent extends TextComponent {
  _ClockComponent()
    : super(
        text: '',
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 32, color: ThemeColors.uiHeader),
        ),
        size: Vector2(100, 100),
      );

  @override
  void update(double dt) {
    super.update(dt);
    final now = DateTime.now();
    final timeString =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    text = timeString;
  }
}

class _HeaderIcons extends PositionComponent with HasGameReference<HackGame> {
  _HeaderIcons()
    : super(
        size: Vector2(
          GameDimensions.headerIconsWidth,
          GameDimensions.headerHeight,
        ),
      );

  @override
  Future<void> onLoad() async {
    final battery = SpriteComponent.fromImage(
      game.images.fromCache('battery.png'),
    );
    final connection = SpriteComponent.fromImage(
      game.images.fromCache('connection.png'),
    );
    final wifi = SpriteComponent.fromImage(game.images.fromCache('wifi.png'));

    // Box to fit the sprites
    final boxW = 50.0;
    final boxH = 100.0;

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

    final row = RowComponent(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      size: size,
      children: [connection, wifi, battery],
    );

    add(row);
  }
}

/// Password display - shows character boxes with color feedback
class _PasswordDisplay extends PositionComponent {
  final int charCount;
  final List<_CharacterBox> _boxes = [];

  _PasswordDisplay({required Vector2 position, required this.charCount})
    : super(
        position: position,
        size: Vector2(charCount * 90.0, 100),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    _buildBoxes();
    return super.onLoad();
  }

  void _buildBoxes() {
    // Clear existing boxes
    for (final box in _boxes) {
      box.removeFromParent();
    }
    _boxes.clear();

    // Create character boxes
    for (int i = 0; i < charCount; i++) {
      final box = _CharacterBox(
        position: Vector2(i * 90.0, 0),
        character: '',
        state: _CharacterState.empty,
      );
      _boxes.add(box);
      add(box);
    }
  }

  void updateDisplay(String attempt, List<bool> results) {
    for (int i = 0; i < charCount; i++) {
      final char = i < attempt.length ? attempt[i].toUpperCase() : '';
      final state = results[i] ? _CharacterState.correct : _CharacterState.incorrect;
      _boxes[i].updateCharacter(char, state);
    }
  }
}

enum _CharacterState { empty, correct, incorrect }

/// Individual character box in the password display
class _CharacterBox extends PositionComponent {
  String character;
  _CharacterState state;
  TextComponent? _textComponent;

  _CharacterBox({
    required Vector2 position,
    required this.character,
    required this.state,
  }) : super(position: position, size: Vector2(80, 80));

  @override
  Future<void> onLoad() async {
    _buildContent();
    return super.onLoad();
  }

  void _buildContent() {
    _textComponent?.removeFromParent();

    if (character.isNotEmpty) {
      _textComponent = TextComponent(
        text: character,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
      );
      add(_textComponent!);
    }
  }

  void updateCharacter(String newChar, _CharacterState newState) {
    character = newChar;
    state = newState;
    _buildContent();
  }

  @override
  void render(Canvas canvas) {
    Color fillColor;
    Color borderColor;

    switch (state) {
      case _CharacterState.empty:
        fillColor = const Color(0xFF1A3A4A);
        borderColor = const Color(0xFF1A3A4A);
        break;
      case _CharacterState.correct:
        fillColor = const Color(0xFF1A4A3A);
        borderColor = const Color(0xFF2A8A5A);
        break;
      case _CharacterState.incorrect:
        fillColor = const Color(0xFF4A1A1A);
        borderColor = const Color(0xFF8A2A2A);
        break;
    }

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(8),
    );

    // Fill
    canvas.drawRRect(rrect, Paint()..color = fillColor);

    // Border
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    super.render(canvas);
  }
}

/// Status text showing "Password Incorrect" or "Password Correct"
class _StatusText extends PositionComponent {
  bool _isCorrect = false;
  bool _isVisible = false;
  TextComponent? _textComponent;

  _StatusText({required Vector2 position})
    : super(position: position, size: Vector2(400, 50), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _buildContent();
    return super.onLoad();
  }

  void _buildContent() {
    _textComponent?.removeFromParent();

    if (_isVisible) {
      final text = _isCorrect ? 'Password Correct' : 'Password Incorrect';
      final color = _isCorrect ? const Color(0xFF4ACA7A) : const Color(0xFFCA5A4A);

      _textComponent = TextComponent(
        text: text,
        textRenderer: TextPaint(
          style: TextStyle(
            color: color,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
      );
      add(_textComponent!);
    }
  }

  void updateStatus(bool isCorrect) {
    _isCorrect = isCorrect;
    _isVisible = true;
    _buildContent();
  }
}

/// Password input field with text input support
class _PasswordInput extends PositionComponent
    with TapCallbacks, HasGameReference<HackGame> {
  final void Function(String) onTextChanged;
  String _text = '';
  TextComponent? _textComponent;
  TextComponent? _placeholderComponent;
  bool _hasFocus = false;

  _PasswordInput({required Vector2 position, required this.onTextChanged})
    : super(position: position, size: Vector2(450, 60));

  String get text => _text;

  @override
  Future<void> onLoad() async {
    _buildContent();
    return super.onLoad();
  }

  void _buildContent() {
    _textComponent?.removeFromParent();
    _placeholderComponent?.removeFromParent();

    // Don't show text if overlay is active (to prevent doubling)
    if (game.overlays.isActive('passwordInput')) {
      return;
    }

    if (_text.isEmpty) {
      _placeholderComponent = TextComponent(
        text: 'Enter password attempt...',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6A8A9A),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(20, size.y / 2),
        anchor: Anchor.centerLeft,
      );
      add(_placeholderComponent!);
    } else {
      _textComponent = TextComponent(
        text: _text,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(20, size.y / 2),
        anchor: Anchor.centerLeft,
      );
      add(_textComponent!);
    }
  }

  void addCharacter(String char) {
    if (_text.length < 20) {
      _text += char;
      onTextChanged(_text);
      _buildContent();
    }
  }

  void removeLastCharacter() {
    if (_text.isNotEmpty) {
      _text = _text.substring(0, _text.length - 1);
      onTextChanged(_text);
      _buildContent();
    }
  }

  void clearInput() {
    _text = '';
    onTextChanged(_text);
    _buildContent();
  }

  void setText(String text) {
    _text = text;
    onTextChanged(_text);
    _buildContent();
  }

  @override
  void render(Canvas canvas) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(8),
    );

    // Fill
    canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1A2A3A));

    // Border - brighter when focused
    final borderColor = _hasFocus ? const Color(0xFF6DC5D9) : const Color(0xFF3A5A7A);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    super.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _hasFocus = true;
    _showTextInputOverlay();
  }

  void _showTextInputOverlay() {
    final overlay = game.overlays;
    if (!overlay.isActive('passwordInput')) {
      // Clear text components before showing overlay to prevent doubling
      _textComponent?.removeFromParent();
      _textComponent = null;
      _placeholderComponent?.removeFromParent();
      _placeholderComponent = null;
      overlay.add('passwordInput');
    }
  }
}

/// Action button - "Verify Login" or "Continue"
class _ActionButton extends PositionComponent with TapCallbacks {
  final VoidCallback onTap;
  bool _isCorrect = false;
  TextComponent? _textComponent;

  _ActionButton({required Vector2 position, required this.onTap})
    : super(position: position, size: Vector2(300, 60));

  @override
  Future<void> onLoad() async {
    _buildContent();
    return super.onLoad();
  }

  void _buildContent() {
    _textComponent?.removeFromParent();

    final text = _isCorrect ? 'Continue' : 'Verify Login';

    _textComponent = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFF6DC5D9),
          fontSize: 28,
          fontFamily: 'Consolas',
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );
    add(_textComponent!);
  }

  void updateButtonState(bool isCorrect) {
    _isCorrect = isCorrect;
    _buildContent();
  }

  @override
  void render(Canvas canvas) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(8),
    );

    // Fill
    canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1A2A3A));

    // Border
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = const Color(0xFF6DC5D9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    super.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}

/// Bordered box component
class _BorderedBox extends PositionComponent {
  final Color fillColor;
  final Color borderColor;

  _BorderedBox({
    required Vector2 size,
    required Vector2 position,
    required this.fillColor,
    required this.borderColor,
  }) : super(size: size, position: position);

  @override
  void render(Canvas canvas) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(8),
    );
    // Fill
    canvas.drawRRect(rrect, Paint()..color = fillColor);
    // Border
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    super.render(canvas);
  }
}

/// Explanation overlay shown when entering the password cracker screen
class _ExplanationOverlay extends PositionComponent with TapCallbacks {
  final VoidCallback onDismiss;
  final double _boxWidth = 750.0;
  final double _boxHeight = 420.0;

  _ExplanationOverlay({required this.onDismiss})
    : super(
        size: Vector2(GameDimensions.gameWidth, GameDimensions.gameHeight),
        position: Vector2.zero(),
        priority: 100,
      );

  double get _boxX => (size.x - _boxWidth) / 2;
  double get _boxY => (size.y - _boxHeight) / 2;

  @override
  Future<void> onLoad() async {
    // Title
    add(
      TextComponent(
        text: 'Account Access - Security Puzzle',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(_boxX + 30, _boxY + 25),
      ),
    );

    // Explanation text
    final explanationLines = [
      'The employee uses a weak password based on personal',
      'information.',
      '',
      'Use the clues you collected to guess the correct password.',
      '',
      'After each attempt:',
      '  Green characters are correct and in the right position',
      '  Red characters are incorrect',
      '',
      'When all characters are correct, you will gain access',
      'to the email account.',
    ];

    double lineY = _boxY + 75;
    for (final line in explanationLines) {
      add(
        TextComponent(
          text: line,
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Color(0xFFCCCCCC),
              fontSize: 22,
              fontFamily: 'Consolas',
            ),
          ),
          position: Vector2(_boxX + 30, lineY),
        ),
      );
      lineY += 28;
    }

    // Tap to continue hint
    add(
      TextComponent(
        text: 'Tap anywhere to continue',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 20,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(_boxX + _boxWidth / 2, _boxY + _boxHeight - 25),
        anchor: Anchor.center,
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // Semi-transparent dark background
    canvas.drawRect(
      Offset.zero & size.toSize(),
      Paint()..color = const Color(0xCC000000),
    );

    // Box with border
    final boxRect = Rect.fromLTWH(_boxX, _boxY, _boxWidth, _boxHeight);
    final rrect = RRect.fromRectAndRadius(boxRect, const Radius.circular(12));

    // Fill
    canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1A2A3A));
    // Border
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = const Color(0xFF3A5A7A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    super.render(canvas);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapDown(TapDownEvent event) {
    onDismiss();
  }
}

