// Dart imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:

final timerViewModelProvider = ChangeNotifierProvider<TimerViewModel>(
  (ref) => TimerViewModel(),
);

class TimerViewModel extends ChangeNotifier {
  TimerViewModel();

  // late final TimerRepository _timerRepository =
  //     _reader(timerRepositoryProvider);

  // Future<void> add(String name) async {
  //   final timerInfo = TimerInfo(name: name);
  //   _timerRepository.save(timerInfo);
  // }

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
