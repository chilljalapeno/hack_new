import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flutter/material.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/components/utils.dart';
import 'package:hack_improved/constants.dart';
import 'package:hack_improved/hack_game.dart';

/// LinkedIn-style profile screen for Level 5
/// Shows Harper Collins' profile with posts that contain password clues
class LinkedInProfileScreen extends World with HasGameReference<HackGame> {
  bool _showOverlay = true;
  final Set<String> _cluesFound = {};
  _ProfileContainer? _profileContainer;
  _NotAllCluesModal? _notAllCluesModal;

  // Total number of clues that can be found
  static const int totalClues = 6;

  LinkedInProfileScreen();

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

    // Header with "LinkedIn Network" title
    add(_LinkedInHeader());

    // Main profile container
    _profileContainer = _ProfileContainer(
      onClueFound: _onClueFound,
      cluesFound: _cluesFound,
      onCrackPassword: _onCrackPassword,
    );
    add(_profileContainer!);

    // Show investigation overlay on first load
    if (_showOverlay) {
      add(_InvestigationOverlay(onDismiss: _dismissOverlay));
    }

    return super.onLoad();
  }

  void _dismissOverlay() {
    _showOverlay = false;
    // Remove the overlay component
    final overlay = children.whereType<_InvestigationOverlay>().firstOrNull;
    overlay?.removeFromParent();
  }

  void _onClueFound(String clue) {
    if (!_cluesFound.contains(clue)) {
      _cluesFound.add(clue);
      _profileContainer?.updateClues(_cluesFound);
    }
  }

  void _onCrackPassword() {
    // Check if all clues are found
    if (_cluesFound.length < totalClues) {
      _showNotAllCluesModal();
    } else {
      // Navigate to password cracking screen
      game.navigateToPasswordCracker(_cluesFound);
    }
  }

  void _showNotAllCluesModal() {
    if (_notAllCluesModal != null) return;

    _notAllCluesModal = _NotAllCluesModal(
      onDismiss: () {
        _notAllCluesModal?.removeFromParent();
        _notAllCluesModal = null;
      },
    );
    add(_notAllCluesModal!);
  }
}

/// LinkedIn-style header
class _LinkedInHeader extends PositionComponent {
  _LinkedInHeader()
    : super(
        position: Vector2(GameDimensions.headerHorizontalMargin, 0),
        size: Vector2(GameDimensions.headerWidth, GameDimensions.headerHeight),
      );

  @override
  Future<void> onLoad() async {
    final clock = _LinkedInClock();
    final headerText = TextComponent(
      text: 'LinkedIn Network',
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 40, color: ThemeColors.uiHeader),
      ),
    );
    final headerIcons = _LinkedInHeaderIcons();

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

