import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/data/timer_state.dart';

final timerViewModelProvider =
    StateNotifierProvider<TimerViewModel, TimerState>(
  (ref) => TimerViewModel(),
);

class TimerViewModel extends StateNotifier<TimerState> {
  TimerViewModel() : super(const TimerState(name: 'timer 1'));

  void add(String name) {
    debugPrint(name);
  }
}
