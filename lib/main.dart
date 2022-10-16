// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/app_bar_screen.dart';
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/constant/colors.dart';
import 'package:pomodoro/model/shaft/shaft.dart';
import 'package:pomodoro/screen/pomo/pomo_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ShaftAdapter());
  await Hive.openBox<Shaft>('shaftsBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: pomoTheme(workColorScheme),
      title: 'Simple Pomodoro',
      home: Scaffold(
        appBar: const AppBarScreen(),
        drawer: const DrawerScreen(),
        body: PomoScreen(),
      ),
    );
  }
}
