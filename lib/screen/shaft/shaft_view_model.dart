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
class ShaftViewModel extends StateNotifier<ShaftState> {
  ShaftViewModel(this._ref) : super(ShaftState.work) {
    initialize();
  }

  // ignore: unused_field
  final Ref _ref;

  late final _repository = _ref.watch(shaftRepositoryProvider);

  /// 選択されたテーマの記憶があれば取得して反映
  Future<void> initialize() async {
    final shaftState = await _shaftState;
    debugPrint(shaftState.toString());
    state = ShaftState.values.firstWhere(
      (shaft) => shaft == shaftState,
      orElse: () => ShaftState.work,
    );
  }

  Future<ShaftState?> get _shaftState async => _repository.get();

  Future<void> change(ShaftState shaft) async {
    await _repository.save(shaft);
    state = shaft;
    debugPrint('Shaft was changed to ${state.name}!');
  }

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

  String stateName(ShaftState shaft) => shaft.displayName;
}
