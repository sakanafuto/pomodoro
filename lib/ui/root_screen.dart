// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/ui/component/app_bar_screen.dart';
import 'package:pomodoro/ui/component/drawer_screen.dart';
import 'home/home_screen.dart';

class RootScreen extends HookConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarScreen(),
      drawer: const DrawerScreen(),
      body: HomeScreen(),
    );
  }
}
