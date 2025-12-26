part of "level_six_bloc.dart";

@freezed
class LevelSixEvent with _$LevelSixEvent {
  const factory LevelSixEvent.safe({
    required int emailNumber,
    required int numberOfSelected,
  }) = Safe;
  const factory LevelSixEvent.phishing({
    required int emailNumber,
    required int numberOfSelected,
  }) = Phishing;
  const factory LevelSixEvent.complete() = Complete;
  const factory LevelSixEvent.change({
    required int emailNumber,
    required int increase,
  }) = Change;
}
