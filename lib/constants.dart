import "dart:ui";

// Game Dimensions - Single source of truth for all dimensional values
class GameDimensions {
  GameDimensions._();

  // Base game resolution (16:9 aspect ratio)
  static const double gameWidth = 1920.0;
  static const double gameHeight = 1080.0;
  static const double gameAspectRatio = gameWidth / gameHeight;

  // UI Header dimensions
  static const double headerHeight = 100.0;
  static const double headerHorizontalMargin = 96.0;
  static const double headerWidth = gameWidth - (headerHorizontalMargin * 2);
  static const double headerIconsWidth = 300.0;
  static const double headerIconsSpacing = 109.0;
  static const double statusBarY = 45.0;

  // Main Container (Level Two screen)
  static const double mainContainerMarginHorizontal = 210.0;
  static const double mainContainerMarginTop = 148.0;
  static const double mainContainerWidth =
      gameWidth - (mainContainerMarginHorizontal * 2);
  static const double mainContainerHeight =
      gameHeight - mainContainerMarginTop - 82.0;

  // Splash & Loading Screen
  static const double logoSize = 500.0;
  static const double logoBoxPadding = 50.0;
  static const double logoBoxSize = logoSize + (logoBoxPadding * 2);
  static const double loadingLogoSize = 400.0;
  static const double loadingLogoBoxPadding = 40.0;
  static const double loadingLogoBoxSize =
      loadingLogoSize + (loadingLogoBoxPadding * 2);
  static const double loadingInputWidth = 600.0;
  static const double loadingInputHeight = 80.0;
  static const double loadingButtonWidth = 300.0;
  static const double loadingButtonHeight = 60.0;
  static const double loadingSpacingLogoToText = 80.0;
  static const double loadingSpacingTextToInput = 70.0;
  static const double loadingSpacingInputToButton = 40.0;
  static const double loadingTextHeight = 36.0;

  // Phase Zero (Calm screen) dimensions
  static const double phaseZeroLeftPadding = 120.0;
  static const double phaseZeroTopStart = 200.0;
  static const double phaseZeroWeatherWidth = 560.0;
  static const double phaseZeroWeatherHeight = 390.0;
  static const double phaseZeroCalendarHeight = 220.0;
  static const double phaseZeroVerticalGap = 28.0;
  static const double phaseZeroRightPadding = 140.0;
  static const double phaseZeroGapRightOfPanels = 100.0;
  static const double phaseZeroIconSpacing = 76.0;
  static const double phaseZeroMinIconSize = 150.0;
  static const double phaseZeroMaxIconSize = 210.0;
  static const double phaseZeroIconLabelSpacing = 20.0;
  static const double phaseZeroIconLabelHeight = 120.0;
  static const double phaseZeroNotificationWidth = 900.0;
  static const double phaseZeroNotificationHeight = 140.0;
  static const double phaseZeroNotificationStartY = 100.0;
  static const double phaseZeroNotificationSpacing = 20.0;

  // Phase One (Hacked screen) dimensions
  static const double phaseOneLeftPadding = 120.0;
  static const double phaseOneTopStart = 180.0;
  static const double phaseOneWeatherWidth = 620.0;
  static const double phaseOneWeatherHeight = 430.0;
  static const double phaseOneCalendarHeight = 260.0;
  static const double phaseOneVerticalGap = 36.0;
  static const double phaseOneRightPadding = 140.0;
  static const double phaseOneIconSize = 160.0;
  static const double phaseOneIconSpacing = 80.0;
  static const double phaseOneIconLabelSpacing = 20.0;
  static const double phaseOneIconLabelHeight = 60.0;
  static const double phaseOneBannerY = 90.0;
  static const double phaseOneBannerWidth = 900.0;
  static const double phaseOneBannerHeight = 60.0;
  static const double phaseOneNotificationWidth = 800.0;
  static const double phaseOneNotificationHeight = 180.0;
  static const double phaseOneNotificationY = 160.0;

  // Power Dashboard dimensions
  static const double powerDashboardTitleY = 70.0;
  static const double powerDashboardTimerY = 120.0;
  static const double powerDashboardTimerRightMargin = 60.0;
  static const double powerDashboardBannerY = 140.0;
  static const double powerDashboardBannerMargin = 100.0;
  static const double powerDashboardBannerHeight = 90.0;
  static const double powerDashboardPanelStartY = 270.0;
  static const double powerDashboardPanelWidth = 750.0;
  static const double powerDashboardPanelHeight = 300.0;
  static const double powerDashboardPanelGapHorizontal = 80.0;
  static const double powerDashboardPanelGapVertical = 80.0;
  static const double powerDashboardButtonWidth = 400.0;
  static const double powerDashboardButtonHeight = 75.0;
  static const double powerDashboardButtonBottomMargin = 50.0;

