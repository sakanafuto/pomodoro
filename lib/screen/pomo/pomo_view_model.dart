// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/constant/pomo_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/screen/pomo/pomo_screen.dart';

class PomoViewModel extends ChangeNotifier {
  PomoViewModel(this._ref);

  // ignore: unused_field
  final Ref _ref;

  /// タイマーのロジック
  Future<void> startPomo(WidgetRef ref, int totalSec) async {
    ref.read(timerProvider.state).update((state) => PomoState.working);
    ref.read(iconProvider.state).update((state) => const Icon(Icons.pause));
    final remainingTime = ref.watch(remainingTimeProvider.notifier).state;

    debugPrint('totalSec: ${totalSec.toString()}');
    debugPrint('remainingTime: ${remainingTime.toString()}');

    // double ps;
    double psCount;
    final ps = 1.0 / totalSec;

    remainingTime == 0
        ? psCount = 0
        : psCount = ps * (totalSec - remainingTime);

    ref.read(pomoProvider.notifier).state = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (ref.watch(timeInSecProvider) > 0) {
          /// 毎秒カウントダウン
          ref.read(timeInSecProvider.notifier).state--;

          /// タイマーが動いている間
          if (ref.watch(timeInSecProvider) > 0.0) {
            psCount += ps;

            /// 59/60までインジケーターが進行し、1になるとインジケーターが0になる
            if (psCount < 1.0) {
              debugPrint('psCount: ${psCount.toString()}');
              ref.read(percentProvider.notifier).state += ps;
            } else {
              ref.read(percentProvider.notifier).state = 0.0;
              psCount = 0;
            }
          } else {
            ref.read(percentProvider.notifier).state = 0.0;
            ref.read(timeInSecProvider.notifier).state = totalSec;
            ref.read(timerProvider.state).update((state) => PomoState.stopping);
            ref
                .read(iconProvider.state)
                .update((state) => const Icon(Icons.play_arrow));
            ref.read(remainingTimeProvider.notifier).state = 0;
            timer.cancel();
            notifyListeners();
          }
        }
      },
    );
  }
}
