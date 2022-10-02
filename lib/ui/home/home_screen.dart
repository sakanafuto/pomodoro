// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// Project imports:
import 'package:pomodoro/ui/pomo/add_timer_screen.dart';
import 'package:pomodoro/ui/pomo/pomo_view_model.dart';

// Project imports:


final percentProvider = StateProvider<double>((ref) => 0);
final timeInSecProvider = StateProvider<int>((ref) => 60);

/// providerにする必要なかったかも
final pomoProvider = StateProvider<Timer>(
  (ref) => Timer.periodic(const Duration(seconds: 1), (Timer pomo) {}),
);

class HomeScreen extends HookConsumerWidget with WidgetsBindingObserver {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pomoViewModelProvider);

    final percent = ref.watch(percentProvider);
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
          SizedBox(
            width: 200,
            child: CircularPercentIndicator(
              percent: percent,
              animation: true,
              animateFromLastPercent: true,
              radius: 120,
              lineWidth: 8,
              progressColor: Theme.of(context).colorScheme.primary,
              center: Text(
                '$min : $sec',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => ref.watch(pomoProvider.notifier).state.isActive
                    ? ref.read(pomoProvider.notifier).state.cancel()
                    : null,
                child: const Text('stop'),
              ),
              ElevatedButton(
                onPressed: () =>

                    /// TODO: 一時から再開後にどうstartPomoするか。
                    !ref.watch(pomoProvider.notifier).state.isActive
                        ? viewModel.startPomo(timeInSec, ref)
                        : null,
                child: const Text('start'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<dynamic>(
          context,
          SizeRoute(
            page: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 1000,
                width: 1000,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.grey.shade100,
                            margin: const EdgeInsets.all(16),
                            child: TextButton(
                              onPressed: () => <Widget>{},
                              child: const Text('とりあえず集中'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: Colors.grey.shade100,
                            margin: const EdgeInsets.all(16),
                            child: TextButton(
                              onPressed: () => Navigator.push<dynamic>(
                                context,
                                SizeRoute(
                                  page: GestureDetector(
                                    onTap: () => Navigator.popUntil(
                                      context,
                                      (route) => route.isFirst,
                                    ),
                                    child: const Center(
                                      child: AddPomoScreen(),
                                    ),
                                  ),
                                ),
                              ),
                              child: const Text('集中する仕事を決める'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        // shape: BeveledRectangleBorder(
        //borderRadius: BorderRadius.circular(20)),
        mini: true,
        child: const Icon(
          Icons.add_alarm,
        ),
      ),
    );
  }
}

class SizeRoute extends PageRouteBuilder<Route<dynamic>> {
  SizeRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Align(
              child: SizeTransition(sizeFactor: animation, child: child),
            );
          },
        );

  final Widget page;
}
