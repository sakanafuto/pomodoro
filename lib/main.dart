// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/theme/app_theme.dart';
import 'package:pomodoro/ui/timer/timer_view_model.dart';
import 'ui/root_screen.dart';

void main() async {
  // await Hive.initFlutter();
  // Hive.registerAdapter(TimerAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(timerViewModelProvider);
    // useEffect(
    //   () {
    //     viewModel.load(ref);
    //     return null;
    //   },
    //   const [],
    // );

    return MaterialApp(
      theme: AppThemeData.mainThemeData,
      title: 'Simple Pomodoro',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => RootScreen(),
      },
    );
  }
}
