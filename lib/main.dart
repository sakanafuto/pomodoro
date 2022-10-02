// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/model/pomo/pomo.dart';
import 'package:pomodoro/theme/app_theme.dart';
import 'package:pomodoro/ui/pomo/pomo_view_model.dart';
import 'ui/root_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PomoAdapter());
  await Hive.openBox<Pomo>('pomosBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pomoViewModelProvider);
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
