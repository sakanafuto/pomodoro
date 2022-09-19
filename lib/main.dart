import 'package:flutter/material.dart';
import 'package:pomodoro/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'ui/root_screen.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.mainThemeData,
      title: 'GreedApp',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => RootScreen(),
      }
    );
  }
}
