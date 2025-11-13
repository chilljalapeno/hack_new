import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/components/ui_header.dart';
import 'package:hack_improved/hack_game.dart';
import 'package:hack_improved/components/warning_banner.dart';
import 'package:hack_improved/components/ios_notification.dart';
import 'package:hack_improved/constants.dart';

class PhaseOne extends World with HasGameReference<HackGame>, TapCallbacks {
  late SpriteComponent _background;
  late List<_HackedAppIcon> _appIcons;
  bool isTransitioning = false;
  bool hasStarted = false;

  PhaseOne();

  @override
  Future<void> onLoad() async {
    final screenWidth = GameDimensions.gameWidth;
    final screenHeight = GameDimensions.gameHeight;

    // Hacker background with binary code pattern
    _background = SpriteComponent(
      sprite: Sprite(
        game.images.fromCache('phase0_icons/hacker_background.png'),
      ),
      size: Vector2(screenWidth, screenHeight),
      position: Vector2(0, 0),
    );
    add(_background);

    // Status bar at top with cyan color scheme (fixed time to match image)
    add(UiHeader());

    // Add flashing warning banner
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

    // Add hacked app grid on the right in a similar layout to Phase Zero
    await _addHackedAppGrid(screenWidth, screenHeight);
  }

  void startSequence() {
    if (hasStarted) return;
    hasStarted = true;

    // Start the hack transition sequence after a short delay
    add(
      TimerComponent(
        period: 2.0,
        repeat: false,
        onTick: () {
          _startHackSequence();
        },
      ),
    );
  }

  // Legacy placeholder removed; StatusBar is added directly in onLoad

  // Legacy placeholder removed; WarningBanner is added directly in onLoad