class _LinkedInClock extends TextComponent {
  _LinkedInClock()
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

class _LinkedInHeaderIcons extends PositionComponent
    with HasGameReference<HackGame> {
  _LinkedInHeaderIcons()
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

/// Main profile container with scrollable content
class _ProfileContainer extends PositionComponent
    with HasGameReference<HackGame> {
  final void Function(String) onClueFound;
  final Set<String> cluesFound;
  final VoidCallback onCrackPassword;
  late _CluesFoundBox _cluesBox;

  _ProfileContainer({
    required this.onClueFound,
    required this.cluesFound,
    required this.onCrackPassword,
  }) : super(
         size: Vector2(
           GameDimensions.gameWidth - 120,
           GameDimensions.gameHeight - 120,
         ),
         position: Vector2(60, 80),
       );

  @override
  Future<void> onLoad() async {
    // Main container background
    add(
      RoundedRectangle(
        size: size,
        position: Vector2.zero(),
        color: ThemeColors.mainContainerBg,
        radius: GameDimensions.borderRadius,
      ),
    );

    // Profile header section
    await _addProfileHeader();

    // Activity section with posts
    await _addActivitySection();

    // Bottom bar with clues and crack password button
    await _addBottomBar();

    return super.onLoad();
  }

  Future<void> _addProfileHeader() async {
    // Profile header container with border
    add(
      _BorderedBox(
        size: Vector2(size.x - 40, 160),
        position: Vector2(20, 15),
        fillColor: const Color(0xFF1A2A3A),
        borderColor: const Color(0xFF3A5A7A),
      ),
    );

    // Profile picture placeholder
    final profilePic = RectangleComponent(
      size: Vector2(110, 110),
      position: Vector2(40, 35),
      paint: Paint()..color = const Color(0xFF3A4A5A),
    );
    add(profilePic);

    // Profile picture - use employee1.png
    try {
      final profileImage = SpriteComponent(
        sprite: Sprite(game.images.fromCache('employee1.png')),
        size: Vector2(110, 110),
        position: Vector2(40, 35),
      );
      add(profileImage);
    } catch (e) {
      // Fallback if image not found
    }

    // Name (tappable clue with border highlight)
    final nameClue = _HighlightableClue(
      text: 'Harper Collins',
      clueId: 'name',
      clueLabel: 'Harper Collins',
      onTap: onClueFound,
      position: Vector2(170, 22),
      fontSize: 32,
      isBold: true,
      textColor: const Color(0xFF6DC5D9),
    );
    add(nameClue);

    // Job title (static) - positioned below the name box
    add(
      TextComponent(
        text: 'Professor at St. Aegis Hospital',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(170, 72),
      ),
    );

    // Location (static text)
    add(
      TextComponent(
        text: 'Rotterdam',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(170, 100),
      ),
    );

    // Date of birth label + tappable value on same line
    add(
      TextComponent(
        text: 'Date of Birth:',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(170, 128),
      ),
    );

    final dobClue = _HighlightableClue(
      text: '26-11-1972',
      clueId: 'dob',
      clueLabel: '1972',
      onTap: onClueFound,
      position: Vector2(330, 122),
      fontSize: 22,
      textColor: const Color(0xFF6DC5D9),
    );
    add(dobClue);

    // Connect button
    final connectButton = _ConnectButton(position: Vector2(size.x - 200, 55));
    add(connectButton);
  }

  Future<void> _addActivitySection() async {
    // Activity header - positioned closer to the box
    add(
      TextComponent(
        text: 'Activity & Posts',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(30, 195),
      ),
    );

    // Activity container with border (scrollable area)
    add(
      _BorderedBox(
        size: Vector2(size.x - 40, 410),
        position: Vector2(20, 235),
        fillColor: const Color(0xFF1A2A3A),
        borderColor: const Color(0xFF3A5A7A),
      ),
    );

    // Post 1: Sailing
    await _addPost(
      imageAsset: 'phase0_icons/sailing.png',
      textBefore: 'Had a fantastic weekend ',
      highlightText: 'sailing',
      textAfter:
          ' off the coast of Rotterdam!\nThe wind was perfect for some competitive racing. #sailinglife',
      clueId: 'sailing',
      clueLabel: 'Sailing',
      yOffset: 250,
    );

    // Post 2: Dog (Cooper - key clue)
    await _addPost(
      imageAsset: 'phase0_icons/dog.png',
      textBefore: 'My ',
      highlightText: 'golden retriever Cooper',
      textAfter:
          ' loves the new park! Hard to believe\nI\'ve had him since he was a pup. #doglover #bestfriend',
      clueId: 'cooper',
      clueLabel: 'Golden Retriever - Cooper',
      yOffset: 345,
    );

    // Post 3: Jazz Music
    await _addPost(
      imageAsset: 'phase0_icons/jazz.png',
      textBefore: 'Relaxing with some live ',
      highlightText: 'Jazz Music',
      textAfter: '. A perfect way to unwind',
      clueId: 'jazz',
      clueLabel: 'Jazz Music',
      yOffset: 440,
    );

    // Post 4: Photography (new)
    await _addPost(
      imageAsset: 'phase0_icons/photography.png',
      textBefore: 'Spent the afternoon experimenting with ',
      highlightText: 'street photography',
      textAfter: '.\nAmazing how much detail you notice when you slow down.',
      clueId: 'photography',
      clueLabel: 'Photography',
      yOffset: 535,
    );
  }

  Future<void> _addPost({
    required String imageAsset,
    required String textBefore,
    required String highlightText,
    required String textAfter,
    required String clueId,
    required String clueLabel,
    required double yOffset,
  }) async {
    // Post image placeholder
    final imageBg = RectangleComponent(
      size: Vector2(100, 80),
      position: Vector2(40, yOffset),
      paint: Paint()..color = const Color(0xFF2A3A4A),
    );
    add(imageBg);

    // Try to load the image
    try {
      final postImage = SpriteComponent(
        sprite: Sprite(game.images.fromCache(imageAsset)),
        size: Vector2(100, 80),
        position: Vector2(40, yOffset),
      );
      add(postImage);
    } catch (e) {
      // Fallback - show placeholder
    }

    // Post text with highlightable clue
    final postClue = _PostWithHighlight(
      textBefore: textBefore,
      highlightText: highlightText,
      textAfter: textAfter,
      clueId: clueId,
      clueLabel: clueLabel,
      onTap: onClueFound,
      position: Vector2(160, yOffset + 5),
    );
    add(postClue);
  }

  Future<void> _addBottomBar() async {
    // Bottom bar container with border
    add(
      _BorderedBox(
        size: Vector2(size.x - 40, 130),
        position: Vector2(20, size.y - 150),
        fillColor: const Color(0xFF1A2A3A),
        borderColor: const Color(0xFF3A5A7A),
      ),
    );

    // Clues found label
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
        position: Vector2(40, size.y - 135),
      ),
    );

    // Clues found box (dynamic content)
    _cluesBox = _CluesFoundBox(
      position: Vector2(200, size.y - 140),
      clues: cluesFound,
    );
    add(_cluesBox);

    // Crack Password button - centered vertically in the bottom bar
    final crackButton = _CrackPasswordButton(
      position: Vector2(size.x - 250, size.y - 115),
      onTap: onCrackPassword,
    );
    add(crackButton);
  }

