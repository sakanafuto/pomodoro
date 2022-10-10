// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Project imports:
import 'package:pomodoro/component/floating_action_button_screen.dart';
import 'package:pomodoro/provider/pomo_provider.dart';

enum PomoState {
  working,
  pausing,
  stopping,
}

/// providerにする必要なかったかも
final pomoProvider = StateProvider<Timer>(
  (ref) => Timer.periodic(const Duration(seconds: 1), (Timer pomo) {}),
);

class PomoScreen extends HookConsumerWidget with WidgetsBindingObserver {
  PomoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(percentProvider.notifier).state;
    final timeInSec = ref.watch(timeInSecProvider);

    final min = timeInSec ~/ 60;
    final sec = timeInSec - (min * 60);

    useEffect(
      () {
        WidgetsBinding.instance.addObserver(this);
        ref.read(pomoProvider.notifier).state.cancel();
        return null;
      },
      const [],
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '$min : $sec',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          const Gap(32),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LinearPercentIndicator(
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                lineHeight: 30,
                barRadius: const Radius.circular(16),
                progressColor: Theme.of(context).colorScheme.primary,
                center: const Text(''),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButtonScreen(),
    );
  }
}
