// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/model/shaft/shaft.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/repository/shaft_repository_impl.dart';

/// 軸の変更・記憶を行う StateNotifier
class ShaftViewModel extends Notifier<ShaftState> {
  ShaftViewModel();

  // 初期値の設定
  @override
  ShaftState build() {
    initialize();
    return ShaftState.work;
  }

  late final _repository = ref.watch(shaftRepositoryProvider);

  /// 選択されたテーマの記憶があれば取得して反映する
  Future<void> initialize() async {
    final shaftState = await _shaftState;
    debugPrint(shaftState.toString());
    state = ShaftState.values.firstWhere(
      (shaft) => shaft == shaftState,
      orElse: () => ShaftState.work,
    );
  }

  /// 前回の軸を取得する
  Future<ShaftState?> get _shaftState async => _repository.get();

  Future<void> change(ShaftState shaft) async {
    await _repository.save(shaft);
    state = shaft;
    debugPrint('Shaft was changed to ${state.name}!');
  }

  /// ログをカウントする
  Future<void> countLog() async {
    final box = await Hive.openBox<Shaft>('shaftsBox');
    late final Shaft? log;

    log = box.get(
      state.name,
      defaultValue: Shaft(
        type: state.name,
        totalTime: 0,
        date: DateTime.now(),
      ),
    );

    log!.totalTime += 1;
    await box.put(state.name, log);
  }

  Future<void> resetShaftLog(ShaftState shaft) => _repository.reset(shaft);

  // ハードコーディングをやめるときにつかう
  String stateName(ShaftState shaft) => shaft.displayName;
}
