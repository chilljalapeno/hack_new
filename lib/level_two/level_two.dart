import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:hack_improved/level_two/bloc/level_two_bloc.dart';
import 'package:hack_improved/misc/end_screen.dart';
import 'package:hack_improved/misc/main_container.dart';
import 'package:hack_improved/misc/server_zoomin.dart';
import 'package:hack_improved/misc/servers_overview.dart';
import 'package:hack_improved/misc/ui.dart';

class LevelTwo extends World
    with FlameBlocListenable<LevelTwoBloc, LevelTwoState> {
  late final RouterComponent router;
  late UI ui;

  @override
  void onNewState(LevelTwoState state) {
    if (state is Win) {
      router.pushNamed('end');
    }
  }

  @override
  Future<void> onLoad() async {
    ui = UI();
    add(ui);

    router = RouterComponent(
      initialRoute: 'home',
      routes: {
        'home': Route(() => MainContainer(child: ServerOverview())),
        'end': Route(() => MainContainer(child: EndScreen())),
        'server0': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 0,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server1': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 1,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server2': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 2,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server3': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 3,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server4': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 4,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server5': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 5,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server6': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 6,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server7': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 7,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
      },
    );
    add(router);
    super.onLoad();
  }
}
