import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/components/ui_header.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/components/warning_banner.dart';
import 'package:hack_improved/constants.dart';

/// Level 5: Social Engineering Investigation
/// 
/// This level shows how easily public information can be abused to gain access
/// to internal systems. Players learn that even harmless-looking social media
/// activity can provide enough clues to guess a weak password.
class LevelFive extends World with HasGameReference<HackGame>, TapCallbacks {
  late SpriteComponent _background;
  late List<_LevelFiveAppIcon> _appIcons;
  bool isTransitioning = false;
  bool hasStarted = false;
  _LevelFiveNotification? _notification;

  LevelFive();

  @override
  Future<void> onLoad() async {
    final screenWidth = GameDimensions.gameWidth;
    final screenHeight = GameDimensions.gameHeight;

    // Hacker background with binary code pattern (same as Phase One)
    _background = SpriteComponent(
      sprite: Sprite(
        game.images.fromCache('phase0_icons/hacker_background.png'),
      ),
      size: Vector2(screenWidth, screenHeight),
      position: Vector2(0, 0),
    );
    add(_background);

    // Status bar at top with cyan color scheme
    add(UiHeader());

    // Add flashing warning banner (same as Phase One)
    add(
      WarningBanner(
        position: Vector2(
          (screenWidth - GameDimensions.phaseOneBannerWidth) / 2,
          GameDimensions.phaseOneBannerY,
        ),
        size: Vector2(
          GameDimensions.phaseOneBannerWidth,
          GameDimensions.phaseOneBannerHeight,
        ),
        message: 'SYSTEM BREACH - Unauthorized Access Detected',
        color: ThemeColors.warnRed,
        flash: true,
      ),
    );

    // Left-side error panels (weather + calendar in error state)
    _addLeftErrorPanels(screenWidth, screenHeight);

    // Add hacked app grid on the right
    await _addHackedAppGrid(screenWidth, screenHeight);
  }

  void startSequence() {
    if (hasStarted) return;
    hasStarted = true;

    // Show the notification after a short delay
    add(
      TimerComponent(
        period: 0.5,
        repeat: false,
        onTick: () {
          _showSecurityAlertNotification();
        },
      ),
    );
  }

  Future<void> _addHackedAppGrid(
    double screenWidth,
    double screenHeight,
  ) async {
    // App configuration matching the hacked tablet layout (4x2 grid)
    // Only Contacts app is active for Level 5
    final apps = [
      // Row 1
      {
        'name': 'Pager',
        'icon': 'phase0_icons/pager_blackout.png',
        'active': false,
      },
      {
        'name': 'Documents',
        'icon': 'phase0_icons/docs_blackout.png',
        'active': false,
      },
      {'name': 'EPD', 'icon': 'phase0_icons/epd_blackout.png', 'active': false},
      {
        'name': 'Network',
        'icon': 'phase0_icons/network_blackout.png',
        'active': false,
      },
      // Row 2
      {
        'name': 'Contacts',
        'icon': 'phase0_icons/contacts_blackout.png',
        'active': true, // Contacts is active for Level 5
      },
      {
        'name': 'Chat',
        'icon': 'phase0_icons/chat_blackout.png',
        'active': false,
      },
      {
        'name': 'Mail',
        'icon': 'phase0_icons/mail_blackout.png',
        'active': false,
      },
      {
        'name': 'Emergency Power',
        'icon': 'phase0_icons/power_blackout.png',
        'active': false,
      },
    ];

    // Fixed positioning for 4x2 grid layout
    final rightPadding = GameDimensions.phaseOneRightPadding;

    // Fixed icon sizing for consistent 4x2 grid layout
    final iconSize = GameDimensions.phaseOneIconSize;
    final iconSpacing = GameDimensions.phaseOneIconSpacing;

    // Right-aligned grid
    final gridWidth = (iconSize * 4) + (iconSpacing * 3);
    final startX = screenWidth - rightPadding - gridWidth;
    final gridHeight =
        (iconSize * 2) + iconSpacing + GameDimensions.phaseOneIconLabelHeight;
    final startY = ((screenHeight - gridHeight) / 2).clamp(
      140.0,
      double.infinity,
    );

    _appIcons = [];

    for (int i = 0; i < apps.length; i++) {
      final row = i ~/ 4;
      final col = i % 4;

      final x = startX + (col * (iconSize + iconSpacing));
      final y =
          startY +
          (row *
              (iconSize +
                  iconSpacing +
                  GameDimensions.phaseOneIconLabelHeight));

      final app = apps[i];
      final icon = _LevelFiveAppIcon(
        position: Vector2(x, y),
        size: iconSize,
        appName: app['name'] as String,
        iconAsset: app['icon'] as String,
        isActive: app['active'] as bool,
        onTap: app['active'] == true ? _onContactsTapped : null,
      );

      _appIcons.add(icon);
      add(icon);
    }
  }

