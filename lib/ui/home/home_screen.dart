// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Project imports:
import 'package:pomodoro/ui/component/floating_action_button_screen.dart';

final percentProvider = StateProvider<double>((ref) => 0);
final timeInSecProvider = StateProvider<int>((ref) => 60 * 25);
final timerProvider = StateProvider<TimerState>((ref) => TimerState.stopping);

enum TimerState {
  working,
  pausing,
  stopping,
}

/// providerにする必要なかったかも
final pomoProvider = StateProvider<Timer>(
  (ref) => Timer.periodic(const Duration(seconds: 1), (Timer pomo) {}),
);

class HomeScreen extends HookConsumerWidget with WidgetsBindingObserver {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(percentProvider);
    final timeInSec = ref.watch(timeInSecProvider);

    final min = timeInSec ~/ 60;
    final sec = timeInSec - (min * 60);

    useEffect(
      () {
        WidgetsBinding.instance.addObserver(this);
        ref.read(pomoProvider.notifier).state.cancel();
        // timer.cancel();
        return null;
      },
      const [],
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
                center: Text(
                  '$min : $sec',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButtonScreen(),
    );
  }
}
