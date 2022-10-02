// Dart imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/model/timer/timer_info.dart';
import 'package:pomodoro/data/repository/timer_repository_impl.dart';

final timerViewModelProvider = ChangeNotifierProvider<TimerViewModel>(
  TimerViewModel.new,
);

class TimerViewModel extends ChangeNotifier {
  TimerViewModel(this._ref);

  // final Ref _ref;
  final Ref _ref;

  late final _timerRepository = _ref.read(timerRepositoryProvider);

  Future<void> add(String name) async {
    final timerInfo = TimerInfo(name: name);
    await _timerRepository.save(timerInfo);
  }

  // Future<void> load(WidgetRef ref) async {
  //   final timerInfo = _timerRepository.get().then((result) {
  //     result.when(
  //       success: (TimerInfo? data) {
  //         debugPrint(data!.name);
  //       },
  //       failure: (dynamic data) => {
  //         debugPrint('none'),
  //       },
  //     );
  //   });
  // }
}