  void _addLeftErrorPanels(double screenWidth, double screenHeight) {
    // Layout matches the image with afterhack assets
    final leftPadding = GameDimensions.phaseOneLeftPadding;
    final topStart = GameDimensions.phaseOneTopStart;

    final weatherWidth = GameDimensions.phaseOneWeatherWidth;
    final weatherHeight = GameDimensions.phaseOneWeatherHeight;
    final calendarWidth = weatherWidth;
    final calendarHeight = GameDimensions.phaseOneCalendarHeight;
    final verticalGap = GameDimensions.phaseOneVerticalGap;

    // Weather error panel with afterhack asset
    final weatherPanel = SpriteComponent(
      sprite: Sprite(game.images.fromCache('phase0_icons/png_location.png')),
      size: Vector2(weatherWidth, weatherHeight),
      position: Vector2(leftPadding, topStart),
    );
    add(weatherPanel);

    // Calendar error panel with afterhack asset
    final calendarTop = topStart + weatherHeight + verticalGap;
    final calendarPanel = SpriteComponent(
      sprite: Sprite(game.images.fromCache('phase0_icons/png_calendar.png')),
      size: Vector2(calendarWidth, calendarHeight),
      position: Vector2(leftPadding, calendarTop),
    );
    add(calendarPanel);
  }

  void _showSecurityAlertNotification() {
    final screenWidth = GameDimensions.gameWidth;
    final notificationWidth = GameDimensions.levelFiveNotificationWidth;
    final notificationHeight = GameDimensions.levelFiveNotificationHeight;

    // Create the Level 5 specific notification
    _notification = _LevelFiveNotification(
      position: Vector2(
        (screenWidth - notificationWidth) / 2,
        -notificationHeight, // Start off-screen
      ),
      size: Vector2(notificationWidth, notificationHeight),
    );
    add(_notification!);

    // Animate notification sliding down
    _notification!.add(
      MoveEffect.to(
        Vector2(
          (screenWidth - notificationWidth) / 2,
          GameDimensions.levelFiveNotificationY,
        ),
        EffectController(duration: 0.5, curve: Curves.easeOut),
      ),
    );

    // Don't auto-dismiss - let player interact with Contacts app
  }

  void _onContactsTapped() {
    // Dismiss notification with slide up animation if it exists
    if (_notification != null) {
      final screenWidth = GameDimensions.gameWidth;
      final notificationWidth = GameDimensions.levelFiveNotificationWidth;
      final notificationHeight = GameDimensions.levelFiveNotificationHeight;

      _notification!.add(
        MoveEffect.to(
          Vector2(
            (screenWidth - notificationWidth) / 2,
            -notificationHeight,
          ),
          EffectController(duration: 0.4, curve: Curves.easeIn),
          onComplete: () => _notification?.removeFromParent(),
        ),
      );
    }

    // Navigate to LinkedIn profile screen
    game.navigateToLinkedInProfile();
  }
}