  Future<void> _addHackedAppGrid(
    double screenWidth,
    double screenHeight,
  ) async {
    // App configuration matching the image layout (4x2 grid)
    final apps = [
      // Row 1
      {
        'name': 'Mail',
        'icon': 'phase0_icons/mail_blackout.png',
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
        'active': false,
      },
      {
        'name': 'Chat',
        'icon': 'phase0_icons/chat_blackout.png',
        'active': false,
      },
      {
        'name': 'Pager',
        'icon': 'phase0_icons/pager_blackout.png',
        'active': false,
      },
      {
        'name': 'Emergency Power',
        'icon': 'phase0_icons/power_blackout.png',
        'active': true,
      }, // Only this one is active
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
      final icon = _HackedAppIcon(
        position: Vector2(x, y),
        size: iconSize,
        appName: app['name'] as String,
        iconAsset: app['icon'] as String,
        isActive: app['active'] as bool,
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

  Future<void> _startHackSequence() async {
    if (isTransitioning) return;
    isTransitioning = true;

    // Step 1: Flicker effect (rapid color changes)
    await _flickerEffect();

    // Step 2: Glitch the hospital logo
    _glitchLogo();

    // Step 3: Show hacker silhouette with message
    await _showHackerIntro();

    // Step 4: Transform icons to glitched versions (already loaded)
    // Step 5: Make Power App pulse
    _activatePowerApp();
  }

  Future<void> _flickerEffect() async {
    // Create rapid flicker by changing background opacity
    for (int i = 0; i < 8; i++) {
      _background.paint.color = ThemeColors.brandTeal; // Cyan flash
      await Future.delayed(Duration(milliseconds: 50));
      _background.paint.color = Color(0xFF0A0A0A); // Back to dark
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  void _glitchLogo() {
    // Logo removed - no longer needed for the new design
    // Keeping function for compatibility with hack sequence
  }

  Future<void> _showHackerIntro() async {
    final screenWidth = GameDimensions.gameWidth;
    final screenHeight = GameDimensions.gameHeight;

    // Semi-transparent dark overlay with cyan tint
    final overlay = RectangleComponent(
      size: Vector2(screenWidth, screenHeight),
      position: Vector2(0, 0),
      paint: Paint()..color = Color(0xEE0A0A0A),
    );
    add(overlay);

    // Hacker silhouette with cyan tint
    final hackerImage = SpriteComponent(
      sprite: Sprite(game.images.fromCache('escape_the hack_logo.png')),
      size: Vector2(700, 700),
      position: Vector2(screenWidth / 2, screenHeight / 2),
      anchor: Anchor.center,
      paint: Paint()
        ..colorFilter = ColorFilter.mode(
          ThemeColors.brandTeal,
          BlendMode.modulate,
        ),
    );
    add(hackerImage);

    // Wait for dramatic effect (show for 3 seconds)
    await Future.delayed(Duration(milliseconds: 3000));

    // Remove all intro elements with a fade-out effect using opacity on paint
    _fadeOutAndRemove(overlay, 0.8);
    _fadeOutAndRemove(hackerImage, 0.8);

    // Wait for fade out to complete before continuing
    await Future.delayed(Duration(milliseconds: 800));
  }

  void _fadeOutAndRemove(PositionComponent component, double duration) {
    final steps = 20;
    final stepDuration = duration / steps;
    int currentStep = 0;

    add(
      TimerComponent(
        period: stepDuration,
        repeat: true,
        onTick: () {
          currentStep++;
          final opacity = (1.0 - (currentStep / steps)).clamp(0.0, 1.0);

          if (component is SpriteComponent) {
            component.paint.color = ThemeColors.brandTeal.withValues(
              alpha: opacity.clamp(0.0, 1.0),
            );
          } else if (component is RectangleComponent) {
            final currentColor = component.paint.color;
            component.paint.color = currentColor.withValues(alpha: opacity);
          } else if (component is TextComponent) {
            final textPaint = component.textRenderer as TextPaint;
            final style = textPaint.style;
            component.textRenderer = TextPaint(
              style: style.copyWith(
                color: (style.color ?? ThemeColors.brandTeal).withValues(
                  alpha: opacity,
                ),
              ),
            );
          }

          if (currentStep >= steps) {
            component.removeFromParent();
          }
        },
      ),
    );
  }

  void _activatePowerApp() {
    // Show iOS notification instead of pulsing
    _showIOSNotification();
  }

  void _showIOSNotification() {
    final screenWidth = GameDimensions.gameWidth;
    final notificationWidth = GameDimensions.phaseOneNotificationWidth;
    final notificationHeight = GameDimensions.phaseOneNotificationHeight;

    // Create notification container
    final notification = IOSNotification(
      position: Vector2(
        (screenWidth - notificationWidth) / 2,
        -notificationHeight,
      ),
      size: Vector2(notificationWidth, notificationHeight),
    );
    add(notification);

    // Animate notification sliding down
    notification.add(
      MoveEffect.to(
        Vector2(
          (screenWidth - notificationWidth) / 2,
          GameDimensions.phaseOneNotificationY,
        ),
        EffectController(duration: 0.5, curve: Curves.easeOut),
      ),
    );

    // Auto-dismiss after 8 seconds with slide up animation
    add(
      TimerComponent(
        period: 8.0,
        repeat: false,
        onTick: () {
          notification.add(
            MoveEffect.to(
              Vector2(
                (screenWidth - notificationWidth) / 2,
                -notificationHeight,
              ),
              EffectController(duration: 0.4, curve: Curves.easeIn),
              onComplete: () => notification.removeFromParent(),
            ),
          );
        },
      ),
    );
  }
}

// Legacy embedded component removed; using reusable IOSNotification component

// Custom component for hacked app icons
class _HackedAppIcon extends PositionComponent
    with TapCallbacks, HasGameReference<HackGame> {
  final String appName;
  final String iconAsset;
  final bool isActive;
  late final double iconSize;

  _HackedAppIcon({
    required Vector2 position,
    required double size,
    required this.appName,
    required this.iconAsset,
    required this.isActive,
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
          color: isActive ? ThemeColors.brandTeal : Color(0xFF666666),
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

  void startPulsing() {
    // Add pulsing glow effect
    final container = children.whereType<_DarkRoundedIconContainer>().first;
    container.add(
      ScaleEffect.by(
        Vector2.all(1.15),
        EffectController(duration: 0.8, reverseDuration: 0.8, infinite: true),
      ),
    );

    // Add pulsing to icon glow
    container.startGlowPulse();
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return size.toRect().contains(point.toOffset());
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isActive) {
      // Power App tapped - transition to Power Dashboard
      // Use Future to ensure the transition happens
      Future.microtask(() {
        game.cam.world = game.powerDashboard;
      });
    }
  }
}

// Dark rounded icon container for hacked state
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

  void startGlowPulse() {
    // Pulse the glow intensity
    add(
      TimerComponent(
        period: 0.05,
        repeat: true,
        onTick: () {
          glowIntensity =
              0.5 +
              (0.5 * ((DateTime.now().millisecondsSinceEpoch % 1600) / 1600));
        },
      ),
    );
  }
}
