import 'package:flutter/material.dart';
import 'package:pomodoro/theme/app_theme.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/ui/component/bottom_navigation_bar_view.dart';
import 'package:pomodoro/ui/home/home_screen.dart';
void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.mainThemeData,
      title: 'GreedApp',
      home: Scaffold(
        body: const HomeScreen(),
        bottomNavigationBar: BottomNavigationBarView(),
      ),
    );
  }
}
