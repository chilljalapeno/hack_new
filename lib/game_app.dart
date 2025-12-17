import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/constants.dart';
import 'package:hack_improved/hack_game.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final HackGame _game;

  @override
  void initState() {
    super.initState();
    _game = HackGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate the aspect ratio and scale accordingly
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final gameAspectRatio = GameDimensions.gameAspectRatio;
              final screenAspectRatio = screenWidth / screenHeight;

              double gameWidth, gameHeight;
              if (screenAspectRatio > gameAspectRatio) {
                // Screen is wider than game - fit to height
                gameHeight = screenHeight;
                gameWidth = screenHeight * gameAspectRatio;
              } else {
                // Screen is taller than game - fit to width
                gameWidth = screenWidth;
                gameHeight = screenWidth / gameAspectRatio;
              }

              return Center(
                child: SizedBox(
                  width: gameWidth,
                  height: gameHeight,
                  child: Stack(
                    children: [
                      GameWidget(
                        game: _game,
                        overlayBuilderMap: {
                          'textInput': (context, game) =>
                              _TextInputOverlay(game: _game),
                          'passwordInput': (context, game) =>
                              _PasswordInputOverlay(game: _game),
                          'cheatMenu': (context, game) =>
                              _CheatMenuOverlay(game: _game),
                        },
                      ),
                      // Floating cheat button
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            _game.overlays.add('cheatMenu');
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0x990F1F30),
                              border: Border.all(
                                color: Color(0xFF6DC5D9),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'CHEAT',
                                style: TextStyle(
                                  color: Color(0xFF6DC5D9),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Consolas',
                                  fontFamilyFallback: ['Courier New', 'monospace'],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TextInputOverlay extends StatefulWidget {
  final HackGame game;

  const _TextInputOverlay({required this.game});

  @override
  State<_TextInputOverlay> createState() => _TextInputOverlayState();
}

class _TextInputOverlayState extends State<_TextInputOverlay> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Set the initial text from the current input box value
    _controller.text = widget.game.loadingScreen.inputBox.text;
    // Auto-focus the text field when overlay appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close overlay when tapping outside
        final inputText = _controller.text.trim();
        if (inputText.isNotEmpty) {
          widget.game.loadingScreen.updateInputText(inputText);
        }
        widget.game.loadingScreen.unfocusInput();
        widget.game.overlays.remove('textInput');
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final gameAspectRatio = GameDimensions.gameAspectRatio;
              final screenAspectRatio = screenWidth / screenHeight;

              double gameWidth, gameHeight;
              if (screenAspectRatio > gameAspectRatio) {
                gameHeight = screenHeight;
                gameWidth = screenHeight * gameAspectRatio;
              } else {
                gameWidth = screenWidth;
                gameHeight = screenWidth / gameAspectRatio;
              }

              // Get the actual input box position and size from the loading screen
              final inputBoxPos = widget.game.loadingScreen.inputBoxPosition;
              final inputBoxSize = widget.game.loadingScreen.inputBoxSize;

              // Scale from game world coordinates to actual widget size
              final scaleX = gameWidth / GameDimensions.gameWidth;
              final scaleY = gameHeight / GameDimensions.gameHeight;

              return SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: Stack(
                  children: [
                    Positioned(
                      left: inputBoxPos.x * scaleX,
                      top: inputBoxPos.y * scaleY,
                      width: inputBoxSize.x * scaleX,
                      height: inputBoxSize.y * scaleY,
                      child: GestureDetector(
                        onTap: () {}, // Prevent closing when clicking on input
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          style: TextStyle(
                            color: Color(0xFF6DC5D9),
                            fontSize: 28 * scaleY,
                            fontFamily: 'Consolas',
                            fontFamilyFallback: ['Courier New', 'monospace'],
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter company code...',
                            hintStyle: TextStyle(
                              color: Color(0x806DC5D9),
                              fontSize: 28 * scaleY,
                              fontFamily: 'Consolas',
                              fontFamilyFallback: ['Courier New', 'monospace'],
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.only(
                              left: 20 * scaleX,
                              top: 20 * scaleY,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            widget.game.loadingScreen.updateInputText(value);
                          },
                          onSubmitted: (value) {
                            final inputText = _controller.text.trim();
                            if (inputText.isNotEmpty) {
                              widget.game.loadingScreen.updateInputText(
                                inputText,
                              );
                            }
                            widget.game.loadingScreen.unfocusInput();
                            widget.game.overlays.remove('textInput');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PasswordInputOverlay extends StatefulWidget {
  final HackGame game;

  const _PasswordInputOverlay({required this.game});

  @override
  State<_PasswordInputOverlay> createState() => _PasswordInputOverlayState();
}

class _PasswordInputOverlayState extends State<_PasswordInputOverlay> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Set the initial text from the current input
    final passwordScreen = widget.game.passwordCrackerScreen;
    if (passwordScreen != null) {
      _controller.text = passwordScreen.currentInputText;
    }
    // Auto-focus the text field when overlay appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close overlay when tapping outside
        final inputText = _controller.text;
        final passwordScreen = widget.game.passwordCrackerScreen;
        if (passwordScreen != null && inputText.isNotEmpty) {
          passwordScreen.updateInputText(inputText);
        }
        // Remove overlay first, then unfocus so text rebuilds correctly
        widget.game.overlays.remove('passwordInput');
        passwordScreen?.unfocusInput();
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final gameAspectRatio = GameDimensions.gameAspectRatio;
              final screenAspectRatio = screenWidth / screenHeight;

              double gameWidth, gameHeight;
              if (screenAspectRatio > gameAspectRatio) {
                gameHeight = screenHeight;
                gameWidth = screenHeight * gameAspectRatio;
              } else {
                gameWidth = screenWidth;
                gameHeight = screenWidth / gameAspectRatio;
              }

              final passwordScreen = widget.game.passwordCrackerScreen;
              if (passwordScreen == null) {
                return SizedBox.shrink();
              }

              // Get the actual input box position and size
              final inputBoxPos = passwordScreen.inputBoxPosition;
              final inputBoxSize = passwordScreen.inputBoxSize;

              // Scale from game world coordinates to actual widget size
              final scaleX = gameWidth / GameDimensions.gameWidth;
              final scaleY = gameHeight / GameDimensions.gameHeight;

              return SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: Stack(
                  children: [
                    Positioned(
                      left: inputBoxPos.x * scaleX,
                      top: inputBoxPos.y * scaleY,
                      width: inputBoxSize.x * scaleX,
                      height: inputBoxSize.y * scaleY,
                      child: GestureDetector(
                        onTap: () {}, // Prevent closing when clicking on input
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          style: TextStyle(
                            color: Color(0xFF6DC5D9),
                            fontSize: 22 * scaleY,
                            fontFamily: 'Consolas',
                            fontFamilyFallback: ['Courier New', 'monospace'],
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter password attempt...',
                            hintStyle: TextStyle(
                              color: Color(0xFF6A8A9A),
                              fontSize: 22 * scaleY,
                              fontFamily: 'Consolas',
                              fontFamilyFallback: ['Courier New', 'monospace'],
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.only(
                              left: 20 * scaleX,
                              top: 18 * scaleY,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            passwordScreen.updateInputText(value);
                          },
                          onSubmitted: (value) {
                            final inputText = _controller.text;
                            if (inputText.isNotEmpty) {
                              passwordScreen.updateInputText(inputText);
                            }
                            // Remove overlay first, then unfocus so text rebuilds correctly
                            widget.game.overlays.remove('passwordInput');
                            passwordScreen.unfocusInput();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CheatMenuOverlay extends StatefulWidget {
  final HackGame game;

  const _CheatMenuOverlay({required this.game});

  @override
  State<_CheatMenuOverlay> createState() => _CheatMenuOverlayState();
}

class _CheatMenuOverlayState extends State<_CheatMenuOverlay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close overlay when tapping outside
        widget.game.overlays.remove('cheatMenu');
      },
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final gameAspectRatio = GameDimensions.gameAspectRatio;
              final screenAspectRatio = screenWidth / screenHeight;

              double gameWidth, gameHeight;
              if (screenAspectRatio > gameAspectRatio) {
                gameHeight = screenHeight;
                gameWidth = screenHeight * gameAspectRatio;
              } else {
                gameWidth = screenWidth;
                gameHeight = screenWidth / gameAspectRatio;
              }

              return SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: GestureDetector(
                  onTap: () {}, // Prevent closing when clicking inside
                  child: Container(
                    margin: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      border: Border.all(
                        color: Color(0xFF6DC5D9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFF0F1F30),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cheat Menu',
                                style: TextStyle(
                                  color: Color(0xFF6DC5D9),
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Consolas',
                                  fontFamilyFallback: ['Courier New', 'monospace'],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.game.overlays.remove('cheatMenu');
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'X',
                                    style: TextStyle(
                                      color: Color(0xFF6DC5D9),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Consolas',
                                      fontFamilyFallback: ['Courier New', 'monospace'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Level buttons - scrollable
                        Flexible(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                              _buildLevelButton(
                                'Splash Screen',
                                () {
                                  widget.game.navigateToSplash();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Loading Screen',
                                () {
                                  widget.game.navigateToLoading();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Phase Zero',
                                () {
                                  widget.game.navigateToPhaseZero();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Phase One',
                                () {
                                  widget.game.navigateToPhaseOne();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Power Dashboard',
                                () {
                                  widget.game.navigateToPowerDashboard();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Level Two',
                                () {
                                  widget.game.navigateToLevelTwo();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Level Four',
                                () {
                                  widget.game.navigateToSocialMediaLevel();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Level Five',
                                () {
                                  widget.game.navigateToLevelFive();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'LinkedIn Profile',
                                () {
                                  widget.game.navigateToLinkedInProfile();
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                              SizedBox(height: 12),
                              _buildLevelButton(
                                'Password Cracker',
                                () {
                                  // Create with all clues for testing
                                  final allClues = {'name', 'dob', 'sailing', 'cooper', 'jazz', 'photography'};
                                  widget.game.navigateToPasswordCracker(allClues);
                                  widget.game.overlays.remove('cheatMenu');
                                },
                              ),
                            ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Color(0x990F1F30),
          border: Border.all(
            color: Color(0xFF6DC5D9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6DC5D9),
            fontSize: 24,
            fontFamily: 'Consolas',
            fontFamilyFallback: ['Courier New', 'monospace'],
          ),
        ),
      ),
    );
  }
}
