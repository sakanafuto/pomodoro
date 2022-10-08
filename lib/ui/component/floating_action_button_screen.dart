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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pomoViewModelProvider);
    final timeInSec = ref.watch(timeInSecProvider);

    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: !ref.watch(pomoProvider.notifier).state.isActive
          ? () => Navigator.push<dynamic>(
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
                                    onPressed: () async {
                                      await Picker(
                                        adapter: DateTimePickerAdapter(
                                          type: PickerDateTimeType.kHMS,
                                          value: DateTime(0, 0, 0, 25),
                                          customColumnType: [3, 4],
                                        ),
                                        title: const Text('何分集中する？'),
                                        onConfirm:
                                            (Picker picker, List<int> time) {
                                          final totalSecTime =
                                              (time[0] * 60 + time[1]) * 60;
                                          ref
                                              .read(timeInSecProvider.notifier)
                                              .state = totalSecTime;

                                          /// TODO: 一時から再開後にどうstartPomoするか。
                                          if (!ref
                                              .watch(pomoProvider.notifier)
                                              .state
                                              .isActive) {
                                            viewModel.startPomo(timeInSec, ref);
                                          }

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
              )
          : () => ref.read(pomoProvider.notifier).state.cancel(),
      child: !ref.watch(pomoProvider.notifier).state.isActive
          ? const Icon(Icons.play_arrow)
          : const Icon(Icons.pause),
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
