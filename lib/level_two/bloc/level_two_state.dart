part of 'level_two_bloc.dart';

@freezed
sealed class LevelTwoState with _$LevelTwoState {
  @Assert('servers.length == 8', 'There should be 8 servers')
  const factory LevelTwoState.initial([
    @Default(<ServerType>[
      ServerType.infected,
      ServerType.infected,
      ServerType.safe,
      ServerType.infected,
      ServerType.safe,
      ServerType.safe,
      ServerType.infected,
      ServerType.safe,
    ])
    List<ServerType> winServers,
    @Default(<ServerType>[
      ServerType.unknown,
      ServerType.unknown,
      ServerType.unknown,
      ServerType.unknown,
      ServerType.unknown,
      ServerType.unknown,
      ServerType.unknown,
      ServerType.unknown,
    ])
    List<ServerType> servers,
    @Default(0) int correctServers,
  ]) = Initial;

  const factory LevelTwoState.win() = Win;
}