  void updateClues(Set<String> clues) {
    _cluesBox.updateClues(clues);
  }
}

/// Box that displays found clues dynamically
class _CluesFoundBox extends PositionComponent {
  Set<String> _clues;

  _CluesFoundBox({required Vector2 position, required Set<String> clues})
    : _clues = clues,
      super(position: position, size: Vector2(600, 120));

  @override
  Future<void> onLoad() async {
    _buildCluesList();
    return super.onLoad();
  }

  void updateClues(Set<String> clues) {
    _clues = clues;
    _buildCluesList();
  }

  void _buildCluesList() {
    // Remove existing text components
    children.whereType<TextComponent>().toList().forEach(
      (c) => c.removeFromParent(),
    );

    // Map clue IDs to display names
    final clueDisplayNames = <String, String>{
      'name': 'Harper Collins',
      'dob': '1972',
      'sailing': 'Sailing',
      'cooper': 'Cooper',
      'jazz': 'Jazz Music',
      'photography': 'Photography',
    };

    // Build display text in rows
    final displayClues = _clues.map((c) => clueDisplayNames[c] ?? c).toList();

    // Row 1: First 2 clues
    if (displayClues.isNotEmpty) {
      final row1 = displayClues.take(2).join('  ');
      add(
        TextComponent(
          text: row1,
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Color(0xFF6DC5D9),
              fontSize: 22,
              fontFamily: 'Consolas',
            ),
          ),
          position: Vector2(0, 5),
        ),
      );
    }

    // Row 2: Next 3 clues
    if (displayClues.length > 2) {
      final row2 = displayClues.skip(2).take(3).join('  ');
      add(
        TextComponent(
          text: row2,
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Color(0xFF6DC5D9),
              fontSize: 22,
              fontFamily: 'Consolas',
            ),
          ),
          position: Vector2(0, 35),
        ),
      );
    }

    // Row 3: Remaining clues
    if (displayClues.length > 5) {
      final row3 = displayClues.skip(5).join('  ');
      add(
        TextComponent(
          text: row3,
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Color(0xFF6DC5D9),
              fontSize: 22,
              fontFamily: 'Consolas',
            ),
          ),
          position: Vector2(0, 65),
        ),
      );
    }
  }
}

/// Highlightable clue text with border when tapped
class _HighlightableClue extends PositionComponent with TapCallbacks {
  final String text;
  final String clueId;
  final String clueLabel;
  final void Function(String) onTap;
  final double fontSize;
  final bool isBold;
  final Color textColor;
  bool _isTapped = false;

