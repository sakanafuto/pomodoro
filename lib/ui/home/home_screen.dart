import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:pomodoro/ui/component/bottom_navigation_bar_view.dart';
import 'package:pomodoro/ui/timer/add_timer_screen.dart';

final percentProvider = StateProvider<double>((ref) => 0);
// final timeInMinProvider = StateProvider<int>((ref) => 1);
final timeInSecProvider = StateProvider<int>((ref) => 300);
final secPercentProvider = StateProvider<double>(
    (ref) => ref.read(timeInSecProvider.notifier).state / 100);

/// providerにする必要なかったかも
final timerProvider = StateProvider<Timer>(
    (ref) => Timer.periodic(const Duration(seconds: 1), (Timer timer) {}));

class HomeScreen extends StatefulHookConsumerWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    /// 画面遷移時、Disposeすることでエラーにはならない
    /// だがアプリ的にはタイマーは動いていてほしいのでToDoである
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// タイマーのロジック
  void _startTimer(WidgetRef ref) async {
    const ps = 1.0 / 300;
    double psCount = 0.0;
    ref.read(timerProvider.notifier).state = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        ref.read(timeInSecProvider) > 0
            ? {
                /// 毎秒カウントダウン
                ref.watch(timeInSecProvider.notifier).state--,

                /// タイマーが動いている間
                ref.watch(timeInSecProvider) > 0.0
                    ? {
                        /// secPercentが1を超えない間
                        ref.watch(timeInSecProvider) %
                                    ref.watch(secPercentProvider) <
                                1
                            ? {
                                psCount += ps,

                                /// 59/60までインジケーターが進行し、1になるとインジケーターが0になる
                                psCount < 1.0
                                    ? ref
                                        .watch(percentProvider.notifier)
                                        .state += ps
                                    : {
                                        ref
                                            .watch(percentProvider.notifier)
                                            .state = 0.0,
                                        psCount = 0,
                                      }
                              }
                            : null,
                      }
                    : {
                        ref.watch(percentProvider.notifier).state = 0.0,
                        ref.watch(timeInSecProvider.notifier).state = 60,
                        timer.cancel(),
                      },
              }
            : null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final percent = ref.watch(percentProvider);
    final timeInSec = ref.watch(timeInSecProvider);

    final int min = timeInSec ~/ 60;
    final int sec = timeInSec - (min * 60);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.butt,
              percent: percent,
              animation: true,
              animateFromLastPercent: true,
              radius: 120.0,
              lineWidth: 8.0,
              progressColor: Theme.of(context).colorScheme.primary,
              center: Text(
                "$min : $sec",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () =>
                      ref.watch(timerProvider.notifier).state.isActive
                          ? ref.watch(timerProvider.notifier).state.cancel()
                          : null,
                  child: const Text("stop")),
              ElevatedButton(
                  onPressed: () => _startTimer(ref),
                  child: const Text("start")),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
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
                                  margin: const EdgeInsets.all(16.0),
                                  child: TextButton(
                                    onPressed: () => {},
                                    child: const Text("とりあえず集中"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  color: Colors.grey.shade100,
                                  margin: const EdgeInsets.all(16.0),
                                  child: TextButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      SizeRoute(
                                        page: GestureDetector(
                                          onTap: () => Navigator.popUntil(
                                              context,
                                              (route) => route.isFirst),
                                          child: const Center(
                                            child: AddTimerScreen(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: const Text("集中する仕事を決める"),
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
          // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          mini: true,
          child: const Icon(
            Icons.add_alarm,
          )),
    );
  }
}

class SizeRoute extends PageRouteBuilder {
  final Widget page;
  SizeRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Align(
              child: SizeTransition(sizeFactor: animation, child: child),
            );
          },
        );
}
