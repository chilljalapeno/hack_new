import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart' hide RoundedRectangle;
import 'package:flame/text.dart' as flame;
import 'package:flutter/material.dart';
import 'package:hack_improved/components/rounded_rectangle.dart';
import 'package:hack_improved/components/utils.dart';
import 'package:hack_improved/constants.dart';
import 'package:hack_improved/hack_game.dart';

class SocialMediaLevel extends World with HasGameReference<HackGame> {
  SocialMediaLevel();

  @override
  Future<void> onLoad() async {
    final screenWidth = GameDimensions.gameWidth;
    final screenHeight = GameDimensions.gameHeight;

    // Background with binary code pattern (similar to other levels)
    add(
      SpriteComponent(
        sprite: Sprite(
          game.images.fromCache('phase0_icons/hacker_background.png'),
        ),
        size: Vector2(screenWidth, screenHeight),
        position: Vector2(0, 0),
      ),
    );

    // Status bar at top with "Social Media" title
    add(_SocialMediaHeader());

    // Main content container
    final container = SocialMediaContainer();
    add(container);

    return super.onLoad();
  }
}

class SocialMediaContainer extends PositionComponent
    with HasGameReference<HackGame> {
  int currentPage = 0;
  final int totalPages = 3;
  final List<List<SocialMediaPost>> posts = [];
  final List<bool?> answers = List.filled(9, null);
  int currentPostIndex = 0;

  SocialMediaContainer()
    : super(
        size: Vector2(
          GameDimensions.mainContainerWidth,
          GameDimensions.mainContainerHeight,
        ),
        position: Vector2(
          GameDimensions.mainContainerMarginHorizontal,
          GameDimensions.mainContainerMarginTop,
        ),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add background to container so it's visible
    final background = RoundedRectangle(
      size: size,
      position: Vector2.zero(),
      color: ThemeColors.mainContainerBg,
      radius: GameDimensions.borderRadius,
    );
    add(background);

    // Initialize posts (3 messages repeated across 3 pages)
    final message1 = SocialMediaPost(
      name: 'Maya Patel',
      content: "The servers won't be back up until next week.. 😔",
      isCorrect: false,
      imagePath: 'employee1.png',
    );
    final message2 = SocialMediaPost(
      name: 'David Turner',
      content: 'Proud of my colleagues today, working hard for our patients!',
      isCorrect: true, // This is acceptable
      imagePath: 'employee2.png',
    );
    final message3 = SocialMediaPost(
      name: 'Maya Patel',
      content:
          'Because of this cyberattack, we are working until 2 AM this week..',
      isCorrect: false, // This gives away too much info
      imagePath: 'employee3.png',
    );

    // Repeat the 3 messages across 3 pages
    posts.addAll([
      [message1, message2, message3],
      [message1, message2, message3],
      [message1, message2, message3],
    ]);

    _buildPage();
  }

  void _buildPage() {
    // Keep the background, remove only content children
    final background = children.whereType<RoundedRectangle>().firstOrNull;
    final childrenToRemove = children.where((c) => c != background).toList();
    for (final child in childrenToRemove) {
      remove(child);
    }

    currentPostIndex = currentPage * 3;

    // Title
    final title = _buildTitle();
    add(title);

    // Calculate available space for posts column
    final postsStartY = 150.0;
    final navButtonsY = size.y - 80;
    final minGap = 30.0; // Minimum gap between posts column and nav buttons
    final availableHeight = navButtonsY - postsStartY - minGap;

    // Posts column with proper spacing
    final postsColumn = ColumnComponent(
      size: Vector2(size.x - 100, availableHeight),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: posts[currentPage]
          .asMap()
          .entries
          .map(
            (entry) =>
                _buildPostCard(entry.value, currentPostIndex + entry.key),
          )
          .toList(),
    );
    postsColumn.position = Vector2(50, postsStartY);
    add(postsColumn);

    // Navigation buttons - positioned below posts column with proper spacing
    final navButtons = _buildNavigationButtons();
    navButtons.position = Vector2(50, navButtonsY);
    add(navButtons);
  }

  PositionComponent _buildTitle() {
    // Dark muted blue-gray background
    final bgColor = Color(0xFF2D5A6F);
    // Light muted blue/teal text color
    final textColor = Color(0xFF7BC4D3);
    // Subtle darker blue-gray outline
    final outlineColor = Color(0xFF1A3F4F);

    final titleText = TextComponent(
      text: 'EVALUATE THE SOCIAL MEDIA USAGE',
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 36,
          color: textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Calibri',
        ),
      ),
    );

    final containerWidth = size.x - 100;
    final containerHeight = 80.0;

    final inner = RoundedRectangle(
      size: Vector2(containerWidth - 4, containerHeight - 4),
      position: Vector2(2, 2),
      color: bgColor,
      radius: 8,
      children: [
        RowComponent(
          size: Vector2(containerWidth - 4, containerHeight - 4),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [titleText],
        ),
      ],
    );

    final titleContainer = RoundedRectangle(
      size: Vector2(containerWidth, containerHeight),
      position: Vector2(50, 50),
      color: outlineColor,
      radius: 8,
      children: [inner],
    );

    return titleContainer;
  }

  PositionComponent _buildPostCard(SocialMediaPost post, int index) {
    final cardWidth = size.x - 200;
    final cardHeight = 180.0;

    // Spacing constants
    const horizontalPadding = 20.0;
    const verticalPadding = 15.0;
    const profilePicSize = 60.0;
    const profilePicToTextSpacing = 15.0;
    const nameToContentSpacing = 5.0;
    const leftToRightSpacing = 30.0; // Space between content and buttons
    const buttonSpacing = 10.0;
    const buttonWidth = 200.0;

    // Profile picture
    final profilePic = _ProfilePicture(
      imagePath: post.imagePath,
      size: profilePicSize,
    );

    // Name text
    final nameText = TextComponent(
      text: post.name,
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 28,
          color: Color(0xFF105385),
          fontWeight: FontWeight.bold,
          fontFamily: 'Calibri',
        ),
      ),
    );

    // Content text - will be sized by the layout
    final contentText = TextComponent(
      text: post.content,
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 24,
          color: Colors.black87,
          fontFamily: 'Calibri',
        ),
      ),
    );

    // Calculate available width for left content column
    // Card width - padding - gap - button width
    final leftContentWidth =
        cardWidth - (horizontalPadding * 2) - leftToRightSpacing - buttonWidth;

    // Calculate available width for content text (within left content column)
    final contentAvailableWidth =
        leftContentWidth - profilePicSize - profilePicToTextSpacing;

    // Set content text size to allow wrapping
    contentText.size = Vector2(contentAvailableWidth, 80);

    // Left content column: profile pic + name + content
    final leftContentColumn = ColumnComponent(
      size: Vector2(leftContentWidth, cardHeight - (verticalPadding * 2)),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      gap: nameToContentSpacing,
      children: [
        // Row with profile pic and name side by side
        RowComponent(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          gap: profilePicToTextSpacing,
          children: [profilePic, nameText],
        ),
        // Content below name
        contentText,
      ],
    );

    // Right buttons column
    final correctButton = _buildButton(
      'Correct',
      true,
      answers[index] == true,
      () => _onAnswerSelected(index, true),
    );

    final tooMuchButton = _buildButton(
      'Too much',
      false,
      answers[index] == false,
      () => _onAnswerSelected(index, false),
    );

    final buttonsColumn = ColumnComponent(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: buttonSpacing,
      children: [correctButton, tooMuchButton],
    );

    // Main row: left content + spacing + right buttons with padding
    final mainRow = RowComponent(
      size: Vector2(
        cardWidth - (horizontalPadding * 2),
        cardHeight - (verticalPadding * 2),
      ),
      position: Vector2(horizontalPadding, verticalPadding),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: leftToRightSpacing,
      children: [leftContentColumn, buttonsColumn],
    );

    // Post card background
    final postCard = RoundedRectangle(
      size: Vector2(cardWidth, cardHeight),
      color: Color(0xFFD1DFE0),
      radius: 12,
      children: [mainRow],
    );

    return postCard;
  }

  PositionComponent _buildButton(
    String text,
    bool isCorrect,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final bgColor = isCorrect
        ? (isSelected ? Color(0xFF55B579) : Color(0xFF123831))
        : (isSelected ? Color(0xFFCA431A) : Color(0xFF671412));
    final outlineColor = isCorrect ? Color(0xFF287D5F) : Color(0xFFCA431A);
    final textColor = isCorrect ? Color(0xFF8EC4BB) : Color(0xFFE2A69D);
    final iconPath = isCorrect ? 'check.png' : 'alert_icon.png';

    final button = _SocialMediaButton(
      size: Vector2(200, 60),
      bgColor: bgColor,
      outlineColor: outlineColor,
      text: text,
      textColor: textColor,
      iconPath: iconPath,
      onTap: onTap,
    );

    return button;
  }

  void _onAnswerSelected(int index, bool isCorrect) {
    answers[index] = isCorrect;
    _buildPage(); // Rebuild to show selection
  }

  PositionComponent _buildNavigationButtons() {
    final prevButton = _buildNavButton('Previous Posts', currentPage > 0, () {
      if (currentPage > 0) {
        currentPage--;
        _buildPage();
      }
    });

    final isLastPage = currentPage == totalPages - 1;
    final nextButton = _buildNavButton(
      isLastPage ? 'View Results' : 'Next Posts',
      true,
      () {
        if (currentPage < totalPages - 1) {
          currentPage++;
          _buildPage();
        } else {
          // All pages completed, show results
          _showResults();
        }
      },
    );

    final buttonsRow = RowComponent(
      size: Vector2(size.x - 100, 60),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [prevButton, nextButton],
    );

    return buttonsRow;
  }

  PositionComponent _buildNavButton(
    String text,
    bool enabled,
    VoidCallback onTap,
  ) {
    final button = _NavigationButton(
      size: Vector2(300, 60),
      text: text,
      enabled: enabled,
      onTap: onTap,
    );
    return button;
  }

  void _showResults() {
    // Keep the background, remove only content children
    final background = children.whereType<RoundedRectangle>().firstOrNull;
    final childrenToRemove = children.where((c) => c != background).toList();
    for (final child in childrenToRemove) {
      remove(child);
    }

    // Calculate correct answers
    int correctCount = 0;
    for (int i = 0; i < 9; i++) {
      final pageIndex = i ~/ 3;
      final postIndex = i % 3;
      final post = posts[pageIndex][postIndex];
      if (answers[i] == post.isCorrect) {
        correctCount++;
      }
    }

    final resultsScreen = SocialMediaResultsScreen(
      correctCount: correctCount,
      totalCount: 9,
      onContinue: () {
        // Navigate to Level 5 (Social Engineering Investigation)
        game.navigateToLevelFive();
      },
    );
    resultsScreen.size = size;
    add(resultsScreen);
  }
}

