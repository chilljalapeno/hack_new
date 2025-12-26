part of 'level_two_bloc.dart';

@freezed
sealed class LevelTwoEvent with _$LevelTwoEvent {
  const factory LevelTwoEvent.infected({required int serverNumber}) = Infected;
  const factory LevelTwoEvent.safe({required int serverNumber}) = Safe;
  const factory LevelTwoEvent.check() = Check;
}
