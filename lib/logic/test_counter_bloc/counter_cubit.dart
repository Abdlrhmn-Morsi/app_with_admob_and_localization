import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counterValue: 0));

  static CounterCubit get(context) => BlocProvider.of(context);

  void counterIncrement() {
    emit(CounterState(counterValue: state.counterValue + 1));
  }

  void counterDecrement() {
    emit(CounterState(counterValue: state.counterValue - 1));
  }
}
