import 'package:flutter/material.dart';
import 'package:pomodoro/ui/home/home_screen.dart';
import 'package:pomodoro/ui/timer/timer_list_screen.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final appTabTypeProvider =
    StateProvider.autoDispose<AppTabType>((ref) => AppTabType.home);
// final isTabTapProvider = StateProvider<bool>((ref) => false);

enum AppTabType {
  no,
  home,
  no2,
}

class BottomNavigationBarView extends ConsumerWidget {
  BottomNavigationBarView({Key? key}) : super(key: key);

  final _pages = [
    TimerListScreen(),
    const HomeScreen(),
    const Text("no2"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("🥺 Taste that's Simple Pomodoro"),
        ),
        body: _pages[ref.watch(appTabTypeProvider).index],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hourglass_empty_outlined),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: "",
            ),
          ],
          currentIndex: ref.watch(appTabTypeProvider).index,
          onTap: (selectIndex) async {
            ref.watch(timerProvider.notifier).state.cancel();
            // ref.watch(isTabTapProvider.notifier).state = true;
            // await Future.delayed(const Duration(milliseconds: 1500));
            ref.watch(appTabTypeProvider.notifier).state =
                AppTabType.values[selectIndex];
          },
        ),
        drawer: _drawer(context),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Text("Simple Drawer"),
      ),
    );
  }
}
