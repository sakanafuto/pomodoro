// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/repository/pomo_repository_impl.dart';
import 'package:pomodoro/ui/home/home_screen.dart';

final pomoViewModelProvider = ChangeNotifierProvider<PomoViewModel>(
  PomoViewModel.new,
);

class PomoViewModel extends ChangeNotifier {
  PomoViewModel(this._ref);

  final Ref _ref;

  late final _pomoRepository = _ref.read(pomoRepositoryProvider);

  // Future<void> add({
  //   required String name,
  //   required int minute,
  //   required String caption,
  // }) async {
  //   final pomoInfo = PomoInfo(name: name, minute: minute, caption: caption);
  //   await _pomoRepository.save(pomoInfo);
  //   notifyListeners();
  // }

  // Future<void> delete({required Pomo pomo}) async {
  //   _pomoRepository.delete(pomo);
  //   notifyListeners();
  // }

  /// タイマーのロジック
  Future<void> startPomo(int totalSec, WidgetRef ref) async {
    debugPrint(totalSec.toString());
    final ps = 1.0 / totalSec;
    var psCount = 0.0;
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
              ref.read(percentProvider.notifier).state += ps;
            } else {
              ref.read(percentProvider.notifier).state = 0.0;
              psCount = 0;
            }
          } else {
            ref.read(percentProvider.notifier).state = 0.0;
            ref.read(timeInSecProvider.notifier).state = 60;
            timer.cancel();
          }
        }
      },
    );
  }
}
