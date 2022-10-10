// Dart imports:
// ignore_for_file: parameter_assignments

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/constant/utils.dart';
import 'package:pomodoro/provider/pomo_provider.dart';

/// TODO: progress が一時停止のタイミングによってたまに重複する。

class PomoViewModel extends ChangeNotifier {
  PomoViewModel(this._ref);

  final Ref _ref;

  /// タイマーを開始する。
  Future<void> startPomo(WidgetRef ref) async {
    final settingTime = ref.watch(settingTimeProvider);
    final unitOfProgress = 1.0 / settingTime;
    const progress = 0.0;

    ref.read(displayTimeProvider.notifier).update((state) => settingTime);
    startTimer(ref, progress, unitOfProgress, settingTime);
    notifyListeners();
  }

  /// タイマーを再開する。
  void restartPomo(WidgetRef ref) {
    final settingTime = ref.watch(settingTimeProvider);
    final remainingTime = ref.watch(remainingTimeProvider);
    final unitOfProgress = 1.0 / settingTime;
    final progress = unitOfProgress * (settingTime - remainingTime);

    ref.read(displayTimeProvider.notifier).update((state) => remainingTime);
    startTimer(ref, progress, unitOfProgress, settingTime);
    notifyListeners();
  }

  /// タイマーを一時停止する。
  void pausePomo(WidgetRef ref, int currentProgressTime) {
    ref.read(timerProvider).cancel();
    ref
        .read(remainingTimeProvider.notifier)
        .update((state) => currentProgressTime - 1);
    Utils.changePomoPausing(ref);
    debugPrint('pause! reaminingTime is ${ref.watch(remainingTimeProvider)}.');
    notifyListeners();
  }

  /// タイマーを終了する。
  void stopPomo(WidgetRef ref) {
    final settingTime = ref.watch(settingTimeProvider);

    // PomoState を stopping にする。
    Utils.changePomoStopping(ref);
    ref.read(timerProvider).cancel();
    ref.read(progressProvider.notifier).update((state) => 0.0);
    ref.read(displayTimeProvider.notifier).update((state) => settingTime);
    notifyListeners();
  }

  /// タイマーのロジックを担う。
  void startTimer(
    WidgetRef ref,
    double progress,
    double unitOfProgress,
    int settingTime,
  ) {
    debugPrint('start!');
    // PomoState を working に変更する。
    Utils.changePomoWorking(ref);
    ref.read(timerProvider.notifier).update(
          (state) => Timer.periodic(
            // 1 秒間隔で進行する。
            const Duration(seconds: 1),
            (Timer timer) {
              // 毎秒カウントダウンする。
              ref.read(displayTimeProvider.notifier).state--;
              // プロバイダを用いずにわざわざここでカウントするのは、
              // プログレスが 1.0 を超えるのを先に感知して次の if 文で分岐させるため。
              progress += unitOfProgress;

              // プログレスバーが進行中かどうか。
              progress < 1.0
                  ? ref.read(progressProvider.notifier).state += unitOfProgress
                  : stopPomo(ref);
              notifyListeners();
            },
          ),
        );
  }
}