/// Custom notification component for Level 5 Security Alert
class _LevelFiveNotification extends PositionComponent {
  _LevelFiveNotification({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    // Mail icon circle (cyan/teal accent)
    final iconCircle = CircleComponent(
      radius: 35,
      position: Vector2(70, size.y / 2),
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0xFF2D5A6F),
    );
    add(iconCircle);

    // Mail icon with X (envelope symbol)
    add(
      TextComponent(
        text: 'X',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(70, size.y / 2),
        anchor: Anchor.center,
      ),
    );

    // Outer border for mail icon
    add(
      CircleComponent(
        radius: 35,
        position: Vector2(70, size.y / 2),
        anchor: Anchor.center,
        paint: Paint()
          ..color = const Color(0xFF6DC5D9)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      ),
    );

    // Title: "Security Alert - Internal Lead Identified"
    add(
      TextComponent(
        text: 'Security Alert - Internal Lead Identified',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(130, 25),
        anchor: Anchor.topLeft,
      ),
    );

    // Message line 1
    add(
      TextComponent(
        text: 'Our monitoring systems detected that one employee may',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(130, 60),
        anchor: Anchor.topLeft,
      ),
    );

    // Message line 2
    add(
      TextComponent(
        text: 'be connected to the cause of the cyber incident.',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(130, 85),
        anchor: Anchor.topLeft,
      ),
    );

    // Message line 3
    add(
      TextComponent(
        text: 'Please investigate their profile.',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 22,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(130, 110),
        anchor: Anchor.topLeft,
      ),
    );

    // Call to action: "Open the Contacts app to begin."
    add(
      TextComponent(
        text: 'Open the Contacts app to begin.',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF7BC4D3),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontFamily: 'Consolas',
          ),
        ),
        position: Vector2(130, 145),
        anchor: Anchor.topLeft,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    // Rounded rectangle background
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(16),
    );

    // Background fill
    final paint = Paint()
      ..color = const Color(0xEE1C2A3A)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);

    // Border
    final borderPaint = Paint()
      ..color = const Color(0xFF3A5A7A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, borderPaint);

    super.render(canvas);
  }
}

/// Custom component for hacked app icons in Level 5
class _LevelFiveAppIcon extends PositionComponent
    with TapCallbacks, HasGameReference<HackGame> {
  final String appName;
  final String iconAsset;
  final bool isActive;
  final VoidCallback? onTap;
  late final double iconSize;

  _LevelFiveAppIcon({
    required Vector2 position,
    required double size,
    required this.appName,
    required this.iconAsset,
    required this.isActive,
    this.onTap,
  }) : iconSize = size,
       super(
         position: position,
         size: Vector2(size, size + GameDimensions.phaseOneIconLabelHeight),
       );

  @override
  Future<void> onLoad() async {
    // Dark icon container
    add(
      _DarkRoundedIconContainer(
        position: Vector2(iconSize / 2, iconSize / 2),
        size: Vector2(iconSize, iconSize),
        borderRadius: 24,
        isActive: isActive,
      ),
    );

    // Icon sprite
    try {
      final iconSprite = SpriteComponent(
        sprite: Sprite(game.images.fromCache(iconAsset)),
        size: Vector2(iconSize * 0.6, iconSize * 0.6),
        position: Vector2(iconSize * 0.2, iconSize * 0.2),
      );
      add(iconSprite);
    } catch (e) {
      // Fallback - icon loading failed
    }

    // App name label
    final label = TextComponent(
      text: appName,
      textRenderer: TextPaint(
        style: TextStyle(
          color: isActive ? ThemeColors.brandTeal : const Color(0xFF666666),
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      ),
      position: Vector2(
        iconSize / 2,
        iconSize + GameDimensions.phaseOneIconLabelSpacing,
      ),
      anchor: Anchor.topCenter,
    );
    add(label);

    // Add transparent tap area to ensure taps are captured
    final tapArea = RectangleComponent(
      size: size,
      position: Vector2.zero(),
      paint: Paint()..color = Colors.transparent,
    );
    add(tapArea);

    // Store label reference if active for pulsing
    if (isActive) {
      bool labelVisible = true;
      add(
        TimerComponent(
          period: 0.8,
          repeat: true,
          onTick: () {
            labelVisible = !labelVisible;
            final newOpacity = labelVisible ? 1.0 : 0.4;
            final textPaint = label.textRenderer;
            label.textRenderer = TextPaint(
              style: textPaint.style.copyWith(
                color: ThemeColors.brandTeal.withValues(alpha: newOpacity),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return size.toRect().contains(point.toOffset());
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isActive && onTap != null) {
      onTap!();
    }
  }
}

/// Dark rounded icon container for hacked state
class _DarkRoundedIconContainer extends PositionComponent {
  final double borderRadius;
  final bool isActive;
  double glowIntensity = 1.0;

  _DarkRoundedIconContainer({
    required Vector2 size,
    required Vector2 position,
    required this.borderRadius,
    required this.isActive,
  }) : super(size: size, position: position, anchor: Anchor.center);
}

