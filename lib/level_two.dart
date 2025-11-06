import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:hack_improved/components/end_screen.dart';
import 'package:hack_improved/components/main_container.dart';
import 'package:hack_improved/components/server_zoomin.dart';
import 'package:hack_improved/components/servers_overview.dart';
import 'package:hack_improved/components/ui.dart';

class LevelTwo extends World {
  late final RouterComponent router;
  @override
  Future<void> onLoad() async {
    UI ui = UI();
    add(ui);

    router = RouterComponent(
      initialRoute: 'home',
      routes: {
        'home': Route(() => MainContainer(child: ServerOverview())),
        'end': Route(() => MainContainer(child: EndScreen())),
        'server0': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 1,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server1': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 2,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server2': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 3,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server3': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 4,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server4': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 5,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server5': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 6,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server6': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 7,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
        'server7': Route(
          () => MainContainer(
            child: ServerZoomIn(
              serverNumber: 8,
              networkStatus: NetworkStatus.normal,
              firewallStatus: FirewallStatus.secure,
            ),
          ),
        ),
      },
    );
    add(router);
    // ServerOverview serverOverview = ServerOverview();
    // MainContainer mainContainer = MainContainer(child: serverOverview);

    // EndScreen endScreen = EndScreen();

    // ServerZoomIn serverZoomIn = ServerZoomIn(
    //   serverNumber: 2,
    //   networkStatus: NetworkStatus.normal,
    //   firewallStatus: FirewallStatus.open,
    // );

    // add(ui);
    // add(mainContainer);
    // add(endScreen);
    // add(serverZoomIn);

    super.onLoad();
  }
}
