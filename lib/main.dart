// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/theme/app_theme.dart';
import 'ui/root_screen.dart';

void main() async {
  // await Hive.initFlutter();
  // Hive.registerAdapter(PomoAdapter());
  // await Hive.openBox<Pomo>('pomosBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: AppThemeData.mainThemeData,
      title: 'Simple Pomodoro',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const RootScreen(),
      },
    );
  }
}
