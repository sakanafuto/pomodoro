import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/ui/timer/add_timer_screen.dart';

final timerProvider = StateProvider<DateTime>((ref) => DateTime.utc(0, 0, 0));

class HomeScreen extends HookConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  late Timer _timer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting('ja');
    final time = ref.watch(timerProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              DateFormat.Hms('ja').format(time),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => _timer.isActive ? _timer.cancel() : null,
                  child: const Text("stop")),
              ElevatedButton(
                  onPressed: () {
                    _timer = Timer.periodic(
                      const Duration(seconds: 1),
                      (Timer timer) {
                        ref.watch(timerProvider.notifier).update(
                              (state) => state.add(
                                const Duration(seconds: 1),
                              ),
                            );
                      },
                    );
                  },
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
                                    child: Center(
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
