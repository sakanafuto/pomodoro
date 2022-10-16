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
import 'package:pomodoro/component/size_route.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/screen/pomo/zen_screen.dart';

class PomoScreen extends HookConsumerWidget with WidgetsBindingObserver {
  PomoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(progressProvider);
    final displayTime = ref.watch(displayTimeProvider);

    final minute = displayTime ~/ 60;
    final second = displayTime - (minute * 60);

    useEffect(
      () {
        WidgetsBinding.instance.addObserver(this);
        ref.read(timerProvider).cancel();
        return null;
      },
      const [],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: const FloatingActionButtonScreen(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () => Navigator.push<dynamic>(
                context,
                SizeRoute(
                  page: GestureDetector(
                    onTap: () => Navigator.popUntil(
                      context,
                      (Route<dynamic> route) => route.isFirst,
                    ),
                    child: const ZenScreen(),
                  ),
                ),
              ),
              child: Text(
                '$minute : $second',
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ),
          const Gap(40),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: LinearPercentIndicator(
                progressColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                lineHeight: 8,
                barRadius: const Radius.circular(16),
                // progressColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