class _SocialMediaHeader extends PositionComponent {
  _SocialMediaHeader()
    : super(
        position: Vector2(GameDimensions.headerHorizontalMargin, 0),
        size: Vector2(GameDimensions.headerWidth, GameDimensions.headerHeight),
      );

  @override
  Future<void> onLoad() async {
    final clock = _SocialMediaClock();
    final headerText = TextComponent(
      text: 'Social Media',
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 40, color: ThemeColors.uiHeader),
      ),
    );
    final headerIcons = _SocialMediaHeaderIcons();

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

class _SocialMediaClock extends TextComponent {
  _SocialMediaClock()
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

class _SocialMediaHeaderIcons extends PositionComponent
    with HasGameReference<HackGame> {
  _SocialMediaHeaderIcons()
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

    battery.size *= Utils.scaleImages(
      boxSize: Vector2(boxW, boxH),
      imageSize: batteryImageSize,
    );
    connection.size *= Utils.scaleImages(
      boxSize: Vector2(boxW, boxH),
      imageSize: connectionImageSize,
    );
    wifi.size *= Utils.scaleImages(
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

class SocialMediaPost {
  final String name;
  final String content;
  final bool isCorrect; // true if "Correct" is the right answer
  final String imagePath;

  SocialMediaPost({
    required this.name,
    required this.content,
    required this.isCorrect,
    required this.imagePath,
  });
}

class _ProfilePicture extends PositionComponent
    with HasGameReference<HackGame> {
  final String imagePath;
  final double pictureSize;

  _ProfilePicture({required this.imagePath, required double size})
    : pictureSize = size,
      super(size: Vector2.all(size));

  @override
  Future<void> onLoad() async {
    // Load the employee image
    final sprite = SpriteComponent.fromImage(game.images.fromCache(imagePath));

    // Scale image to fit within the circular area (cover the circle)
    final imageSize = sprite.size;
    final scale = pictureSize / imageSize.x;
    sprite.size = imageSize * scale;

    // Center the sprite
    sprite.position = Vector2.zero();
    sprite.anchor = Anchor.topLeft;

    // Add the sprite
    add(sprite);

    return super.onLoad();
  }
}

class _SocialMediaButton extends PositionComponent
    with TapCallbacks, HasGameReference<HackGame> {
  final Color bgColor;
  final Color outlineColor;
  final String text;
  final Color textColor;
  final String iconPath;
  final VoidCallback onTap;

  _SocialMediaButton({
    required super.size,
    required this.bgColor,
    required this.outlineColor,
    required this.text,
    required this.textColor,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Future<void> onLoad() async {
    // Icon
    final iconSize = Vector2(32, 32);
    final icon = SpriteComponent.fromImage(game.images.fromCache(iconPath));
    icon.size *= Utils.scaleImages(boxSize: iconSize, imageSize: icon.size);

    // Text
    final buttonText = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 20, color: textColor),
      ),
    );

    // Row with icon and text
    final row = RowComponent(
      size: size - Vector2(6, 6),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: 12,
      children: [icon, buttonText],
    );

    final inner = RoundedRectangle(
      size: size - Vector2(6, 6),
      position: Vector2(3, 3),
      color: bgColor,
      radius: 8,
      children: [row],
    );

    final outer = RoundedRectangle(
      size: size,
      color: outlineColor,
      radius: 8,
      children: [inner],
    );

    add(outer);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}

class _NavigationButton extends PositionComponent with TapCallbacks {
  final String text;
  final bool enabled;
  final VoidCallback onTap;

  _NavigationButton({
    required super.size,
    required this.text,
    required this.enabled,
    required this.onTap,
  });

  @override
  Future<void> onLoad() async {
    // Dark teal/blue-gray background color
    final bgColor = Color(0xFF2D5A6F);
    // Lighter muted blue/teal text color
    final textColor = enabled ? Color(0xFF7BC4D3) : Color(0xFF5A7A8A);
    // Subtle darker outline
    final outlineColor = Color(0xFF1A3F4F);

    final buttonText = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 28,
          color: textColor,
          fontFamily: 'Calibri',
        ),
      ),
    );

    final inner = RoundedRectangle(
      size: size - Vector2(4, 4),
      position: Vector2(2, 2),
      color: bgColor,
      radius: 8,
      children: [
        RowComponent(
          size: size - Vector2(4, 4),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [buttonText],
        ),
      ],
    );

    final outer = RoundedRectangle(
      size: size,
      color: outlineColor,
      radius: 8,
      children: [inner],
    );

    add(outer);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (enabled) {
      onTap();
    }
  }
}

