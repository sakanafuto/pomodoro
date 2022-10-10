// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/constant/pomo_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static void changePomoWorking(WidgetRef ref) {
    // PomoState を working に変更する。
    ref.read(pomoStateProvider.notifier).update((state) => PomoState.working);
    // FAB のアイコンを pause に変更する。
    ref.read(iconProvider.state).update((state) => const Icon(Icons.pause));
  }

  static void changePomoPausing(WidgetRef ref) {
    // PomoState を pausing に変更する。
    ref.read(pomoStateProvider.notifier).update((state) => PomoState.pausing);
    // FAB のアイコンを play_arrow に変更する。
    ref
        .read(iconProvider.state)
        .update((state) => const Icon(Icons.play_arrow));
  }

  static void changePomoStopping(WidgetRef ref) {
    // PomoState を stopping に変更する。
    ref.read(pomoStateProvider.notifier).update((state) => PomoState.stopping);
    // FAB のアイコンを play_arrow に変更する。
    ref
        .read(iconProvider.state)
        .update((state) => const Icon(Icons.play_arrow));
  }
}
