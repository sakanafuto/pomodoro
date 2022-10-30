// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/model/shaft/shaft_selector.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';

/// ShaftState を監視する。
final shaftStateProvider = StateProvider<ShaftState>((ref) => ShaftState.work);

/// テーマ選択のProvider
final shaftSelectorProvider = StateNotifierProvider(ShaftSelector.new);
