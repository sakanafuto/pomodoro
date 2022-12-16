// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/button.dart';
import 'package:pomodoro/component/size_route.dart';
import 'package:pomodoro/constant/colors.dart';
import 'package:pomodoro/model/pomo/pomo_state.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/provider/shaft_provider.dart';
import 'package:pomodoro/screen/pomo/zen_screen.dart';

class FloatingActionButtonScreen extends ConsumerWidget {
  const FloatingActionButtonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTime = ref.watch(displayTimeProvider);
    final settingTime = ref.watch(settingTimeProvider) ~/ 60;
    final icon = ref.watch(iconProvider);
    final ss = ref.watch(shaftViewModelProvider);

    /// TODO: 長すぎ。ファイルに分けたい。
    Future<dynamic> switchFAB() {
      switch (ref.watch(pomoStateProvider.notifier).state) {
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
                              color: Theme.of(context).colorScheme.background,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () {
                                  ref
                                      .read(remainingTimeProvider.notifier)
                                      .update((state) => currentTime);
                                  ref
                                      .read(pomoViewModelProvider.notifier)
                                      .stopPomo(
                                        context,
                                        ref,
                                        isInterruption: false,
                                      );
                                },
                                child: const Text(
                                  'ポモを終了する',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: Theme.of(context).colorScheme.background,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () => Navigator.push<dynamic>(
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
                                child: const Text(
                                  '禅',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(16),
                            Container(
                              color: Theme.of(context).colorScheme.background,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () => ref
                                    .read(pomoViewModelProvider.notifier)
                                    .pausePomo(
                                      context,
                                      ref,
                                      currentTime,
                                    ),
                                child: const Text(
                                  '一時停止',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
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
                            // TODO: コンポーネント化ほかにも適用する。
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(remainingTimeProvider.notifier)
                                    .update((state) => currentTime);
                                ref
                                    .read(pomoViewModelProvider.notifier)
                                    .stopPomo(
                                      context,
                                      ref,
                                      isInterruption: false,
                                    );
                              },
                              style: pomoElevatedButtonStyle,
                              child: const Text(
                                'ポモを終了する',
                                style: TextStyle(color: textColor),
                              ),
                            ),
                            const Gap(24)
                          ],
                        ),
                        const Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: Theme.of(context).colorScheme.background,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () => ref
                                    .read(pomoViewModelProvider.notifier)
                                    .restartPomo(context, ref),
                                child: const Text(
                                  '再開',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(24),
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
                              color: Theme.of(context).colorScheme.background,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push<dynamic>(
                                    context,
                                    SizeRoute(
                                      page: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          height: 1000,
                                          width: 1000,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          child: SafeArea(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                      margin:
                                                          const EdgeInsets.all(
                                                        16,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                shaftViewModelProvider
                                                                    .notifier,
                                                              )
                                                              .change(
                                                                ShaftState.work,
                                                              );
                                                          Navigator.popUntil(
                                                            context,
                                                            (
                                                              Route<dynamic>
                                                                  route,
                                                            ) =>
                                                                route.isFirst,
                                                          );
                                                          ref
                                                              .read(
                                                                pomoViewModelProvider
                                                                    .notifier,
                                                              )
                                                              .timePick(
                                                                context,
                                                                ref,
                                                                settingTime,
                                                              );
                                                        },
                                                        child: const Text(
                                                          '仕事',
                                                          style: TextStyle(
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                      margin:
                                                          const EdgeInsets.all(
                                                        16,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                shaftViewModelProvider
                                                                    .notifier,
                                                              )
                                                              .change(
                                                                ShaftState.hoby,
                                                              );
                                                          Navigator.popUntil(
                                                            context,
                                                            (
                                                              Route<dynamic>
                                                                  route,
                                                            ) =>
                                                                route.isFirst,
                                                          );
                                                          ref
                                                              .read(
                                                                pomoViewModelProvider
                                                                    .notifier,
                                                              )
                                                              .timePick(
                                                                context,
                                                                ref,
                                                                settingTime,
                                                              );
                                                        },
                                                        child: const Text(
                                                          '趣味',
                                                          style: TextStyle(
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                      margin:
                                                          const EdgeInsets.all(
                                                        16,
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                shaftViewModelProvider
                                                                    .notifier,
                                                              )
                                                              .change(
                                                                ShaftState.rest,
                                                              );
                                                          Navigator.popUntil(
                                                            context,
                                                            (
                                                              Route<dynamic>
                                                                  route,
                                                            ) =>
                                                                route.isFirst,
                                                          );
                                                          ref
                                                              .read(
                                                                pomoViewModelProvider
                                                                    .notifier,
                                                              )
                                                              .timePick(
                                                                context,
                                                                ref,
                                                                settingTime,
                                                              );
                                                        },
                                                        child: const Text(
                                                          '休息',
                                                          style: TextStyle(
                                                            color: textColor,
                                                          ),
                                                        ),
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
                                },
                                child: const Text(
                                  '軸を変更する',
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              color: Theme.of(context).colorScheme.background,
                              margin: const EdgeInsets.all(16),
                              child: TextButton(
                                onPressed: () => ref
                                    .read(pomoViewModelProvider.notifier)
                                    .timePick(
                                      context,
                                      ref,
                                      settingTime,
                                    ),
                                // TODO: RichText
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    text: '',
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            // ignore: cast_nullable_to_non_nullable
                                            ss.displayName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' で集中する',
                                        // style: TextStyle(color: subTextColor),
                                      ),
                                    ],
                                  ),
                                ),
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
      onPressed: switchFAB,
      child: icon,
    );
  }
}
