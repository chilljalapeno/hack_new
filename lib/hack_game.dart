import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'package:flutter/material.dart';
import 'package:hack_improved/blocs/level_two_bloc.dart';
import 'package:hack_improved/level_two.dart';
import 'package:hack_improved/screens/loading_screen.dart';
import 'package:hack_improved/screens/phase_zero.dart';
import 'package:hack_improved/screens/phase_one.dart';
import 'package:hack_improved/screens/power_dashboard.dart';
import 'package:hack_improved/screens/splash_screen.dart';
import 'package:hack_improved/screens/social_media_level.dart';
import 'package:hack_improved/screens/level_five.dart';
import 'package:hack_improved/screens/linkedin_profile_screen.dart';
import 'package:hack_improved/screens/password_cracker_screen.dart';
import 'package:hack_improved/constants.dart';

// TODO: AAyush you have to add These two providers on top of level two
// and six
// TODO: Transition between levels, check if everything works here and
// if they can transition properly
// transition = LockWorldTransition();
//
// await add(
//   FlameBlocProvider<LevelTwoBloc, LevelTwoState>(
//     create: () => LevelTwoBloc(),
//     children: [cam, levelTwo],
//   ),
// );
// await add(
//   FlameBlocProvider<LevelSixBloc, LevelSixState>(
//     create: () => LevelSixBloc(),
//     children: [cam, levelSix],
//   ),
// );

class HackGame extends FlameGame {
  late CameraComponent cam;
  late SplashScreen splashScreen;
  late LoadingScreen loadingScreen;
  late PhaseZero phaseZero;
  late PhaseOne phaseOne;
  late PowerDashboard powerDashboard;
  late LevelTwo levelTwo;
  late SocialMediaLevel socialMediaLevel;
  late LevelFive levelFive;
  late LinkedInProfileScreen linkedInProfileScreen;
  PasswordCrackerScreen? passwordCrackerScreen;

  // Store the company name entered by the player
  String companyName = 'Company Name';

  // Cheat navigation methods
  void navigateToSplash() {
    cam.world = splashScreen;
  }

  void navigateToLoading() {
    cam.world = loadingScreen;
  }

  void navigateToPhaseZero() {
    cam.world = phaseZero;
    phaseZero.startSequence();
  }

  void navigateToPhaseOne() {
    cam.world = phaseOne;
    phaseOne.startSequence();
  }

  void navigateToPowerDashboard() {
    cam.world = powerDashboard;
  }

  void navigateToLevelTwo() {
    cam.world = levelTwo;
  }

  void navigateToSocialMediaLevel() {
    cam.world = socialMediaLevel;
  }

  void navigateToLevelFive() {
    cam.world = levelFive;
    levelFive.startSequence();
  }

  void navigateToLinkedInProfile() {
    cam.world = linkedInProfileScreen;
  }

  void navigateToPasswordCracker(Set<String> cluesFound) {
    // Create a new password cracker screen with the clues
    passwordCrackerScreen = PasswordCrackerScreen(cluesFound: cluesFound);
    add(passwordCrackerScreen!);
    cam.world = passwordCrackerScreen;
  }

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    _loadLevels();
    return super.onLoad();
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 0, 0, 0);
  }

  Future<void> _loadLevels() async {
    add(FpsTextComponent());
    splashScreen = SplashScreen();
    phaseZero = PhaseZero();
    phaseOne = PhaseOne();
    powerDashboard = PowerDashboard();
    levelTwo = LevelTwo();
    socialMediaLevel = SocialMediaLevel();
    levelFive = LevelFive();
    linkedInProfileScreen = LinkedInProfileScreen();
    loadingScreen = LoadingScreen();

    final levelTwoProvider = FlameBlocProvider<LevelTwoBloc, LevelTwoState>(
      create: LevelTwoBloc.new,
      children: [levelTwo],
    );

    cam = CameraComponent.withFixedResolution(
      world: splashScreen,
      width: GameDimensions.gameWidth,
      height: GameDimensions.gameHeight,
    );

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      splashScreen,
      loadingScreen,
      phaseZero,
      phaseOne,
      powerDashboard,
      levelTwoProvider,
      socialMediaLevel,
      levelFive,
      linkedInProfileScreen,
    ]);
  }
}
