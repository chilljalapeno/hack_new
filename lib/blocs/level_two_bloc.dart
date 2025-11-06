import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_two_event.dart';
part 'level_two_state.dart';
part 'level_two_bloc.freezed.dart';

class LevelTwoBloc extends Bloc<LevelTwoEvent, LevelTwoState> {
  LevelTwoBloc() : super(Initial()) {
    on<Infected>((event, emit) {});
    on<Safe>((event, emit) {});
  }
}
