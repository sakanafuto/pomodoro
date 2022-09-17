import 'package:flutter/material.dart';
import 'package:pomodoro/ui/home/home_screen.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final appTabTypeProvider = StateProvider<AppTabType>((ref) => AppTabType.home);

enum AppTabType {
  no,
  home,
  no2,
}

class BottomNavigationBarView extends ConsumerWidget {
  BottomNavigationBarView({Key? key}) : super(key: key);

  final _pages = [
    const Text("no"),
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
          title: Text("Taste that's Simple Pomodoro"),
        ),
        body: _pages[ref.watch(appTabTypeProvider).index],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.no_accounts),
              label: "null",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.no_accounts),
              label: "null",
            ),
          ],
          currentIndex: ref.watch(appTabTypeProvider).index,
          onTap: (selectIndex) {
            ref.watch(appTabTypeProvider.notifier).state =
                AppTabType.values[selectIndex];
          },
        ),
        drawer: _drawer(),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: Center(
        child: Text("Simple Drawer"),
      ),
    );
  }
}
