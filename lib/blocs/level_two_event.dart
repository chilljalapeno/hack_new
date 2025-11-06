part of 'level_two_bloc.dart';

@freezed
class LevelTwoEvent with _$LevelTwoEvent {
  const factory LevelTwoEvent.infected() = Infected;
  const factory LevelTwoEvent.safe() = Safe;
}
