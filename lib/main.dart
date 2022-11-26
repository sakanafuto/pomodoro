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
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/shaft_provider.dart';
import 'package:pomodoro/screen/pomo/pomo_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(ShaftAdapter())
    ..registerAdapter(ShaftStateAdapter());
  await Hive.openBox<Shaft>('shaftsBox');
  await Hive.openBox<ShaftState>('shaftStatesBox');
  await _setupTimeZone();
  runApp(const ProviderScope(child: MyApp()));
}

// タイムゾーンを設定する
Future<void> _setupTimeZone() async {
  tz.initializeTimeZones();
  final tokyo = tz.getLocation('Asia/Tokyo');
  tz.setLocalLocation(tokyo);
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shaftMode = ref.watch(shaftViewModelProvider);

    return MaterialApp(
      theme: shaftMode == ShaftState.work
          ? pomoTheme(workColorScheme)
          : shaftMode == ShaftState.hoby
              ? pomoTheme(hobyColorScheme)
              : pomoTheme(restColorScheme),
      title: 'Simple Pomodoro',
      home: const Scaffold(
        appBar: AppBarScreen(),
        drawer: DrawerScreen(),
        body: PomoScreen(),
      ),
    );
  }
}
