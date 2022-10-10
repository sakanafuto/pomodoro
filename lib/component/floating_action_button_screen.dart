// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_picker/flutter_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/size_route.dart';
import 'package:pomodoro/constant/pomo_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/screen/pomo/pomo_screen.dart';

class FloatingActionButtonScreen extends ConsumerWidget {
  const FloatingActionButtonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pomoViewModelProvider);
    final totalTime = ref.watch(timeInSecProvider.notifier).state;
    final lastTime = ref.watch(lastTimeProvider.notifier).state;
    final icon = ref.watch<Widget>(iconProvider);

    // ドラムロールで分数選択
    Future<void> timePick() async {
      await Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kHMS,
          value: DateTime(2000, 1, 1, 0, lastTime),
          customColumnType: [3, 4],
        ),
        title: const Text('仕事で何分集中する？'),
        onConfirm: (Picker picker, List<int> time) {
          ref.read(lastTimeProvider.notifier).state =
              (time[0] * 60 + time[1]) * 60;
          ref
              .read(timeInSecProvider.state)
              .update((state) => ref.watch(lastTimeProvider.notifier).state);

          viewModel.startPomo(
            ref,
            ref.watch(lastTimeProvider.notifier).state,
          );

          Navigator.pop(context);
        },
      ).showModal<dynamic>(context);
    }

    Future<dynamic> switchFAB() {
      switch (ref.watch(timerProvider.notifier).state) {
        // タイマーが動いているときは終了もしくは一時停止できる。
        case PomoState.working:
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
                                      .read(timerProvider.state)
                                      .update((state) => PomoState.stopping);
                                  ref.read(percentProvider.notifier).state =
                                      0.0;
                                  ref.read(timeInSecProvider.notifier).state =
                                      lastTime;
                                  ref.read(iconProvider.state).update(
                                        (dynamic state) =>
                                            const Icon(Icons.play_arrow),
                                      );
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
                                  ref
                                      .read(remainingTimeProvider.notifier)
                                      .state = totalTime.toDouble();
                                  ref
                                      .read(timerProvider.state)
                                      .update((state) => PomoState.pausing);
                                  ref.read(iconProvider.state).update(
                                        (dynamic state) =>
                                            const Icon(Icons.play_arrow),
                                      );
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
        case PomoState.pausing:
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
                                  ref.read(timeInSecProvider.notifier).state =
                                      lastTime;
                                  ref
                                      .read(percentProvider.state)
                                      .update((state) => 0);
                                  ref
                                      .read(timerProvider.state)
                                      .update((state) => PomoState.stopping);
                                  ref.read(iconProvider.state).update(
                                        (dynamic state) =>
                                            const Icon(Icons.play_arrow),
                                      );
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
                                  viewModel.startPomo(ref, lastTime);
                                  ref
                                      .read(timerProvider.state)
                                      .update((state) => PomoState.working);

                                  ref.read(iconProvider.state).update(
                                        (dynamic state) =>
                                            const Icon(Icons.pause),
                                      );
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
        case PomoState.stopping:
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
                          children: <Widget>[
                            Container(
                              color: Colors.grey.shade100,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: timePick,
                                child: const Text('しごと'),
                              ),
                            )
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
      child: icon,
    );
  }
}