class SocialMediaResultsScreen extends PositionComponent {
  final int correctCount;
  final int totalCount;
  final VoidCallback onContinue;

  SocialMediaResultsScreen({
    required this.correctCount,
    required this.totalCount,
    required this.onContinue,
  }) : super();

  @override
  Future<void> onLoad() async {
    // Title - dark blue-gray with subtle border, white text
    final bgColor = Color(0xFF2D5A6F);
    final outlineColor = Color(0xFF1A3F4F);
    final containerWidth = size.x - 100;
    final containerHeight = 80.0;

    final title = TextComponent(
      text: 'REVIEW COMPLETED',
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Calibri',
        ),
      ),
    );

    final titleInner = RoundedRectangle(
      size: Vector2(containerWidth - 4, containerHeight - 4),
      position: Vector2(2, 2),
      color: bgColor,
      radius: 8,
      children: [
        RowComponent(
          size: Vector2(containerWidth - 4, containerHeight - 4),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [title],
        ),
      ],
    );

    final titleContainer = RoundedRectangle(
      size: Vector2(containerWidth, containerHeight),
      position: Vector2(50, 50),
      color: outlineColor,
      radius: 8,
      children: [titleInner],
    );
    add(titleContainer);

    // Results text - light blue-green color
    final textColor = Color(0xFF7BC4D3);
    final titleBottom = 50 + containerHeight;
    final resultsStartY = titleBottom + 50;

    final resultText1 = TextComponent(
      text: 'You correctly assessed $correctCount of $totalCount posts.',
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 32,
          color: textColor,
          fontFamily: 'Calibri',
        ),
      ),
    );
    resultText1.position = Vector2(50, resultsStartY);

    final resultText2 = TextComponent(
      text:
          'Resulting in the leakage of information about the hack to external sources.',
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 32,
          color: textColor,
          fontFamily: 'Calibri',
        ),
      ),
    );
    resultText2.position = Vector2(50, resultsStartY + 50);
    resultText2.size = Vector2(size.x - 100, 100);

    add(resultText1);
    add(resultText2);

    // Progress bar - positioned below result text
    final progressBar = _buildProgressBar();
    progressBar.position = Vector2(50, resultsStartY + 150);
    add(progressBar);

    // Buttons - centered horizontally
    final continueButton = _buildResultButton('Continue', onContinue);

    final buttonsRow = RowComponent(
      size: Vector2(size.x - 100, 80),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [continueButton],
    );
    buttonsRow.position = Vector2(50, size.y - 100);
    add(buttonsRow);

    return super.onLoad();
  }

  PositionComponent _buildProgressBar() {
    // Available width accounting for padding (50px on each side)
    final availableWidth = size.x - 100;
    final barHeight = 40.0;
    const textSpacing = 20.0;
    final progress = correctCount / totalCount;

    // Calculate text width (approximate based on character count and font size)
    // Font size 28, approximate width per character is ~16-18px
    final textString = '$correctCount / $totalCount Correct';
    final estimatedTextWidth = (textString.length * 18.0).clamp(150.0, 250.0);

    // Calculate bar width to fit within available space
    // Reserve space for text and spacing, use remaining for bar
    final calculatedBarWidth =
        availableWidth - textSpacing - estimatedTextWidth;
    final barWidth = calculatedBarWidth.clamp(300.0, calculatedBarWidth);

    // Ensure total width doesn't exceed available space
    final totalWidth = barWidth + textSpacing + estimatedTextWidth;
    final constrainedWidth = totalWidth.clamp(0.0, availableWidth);

    // Adjust bar width if container was constrained
    final finalBarWidth = constrainedWidth < totalWidth
        ? constrainedWidth - textSpacing - estimatedTextWidth
        : barWidth;

    // Progress text
    final progressText = TextComponent(
      text: textString,
      textRenderer: TextPaint(
        style: flame.TextStyle(fontSize: 28, color: Colors.white),
      ),
    );
    progressText.size = Vector2(estimatedTextWidth, barHeight);

    // Background bar - dark blue-gray to match title
    final bgBar = RoundedRectangle(
      size: Vector2(finalBarWidth, barHeight),
      color: Color(0xFF2D5A6F),
      radius: 8,
    );

    // Progress fill
    final fillBar = RoundedRectangle(
      size: Vector2(finalBarWidth * progress, barHeight),
      color: Color(0xFF55B579),
      radius: 8,
    );

    // Use RowComponent for proper layout
    final progressRow = RowComponent(
      size: Vector2(constrainedWidth, barHeight),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      gap: textSpacing,
      children: [
        // Container for the progress bar
        PositionComponent(
          size: Vector2(finalBarWidth, barHeight),
          children: [bgBar, fillBar],
        ),
        // Text component with proper size
        PositionComponent(
          size: Vector2(estimatedTextWidth, barHeight),
          children: [progressText],
        ),
      ],
    );

    final container = PositionComponent(
      size: Vector2(constrainedWidth, barHeight),
      children: [progressRow],
    );

    return container;
  }

  PositionComponent _buildResultButton(String text, VoidCallback onTap) {
    return _ResultButton(size: Vector2(300, 80), text: text, onTap: onTap);
  }
}

class _ResultButton extends PositionComponent with TapCallbacks {
  final String text;
  final VoidCallback onTap;

  _ResultButton({required super.size, required this.text, required this.onTap});

  @override
  Future<void> onLoad() async {
    // Results buttons use white text, dark blue-gray background
    final bgColor = Color(0xFF2D5A6F);
    final outlineColor = Color(0xFF1A3F4F);

    final buttonText = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: flame.TextStyle(
          fontSize: 28,
          color: Colors.white,
          fontFamily: 'Calibri',
        ),
      ),
    );

    final inner = RoundedRectangle(
      size: size - Vector2(4, 4),
      position: Vector2(2, 2),
      color: bgColor,
      radius: 8,
      children: [
        RowComponent(
          size: size - Vector2(4, 4),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [buttonText],
        ),
      ],
    );

    final outer = RoundedRectangle(
      size: size,
      color: outlineColor,
      radius: 8,
      children: [inner],
    );

    add(outer);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}
