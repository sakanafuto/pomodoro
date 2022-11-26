// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/model/pomo/pomo_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';

void changePomoWorking(WidgetRef ref) {
  // PomoState を working に変更する。
  ref.read(pomoStateProvider.notifier).update((state) => PomoState.working);
  // FAB のアイコンを pause に変更する。
  ref.read(iconProvider.notifier).update((state) => const Icon(Icons.pause));
}

void changePomoPausing(WidgetRef ref) {
  // PomoState を pausing に変更する。
  ref.read(pomoStateProvider.notifier).update((state) => PomoState.pausing);
  // FAB のアイコンを play_arrow に変更する。
  ref
      .read(iconProvider.notifier)
      .update((state) => const Icon(Icons.play_arrow));
}

void changePomoStopping(WidgetRef ref) {
  // PomoState を stopping に変更する。
  ref.read(pomoStateProvider.notifier).update((state) => PomoState.stopping);
  // FAB のアイコンを play_arrow に変更する。
  ref
      .read(iconProvider.notifier)
      .update((state) => const Icon(Icons.play_arrow));
}
