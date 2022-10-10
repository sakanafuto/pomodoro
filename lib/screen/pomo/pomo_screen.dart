// Dart imports:

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

class PomoScreen extends HookConsumerWidget with WidgetsBindingObserver {
  PomoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(progressProvider);
    final timeInSec = ref.watch(displayTimeProvider);

    final min = timeInSec ~/ 60;
    final sec = timeInSec - (min * 60);

    useEffect(
      () {
        WidgetsBinding.instance.addObserver(this);
        ref.read(timerProvider).cancel();
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
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButtonScreen(),
    );
  }
}