  _HighlightableClue({
    required this.text,
    required this.clueId,
    required this.clueLabel,
    required this.onTap,
    required Vector2 position,
    required this.fontSize,
    this.isBold = false,
    this.textColor = const Color(0xFF6DC5D9),
  }) : super(
         position: position,
         size: Vector2(text.length * fontSize * 0.6 + 20, fontSize + 16),
       );

  @override
  Future<void> onLoad() async {
    _buildContent();
    return super.onLoad();
  }

  void _buildContent() {
    // Remove existing children
    children.toList().forEach((c) => c.removeFromParent());

    // Text position depends on whether we're showing the border
    final textPos = _isTapped ? Vector2(8, 6) : Vector2(0, 6);

    add(
      TextComponent(
        text: text,
        textRenderer: TextPaint(
          style: TextStyle(
            color: _isTapped ? const Color(0xFF6DC5D9) : textColor,
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Consolas',
          ),
        ),
        position: textPos,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    // Only draw border box after tapped
    if (_isTapped) {
      final borderColor = const Color(0xFF6DC5D9);
      final rrect = RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        const Radius.circular(4),
      );
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
    super.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isTapped) {
      _isTapped = true;
      onTap(clueId);
      _buildContent();
    }
  }
}

/// Post text with highlightable portion
class _PostWithHighlight extends PositionComponent with TapCallbacks {
  final String textBefore;
  final String highlightText;
  final String textAfter;
  final String clueId;
  final String clueLabel;
  final void Function(String) onTap;
  bool _isTapped = false;

  // Character width for monospace font positioning
  static const double _charWidth = 10.0;

  _PostWithHighlight({
    required this.textBefore,
    required this.highlightText,
    required this.textAfter,
    required this.clueId,
    required this.clueLabel,
    required this.onTap,
    required Vector2 position,
  }) : super(position: position, size: Vector2(700, 80));

  @override
  Future<void> onLoad() async {
    _buildContent();
    return super.onLoad();
  }

  // Get the bounds of the clue text area
  Rect get _clueTextBounds {
    final beforeWidth = textBefore.length * _charWidth;
    final highlightWidth = highlightText.length * _charWidth;
    return Rect.fromLTWH(beforeWidth, 0, highlightWidth, 36);
  }

