import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hack_improved/level_two/models/server_type.dart';

part 'level_two_event.dart';
part 'level_two_state.dart';
part 'level_two_bloc.freezed.dart';

class LevelTwoBloc extends Bloc<LevelTwoEvent, LevelTwoState> {
  LevelTwoBloc() : super(LevelTwoState.initial()) {
    on<Infected>((event, emit) {
      assert(state is Initial);
      List<ServerType> data = List.from((state as Initial).servers);
      data[event.serverNumber] = ServerType.infected;

      int correctServers = 0;
      for (int i = 0; i < (state as Initial).servers.length; i += 1) {
        if (data[i] == (state as Initial).winServers[i]) {
          correctServers += 1;
        }
      }
      emit(
        (state as Initial).copyWith(
          servers: data,
          correctServers: correctServers,
        ),
      );
    });

    on<Safe>((event, emit) {
      assert(state is Initial);
      List<ServerType> data = List.from((state as Initial).servers);
      data[event.serverNumber] = ServerType.safe;

      int correctServers = 0;
      for (int i = 0; i < (state as Initial).servers.length; i += 1) {
        if (data[i] == (state as Initial).winServers[i]) {
          correctServers += 1;
        }
      }
      emit(
        (state as Initial).copyWith(
          servers: data,
          correctServers: correctServers,
        ),
      );
    });

    on<Check>((event, emit) {
      assert(state is Initial);
      final theState = state as Initial;
      for (int i = 0; i < theState.servers.length; i += 1) {
        if (theState.servers[i] != theState.winServers[i]) return;
      }
      emit(LevelTwoState.win());
    });
  }
}
