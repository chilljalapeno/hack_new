part of 'level_two_bloc.dart';

@freezed
class LevelTwoState with _$LevelTwoState {
  factory LevelTwoState({required List<int> servers}) = _LevelTwoState;
  const factory LevelTwoState.initial() {
    return LevelTwoState(servers: List.filled(8, 0));
} ;
}
