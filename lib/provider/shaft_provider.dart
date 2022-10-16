// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/model/shaft/shaft_state.dart';

final shaftStateProvider = StateProvider<ShaftState>((ref) => ShaftState.work);
