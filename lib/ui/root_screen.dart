// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/ui/pomo/pomo_list_screen.dart';
import 'home/home_screen.dart';

final currentPageIndexProvider = StateProvider<int>((ref) => 0);
final pageViewControllerProvider =
    StateProvider<PageController>((ref) => PageController());

class RootScreen extends HookConsumerWidget {
  RootScreen({super.key});

  final _pages = [
    PomoListScreen(),
    HomeScreen(),
    const Text('no2'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(currentPageIndexProvider);
    final pageViewController = ref.watch(pageViewControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        title: const Text("🥺 Taste that's Simple Pomodoro"),
      ),
      drawer: _drawer(context),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          ref.read(pageViewControllerProvider.notifier).state.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              );
        },
        selectedIndex: currentPageIndex,
        surfaceTintColor: Theme.of(context).colorScheme.secondaryContainer,
        animationDuration: const Duration(milliseconds: 500),
        elevation: 10,
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.view_list),
            label: 'list',
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_empty_outlined),
            label: 'focus',
          ),
          NavigationDestination(
            icon: Icon(Icons.today),
            label: 'track',
          ),
        ],
      ),
      body: PageView(
        controller: pageViewController,
        children: _pages,
        onPageChanged: (index) {
          ref.read(currentPageIndexProvider.notifier).state = index;
        },
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      child: const Center(
        child: Text('Simple Drawer'),
      ),
    );
  }
}
