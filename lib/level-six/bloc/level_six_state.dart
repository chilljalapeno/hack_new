part of "level_six_bloc.dart";

@freezed
sealed class LevelSixState with _$LevelSixState {
  const factory LevelSixState.initial({
    @Default(3) int email1,
    @Default(4) int email2,
    @Default(2) int email3,
    @Default(0) int email4,
    @Default(0) int email5,

    @Default(0) int numberOfSelected1,
    @Default(0) int numberOfSelected2,
    @Default(0) int numberOfSelected3,
    @Default(0) int numberOfSelected4,
    @Default(0) int numberOfSelected5,

    @Default(false) bool email1Check,
    @Default(false) bool email2Check,
    @Default(false) bool email3Check,
    @Default(false) bool email4Check,
    @Default(false) bool email5Check,
  }) = Initial;
  const factory LevelSixState.completed({
    @Default(3) int email1,
    @Default(4) int email2,
    @Default(2) int email3,
    @Default(0) int email4,
    @Default(0) int email5,

    @Default(0) int numberOfSelected1,
    @Default(0) int numberOfSelected2,
    @Default(0) int numberOfSelected3,
    @Default(0) int numberOfSelected4,
    @Default(0) int numberOfSelected5,

    @Default(false) bool email1Check,
    @Default(false) bool email2Check,
    @Default(false) bool email3Check,
    @Default(false) bool email4Check,
    @Default(false) bool email5Check,
  }) = Completed;
}