  // Power Circuit Minigame dimensions
  static const double circuitContainerMarginHorizontal = 60.0;
  static const double circuitContainerMarginTop = 110.0;
  static const double circuitContainerMarginBottom = 70.0;
  static const double circuitContainerBorderWidth = 3.0;
  static const double circuitContainerWidth =
      gameWidth - (circuitContainerMarginHorizontal * 2);
  static const double circuitContainerHeight =
      gameHeight - circuitContainerMarginTop - circuitContainerMarginBottom;
  static const double circuitTitleY = 80.0;
  static const double circuitAlertY = 140.0;
  static const double circuitAlertMargin = 100.0;
  static const double circuitAlertHeight = 70.0;
  static const double circuitNodeStartY = 300.0;
  static const double circuitNodeDiameter = 120.0;
  static const double circuitNodeSpacing = 180.0;
  static const double circuitNodeLeftX = 240.0;
  static const double circuitManualWidth = 380.0;
  static const double circuitManualHeight = 500.0;
  static const double circuitManualRightMargin = 40.0;
  static const double circuitButtonWidth = 400.0;
  static const double circuitButtonHeight = 80.0;
  static const double circuitButtonBottomMargin = 40.0;

  // Common dimensions
  static const double borderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
  static const double outlineWidth = 3.0;
}

// Fonts
class Font {
  Font._();
}

// Colors
class ThemeColors {
  ThemeColors._();
  // Ui header
  static Color uiHeader = Color(0xFF6DC5D9);
  // Main container
  static Color mainContainerBg = Color(0xFF111D2F);
  static Color mainContainerOutline = Color(0xFF0D4761);
  // Main container header
  static Color mainContainerHeaderBg = Color(0xFF671412);
  static Color mainContainerHeaderOutline = Color(0xFFCA431A);
  // Check server button
  static Color checkServerStatusText = Color(0xFF6DC5D9);
  static Color checkServerStatusBg = Color(0xFF0D4761);

  // Zoomed in
  // Header bars
  // Unknown
  static Color headerBarStatusUnknownText = Color(0xFF817B91);
  static Color headerBarStatusUnknownBg = Color(0xFF212D37);
  static Color headerBarStatusUnknownOutline = Color(0xFF817B91);
  // Safe
  static Color headerBarStatusSafeText = Color(0xFF8EC4BB);
  static Color headerBarStatusSafeBg = Color(0xFF123831);
  static Color headerBarStatusSafeOutline = Color(0xFF287D5F);
  // Infected
  static Color headerBarStatusInfectedText = Color(0xFFE2A69D);
  static Color headerBarStatusInfectedBg = Color(0xFF671412);
  static Color headerBarStatusInfectedOutline = Color(0xFFCA431A);

  // Log
  static Color logText = Color(0xFF6DC5D9);

  // Buttons
  // Safe
  static Color safeButtonBg = Color(0xFF123831);
  static Color safeButtonOutline = Color(0xFF287D5F);
  static Color safeButtonText = Color(0xFF8EC4BB);
  // Infected
  static Color infectedButtonBg = Color(0xFF671412);
  static Color infectedButtonOutline = Color(0xFFCA431A);
  static Color infectedButtonText = Color(0xFFE2A69D);

  static const Color brandTeal = Color(0xFF6DC5D9);
  static const Color bgDark = Color(0xFF0A0A0A);
  static const Color bgLight = Color(0xFFF5F5F5);
  static const Color warnRed = Color(0xFFFF0000);
  static const Color warnOrange = Color(0xFFFF8C42);
}

class UiFonts {
  // Prefer system mono with reasonable fallbacks unless bundled fonts are added
  static const String? monoPrimary = null; // use default
  static const List<String> monoFallback = [
    'Consolas',
    'Courier New',
    'monospace',
  ];
}

class OverlayKeys {
  static const String textInput = 'textInput';
}

// Legacy UiDims kept for backwards compatibility
class UiDims {
  static const double statusBarY = GameDimensions.statusBarY;
  static const double bannerHeight = 60.0;
}
