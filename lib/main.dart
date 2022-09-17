import 'package:flutter/material.dart';
import 'package:pomodoro/theme/app_theme.dart';
import 'package:pomodoro/ui/component/bottom_navigation_bar_view.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.mainThemeData,
      title: 'GreedApp',
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBarView(),
      ),
    );
  }
}
