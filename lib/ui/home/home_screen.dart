import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/ui/timer/add_timer_screen.dart';

final percentProvider = StateProvider<double>((ref) => 0);
final timeInMinProvider = StateProvider<int>((ref) => 25);
final timeInSecProvider =
    StateProvider<int>((ref) => ref.watch(timeInMinProvider) * 60);
final secPercentProvider =
    StateProvider<double>((ref) => ref.watch(timeInSecProvider) / 100);

class HomeScreen extends HookConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  late Timer _timer;

  void _startTimer(ref, time, secPercent) {
    // int timeInMinut = 25;
    // int time = timeInMinut * 60;
    // double secPercent = (time / 100);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (time > 0) {
          ref.read(timeInSecProvider.notifier).state--;
          if (time % 60 == 0) {
            ref.read(timeInMinProvider.notifier).state--;
            if (time % secPercent == 0) {
              ref.read(percentProvider.notifier).state += 0.01;
            } else {
              ref.read(percentProvider.notifier).state = 1;
            }
          }
        } else {
          ref.read(percentProvider.notifier).state = 0;
          ref.read(timeInMinProvider.notifier).state = 25;
          timer.cancel();
        }
        //   ref.watch(timerProvider.notifier).update(
        //         (state) => state.add(
        //           const Duration(seconds: 1),
        //         ),
        //       );
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percent = ref.watch(percentProvider);
    final time = ref.watch(timeInSecProvider);
    final secPercent = ref.watch(secPercentProvider);
    initializeDateFormatting('ja');
    // final time = ref.watch(timerProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Expanded(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 250.0,
                lineWidth: 20.0,
                progressColor: Colors.black,
                center: Text(
                  '$time',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 80.0,
                  ),
                ),
              ),
            ),
            // child: Text(
            //   DateFormat.Hms('ja').format(time),
            //   style: Theme.of(context).textTheme.headline2,
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => _timer.isActive ? _timer.cancel() : null,
                  child: const Text("stop")),
              ElevatedButton(
                  onPressed: () => _startTimer(ref, time, secPercent),
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
                                        context, (route) => route.isFirst),
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
        child: const Icon(Icons.add_alarm),
      ),
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
