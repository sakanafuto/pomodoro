// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/constant/pomo_state.dart';
import 'package:pomodoro/screen/pomo/pomo_view_model.dart';

final percentProvider = StateProvider<double>((ref) => 0);
final timeInSecProvider = StateProvider<int>((ref) => 60 * 25);
final timerProvider = StateProvider<PomoState>((ref) => PomoState.stopping);

final iconProvider =
    StateProvider<Widget>((ref) => const Icon(Icons.play_arrow));

final remainingTimeProvider = StateProvider<double>((ref) => 0);

final pomoViewModelProvider = ChangeNotifierProvider<PomoViewModel>(
  PomoViewModel.new,
);

final lastTimeProvider = StateProvider<int>((ref) => 25);
