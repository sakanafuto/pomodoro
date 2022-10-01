// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/model/timer/timer_state.dart';
import 'package:pomodoro/data/model/timer/timer_state_info.dart';
import 'package:pomodoro/data/repository/timer_repository.dart';
import 'package:pomodoro/data/repository/timer_repository_impl.dart';

final timerViewModelProvider =
    StateNotifierProvider<TimerViewModel, TimerState>(
  (ref) => TimerViewModel(ref.read),
);

class TimerViewModel extends StateNotifier<TimerState> {
  TimerViewModel(this._reader) : super(const TimerState(name: 'timer 1'));

  final Reader _reader;

  late final TimerRepository _timerRepository =
      _reader(timerRepositoryProvider);

  Future<void> add(String name) async {
    final timerStateInfo = TimerStateInfo(name: name);
    _timerRepository.save(timerStateInfo);
  }

  Future<void> load(WidgetRef ref) async {
    final timerStateInfo = _timerRepository.get().then((result) {
      result.when(
        success: (TimerStateInfo? data) {
          debugPrint(data!.name);
        },
        failure: (dynamic data) => {
          debugPrint('none'),
        },
      );
    });
  }
}
