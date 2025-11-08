import "dart:ui";

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

class UiDims {
  static const double statusBarY = 45.0;
  static const double bannerHeight = 60.0;
}
