import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
          )
        ],
      ),
    );
  }
}
