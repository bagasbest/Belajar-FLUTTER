import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    //kembalikan = yield

    yield (event is Increment)
        ? CounterState(state.value + 1)
        : CounterState((state.value > 0) ? state.value - 1 : 0);
  }

  @override
  // TODO: implement initialState
  CounterState get initialState => CounterState(0);
}