  void _buildContent() {
    // Remove existing children
    children.toList().forEach((c) => c.removeFromParent());

    final normalColor = const Color(0xFFAAAAAA);

    if (!_isTapped) {
      // When not tapped, render as continuous text (no gaps)
      // Split text into lines
      final fullText = textBefore + highlightText + textAfter;
      final lines = fullText.split('\n');

      for (int i = 0; i < lines.length; i++) {
        add(
          TextComponent(
            text: lines[i],
            textRenderer: TextPaint(
              style: TextStyle(
                color: normalColor,
                fontSize: 20,
                fontFamily: 'Consolas',
              ),
            ),
            position: Vector2(0, 8 + (i * 28)),
          ),
        );
      }
    } else {
      // When tapped, show with highlighted box
      final beforeWidth = textBefore.length * _charWidth;
      final highlightWidth =
          highlightText.length * _charWidth + 16; // +16 for padding

      // Text before highlight
      add(
        TextComponent(
          text: textBefore,
          textRenderer: TextPaint(
            style: TextStyle(
              color: normalColor,
              fontSize: 20,
              fontFamily: 'Consolas',
            ),
          ),
          position: Vector2(0, 8),
        ),
      );

      // Highlighted text with border box
      add(
        _HighlightBox(text: highlightText, position: Vector2(beforeWidth, 0)),
      );

      // Text after highlight (may wrap to next line)
      final afterParts = textAfter.split('\n');
      if (afterParts.isNotEmpty) {
        // First part continues on same line
        add(
          TextComponent(
            text: afterParts[0],
            textRenderer: TextPaint(
              style: TextStyle(
                color: normalColor,
                fontSize: 20,
                fontFamily: 'Consolas',
              ),
            ),
            position: Vector2(beforeWidth + highlightWidth, 8),
          ),
        );

        // Remaining parts on new lines
        for (int i = 1; i < afterParts.length; i++) {
          add(
            TextComponent(
              text: afterParts[i],
              textRenderer: TextPaint(
                style: TextStyle(
                  color: normalColor,
                  fontSize: 20,
                  fontFamily: 'Consolas',
                ),
              ),
              position: Vector2(0, 8 + (i * 28)),
            ),
          );
        }
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (_isTapped) return;

    // Only trigger if tap is within the clue text bounds
    final localPoint = event.localPosition;
    if (_clueTextBounds.contains(localPoint.toOffset())) {
      _isTapped = true;
      onTap(clueId);
      _buildContent();
    }
  }
}

/// Highlight box around clue text - always shows border (only used when tapped)
class _HighlightBox extends PositionComponent {
  final String text;

  _HighlightBox({required this.text, required Vector2 position})
    : super(position: position, size: Vector2(text.length * 10.0 + 16, 32));

  @override
  Future<void> onLoad() async {
    add(
      TextComponent(
        text: text,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 20,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(8, 6),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = const Color(0xFF6DC5D9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    super.render(canvas);
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

/// Connect button (decorative)
class _ConnectButton extends PositionComponent {
  _ConnectButton({required Vector2 position})
    : super(position: position, size: Vector2(150, 50));

  @override
  Future<void> onLoad() async {
    // Button text
    add(
      TextComponent(
        text: 'Connect',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
      ),
    );

    return super.onLoad();
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
}

/// Crack Password button
class _CrackPasswordButton extends PositionComponent with TapCallbacks {
  final VoidCallback onTap;

  _CrackPasswordButton({required Vector2 position, required this.onTap})
    : super(position: position, size: Vector2(210, 70));

  @override
  Future<void> onLoad() async {
    // Button text
    add(
      TextComponent(
        text: 'Crack Password',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
      ),
    );

    return super.onLoad();
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

/// Investigation overlay that appears on first visit
class _InvestigationOverlay extends PositionComponent with TapCallbacks {
  final VoidCallback onDismiss;
  final double _boxWidth = 700.0;
  final double _boxHeight = 380.0;

  _InvestigationOverlay({required this.onDismiss})
    : super(
        size: Vector2(GameDimensions.gameWidth, GameDimensions.gameHeight),
        position: Vector2.zero(),
        priority: 100, // Render on top
      );

  double get _boxX => (size.x - _boxWidth) / 2;
  double get _boxY => (size.y - _boxHeight) / 2;

  @override
  Future<void> onLoad() async {
    // Title
    add(
      TextComponent(
        text: 'Investigation Required',
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
      'We suspect that public information shared by this em-',
      'ployee may have been used to gain access to her ac-',
      'count.',
      'Your task is to review her public profile and recent',
      'posts to identify personal details that could be used',
      'to guess her password.',
      'Scroll through the profile and tap on potential clues.',
      'Once you have collected enough information, you can',
      'attempt to access her email.',
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

    // Tap to continue hint (at bottom of box)
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

/// Modal shown when not all clues are found
class _NotAllCluesModal extends PositionComponent with TapCallbacks {
  final VoidCallback onDismiss;
  final double _boxWidth = 550.0;
  final double _boxHeight = 180.0;

  _NotAllCluesModal({required this.onDismiss})
    : super(
        size: Vector2(GameDimensions.gameWidth, GameDimensions.gameHeight),
        position: Vector2.zero(),
        priority: 100, // Render on top
      );

  double get _boxX => (size.x - _boxWidth) / 2;
  double get _boxY => (size.y - _boxHeight) / 2;

  @override
  Future<void> onLoad() async {
    // Title
    add(
      TextComponent(
        text: 'Not all clues',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFE57A3A),
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(_boxX + _boxWidth / 2, _boxY + 35),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'identified',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFE57A3A),
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(_boxX + _boxWidth / 2, _boxY + 80),
        anchor: Anchor.center,
      ),
    );

    // Message
    add(
      TextComponent(
        text: 'Keep exploring the profile to uncover more useful information.',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 20,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(_boxX + _boxWidth / 2, _boxY + 130),
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
      Paint()..color = const Color(0x99000000),
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
