// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_picker/flutter_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/ui/home/home_screen.dart';
import 'package:pomodoro/ui/pomo/pomo_view_model.dart';

class FloatingActionButtonScreen extends ConsumerWidget {
  const FloatingActionButtonScreen({super.key});

  Icon switchIcon(WidgetRef ref) {
    switch (ref.watch(timerProvider.notifier).state) {
      case TimerState.working:
        return const Icon(Icons.pause);
      case TimerState.pausing:
        return const Icon(Icons.play_arrow);
      case TimerState.stopping:
        return const Icon(Icons.play_arrow);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pomoViewModelProvider);
    final totalTimeState = ref.watch(timeInSecProvider.notifier);
    final timerState = ref.watch(timerProvider.notifier);

    Future<dynamic> switchFAB() {
      switch (ref.watch(timerProvider.notifier).state) {
        // タイマーが動いているときは終了もしくは一時停止できる。
        case TimerState.working:
          return Navigator.push<dynamic>(
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
                                onPressed: () {
                                  ref
                                      .read(pomoProvider.notifier)
                                      .state
                                      .cancel();
                                  ref
                                      .read(timeInSecProvider.state)
                                      .update((state) => 25 * 60);
                                  timerState
                                      .update((state) => TimerState.stopping);
                                  Navigator.pop(context);
                                },
                                child: const Text('ポモを終了する'),
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
                                onPressed: () {
                                  ref
                                      .read(pomoProvider.notifier)
                                      .state
                                      .cancel();
                                  timerState
                                      .update((state) => TimerState.pausing);
                                  Navigator.pop(context);
                                },
                                child: const Text('一時停止'),
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
          );
        // タイマーが一時停止中のときは終了もしくは再開ができる。
        case TimerState.pausing:
          return Navigator.push<dynamic>(
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
                                onPressed: () {
                                  ref
                                      .read(pomoProvider.notifier)
                                      .state
                                      .cancel();
                                  ref
                                      .read(timeInSecProvider.state)
                                      .update((state) => 25 * 60);
                                  timerState
                                      .update((state) => TimerState.stopping);
                                  Navigator.pop(context);
                                },
                                child: const Text('ポモを終了する'),
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
                                onPressed: () {
                                  viewModel.startPomo(
                                    totalTimeState.state,
                                    ref,
                                  );
                                  timerState
                                      .update((state) => TimerState.working);
                                  Navigator.pop(context);
                                },
                                child: const Text('再開'),
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
          );
        // タイマーが終了しているときは新しく始めることができる。
        case TimerState.stopping:
          return Navigator.push<dynamic>(
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
                                child: const Text('趣味をどれくらい楽しむ？'),
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
                                onPressed: () async {
                                  await Picker(
                                    adapter: DateTimePickerAdapter(
                                      type: PickerDateTimeType.kHMS,
                                      value: DateTime(0, 0, 0, 25),
                                      customColumnType: [3, 4],
                                    ),
                                    title: const Text('仕事で何分集中する？'),
                                    onConfirm: (Picker picker, List<int> time) {
                                      final totalSecTime =
                                          (time[0] * 60 + time[1]) * 60;
                                      totalTimeState.state = totalSecTime;

                                      /// TODO: 一時から再開後にどうstartPomoするか。
                                      viewModel.startPomo(
                                        totalTimeState.state,
                                        ref,
                                      );

                                      Navigator.pop(context);
                                    },
                                  ).showModal<dynamic>(context);
                                },
                                child: const Text('しごと'),
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
          );
      }
    }

    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: switchFAB,
      child: switchIcon(ref),
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
