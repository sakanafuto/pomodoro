// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/repository/shaft_repository.dart';

// Project imports:

final shaftRepositoryProvider =
    Provider<ShaftRepositoryImpl>(ShaftRepositoryImpl.new);

class ShaftRepositoryImpl implements ShaftRepository {
  ShaftRepositoryImpl(this._ref);

  // ignore: unused_field
  final Ref _ref;

  @override
  Future<void> save(ShaftState shaft) async {
    debugPrint('repository.save ${shaft.name}');
    final box = await Hive.openBox<ShaftState>('shaftStatesBox');
    await box.put('shaftState', shaft);
  }

  @override
  Future<ShaftState?> get() async {
    final box = await Hive.openBox<ShaftState>('shaftStatesBox');
    return box.get('shaftState', defaultValue: ShaftState.work);
  }
}
