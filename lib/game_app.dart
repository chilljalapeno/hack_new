import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hack_improved/blocs/level_two_bloc.dart';
import 'package:hack_improved/hack_game.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = HackGame();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SafeArea(
            child: FittedBox(
              child: SizedBox(
                width: 1920,
                height: 1080,
                child: Center(
                  child: GameWidget(
                    game: game,
                    overlayBuilderMap: {
                      "ServerStatus": (BuildContext context, HackGame game) {
                        return Container(
                          width: 1920,
                          height: 1080,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Center(
                            child: Container(
                              width: 800,
                              height: 600,
                              decoration: BoxDecoration(
                                color: Color(0xB30D2030),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Current server status",
                                    style: TextStyle(
                                      fontSize: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  SizedBox(
                                    width: 700,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.check,
                                              size: 48,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              "Correct servers: ",
                                              style: TextStyle(
                                                fontSize: 48,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${(game.levelTwo.bloc.state as Initial).correctServers}",
                                          style: TextStyle(
                                            fontSize: 48,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 700,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.close,
                                              size: 48,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              "Incorrect servers: ",
                                              style: TextStyle(
                                                fontSize: 48,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${8 - (game.levelTwo.bloc.state as Initial).correctServers}",
                                          style: TextStyle(
                                            fontSize: 48,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  GestureDetector(
                                    onTap: () {
                                      game.overlays.remove("ServerStatus");
                                      game.levelTwo.bloc.add(
                                        LevelTwoEvent.check(),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.blueGrey,
                                      ),
                                      height: 100,
                                      width: 500,
                                      child: Center(
                                        child: Text(
                                          "Check servers",
                                          style: TextStyle(
                                            fontSize: 32,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
