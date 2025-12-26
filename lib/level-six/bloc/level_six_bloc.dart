import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "level_six_event.dart";
part "level_six_state.dart";
part "level_six_bloc.freezed.dart";

// Email number + number of selected
// if numberOfSelected == state.emailNumber {
// mark as completed
// }
class LevelSixBloc extends Bloc<LevelSixEvent, LevelSixState> {
  LevelSixBloc() : super(LevelSixState.initial()) {
    on<Safe>((event, emit) {
      switch (event.emailNumber) {
        case 1:
          if (state.numberOfSelected1 == state.email1 && state.email1 == 0) {
            emit(state.copyWith(email1Check: true));
          }
        case 2:
          if (state.numberOfSelected2 == state.email2 && state.email2 == 0) {
            emit(state.copyWith(email2Check: true));
          }
        case 3:
          if (state.numberOfSelected3 == state.email3 && state.email3 == 0) {
            emit(state.copyWith(email3Check: true));
          }
        case 4:
          if (state.numberOfSelected4 == state.email4 && state.email4 == 0) {
            emit(state.copyWith(email4Check: true));
          }
        case 5:
          if (state.numberOfSelected5 == state.email5 && state.email5 == 0) {
            emit(state.copyWith(email5Check: true));
          }
        default:
          throw Error();
      }
    });
    on<Phishing>((event, emit) {
      switch (event.emailNumber) {
        case 1:
          if (event.numberOfSelected == state.email1 && state.email1 != 0) {
            emit(state.copyWith(email1Check: true));
          }
          break;
        case 2:
          if (event.numberOfSelected == state.email2 && state.email2 != 0) {
            emit(state.copyWith(email2Check: true));
          }
          break;
        case 3:
          if (event.numberOfSelected == state.email3 && state.email3 != 0) {
            emit(state.copyWith(email3Check: true));
          }
          break;
        case 4:
          if (event.numberOfSelected == state.email4 && state.email4 != 0) {
            emit(state.copyWith(email4Check: true));
          }
          break;
        case 5:
          if (event.numberOfSelected == state.email5 && state.email5 != 0) {
            emit(state.copyWith(email5Check: true));
          }
          break;
        default:
          throw Error();
      }
    });
    on<Change>((event, emit) {
      switch (event.emailNumber) {
        case 1:
          emit(
            state.copyWith(
              numberOfSelected1: state.numberOfSelected1 + event.increase,
            ),
          );
          break;
        case 2:
          emit(
            state.copyWith(
              numberOfSelected2: state.numberOfSelected2 + event.increase,
            ),
          );
          break;
        case 3:
          emit(
            state.copyWith(
              numberOfSelected3: state.numberOfSelected3 + event.increase,
            ),
          );
          break;
        case 4:
          emit(
            state.copyWith(
              numberOfSelected4: state.numberOfSelected4 + event.increase,
            ),
          );
          break;
        case 5:
          emit(
            state.copyWith(
              numberOfSelected5: state.numberOfSelected5 + event.increase,
            ),
          );
          break;
      }
    });
    on<Complete>((event, emit) {
      if (state.email1Check &&
          state.email2Check &&
          state.email3Check &&
          state.email4Check &&
          state.email5Check) {
        emit(Completed());
      }
    });
  }
}
