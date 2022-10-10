// Dart imports:
// ignore_for_file: parameter_assignments

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/utils.dart';
import 'package:pomodoro/provider/pomo_provider.dart';

class PomoViewModel extends ChangeNotifier {
  PomoViewModel(this._ref);

  // ignore: unused_field
  final Ref _ref;

  /// タイマーを開始する。
  Future<void> startPomo(BuildContext context, WidgetRef ref) async {
    final settingTime = ref.watch(settingTimeProvider);
    final unitOfProgress = 1.0 / settingTime;
    const progress = 0.0;

    ref.read(displayTimeProvider.notifier).update((state) => settingTime);
    startTimer(context, ref, progress, unitOfProgress, settingTime);

    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    notifyListeners();
  }

  /// タイマーを再開する。
  void restartPomo(BuildContext context, WidgetRef ref) {
    final settingTime = ref.watch(settingTimeProvider);
    final remainingTime = ref.watch(remainingTimeProvider);
    final unitOfProgress = 1.0 / settingTime;
    final progress = unitOfProgress * (settingTime - remainingTime);

    ref.read(displayTimeProvider.notifier).update((state) => remainingTime);
    startTimer(context, ref, progress, unitOfProgress, settingTime);

    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    notifyListeners();
  }

  /// タイマーを一時停止する。
  void pausePomo(BuildContext context, WidgetRef ref, int currentProgressTime) {
    ref.read(timerProvider).cancel();
    ref
        .read(remainingTimeProvider.notifier)
        .update((state) => currentProgressTime - 1);
    changePomoPausing(ref);
    debugPrint('pause! reaminingTime is ${ref.watch(remainingTimeProvider)}.');

    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    notifyListeners();
  }

  /// タイマーを終了する。
  void stopPomo(BuildContext context, WidgetRef ref) {
    final settingTime = ref.watch(settingTimeProvider);

    // PomoState を stopping にする。
    changePomoStopping(ref);
    ref.read(timerProvider).cancel();
    ref.read(progressProvider.notifier).update((state) => 0.0);
    ref.read(displayTimeProvider.notifier).update((state) => settingTime);

    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    notifyListeners();
  }

  /// タイマーのロジックを担う。
  void startTimer(
    BuildContext context,
    WidgetRef ref,
    double progress,
    double unitOfProgress,
    int settingTime,
  ) {
    debugPrint('start!');
    final progressBar = ref.watch(progressProvider);
    // PomoState を working に変更する。
    changePomoWorking(ref);
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
              if (progressBar < 0.997) {
                ref.read(progressProvider.notifier).state += unitOfProgress;
              }

              if (1.0 <= progress ||
                  ref.watch(displayTimeProvider.notifier).state == 0) {
                stopPomo(context, ref);
              }

              notifyListeners();
            },
          ),
        );
  }
}
