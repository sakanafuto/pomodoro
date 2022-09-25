// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/theme/app_theme.dart';
import 'ui/root_screen.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.mainThemeData,
      title: 'GreedApp',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => RootScreen(),
      },
    );
  }
}
