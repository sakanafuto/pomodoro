// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/constant/colors.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/screen/loading_state_view_model.dart';

class ShaftLogScreen extends HookConsumerWidget {
  const ShaftLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pomoViewModel = ref.watch(pomoViewModelProvider);
    final loading = ref.watch(loadingStateProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.popUntil(
              context,
              (Route<dynamic> route) => route.isFirst,
            ),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Hive から呼び出したログの値が入る。
          FutureBuilder<String>(
            future: pomoViewModel.showLog(ShaftState.work),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  Center(
                    child: Text(
                      '仕事に集中した時間『${snapshot.data!}』分。',
                      style: TextStyle(
                        fontSize: 40,
                        color: pomoTheme(workColorScheme).primaryColor,
                      ),
                    ),
                  ),
                ];
              } else {
                children = <Widget>[loading.createProgressIndicator()];
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
          // Hive から呼び出したログの値が入る。
          FutureBuilder<String>(
            future: pomoViewModel.showLog(ShaftState.hoby),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  Center(
                    child: Text(
                      '趣味に集中した時間『${snapshot.data!}』分。',
                      style: TextStyle(
                        fontSize: 40,
                        color: pomoTheme(workColorScheme).primaryColor,
                      ),
                    ),
                  ),
                ];
              } else {
                children = <Widget>[loading.createProgressIndicator()];
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
          // Hive から呼び出したログの値が入る。
          FutureBuilder<String>(
            future: pomoViewModel.showLog(ShaftState.rest),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  Center(
                    child: Text(
                      '休息に集中した時間『${snapshot.data!}』分。',
                      style: TextStyle(
                        fontSize: 40,
                        color: pomoTheme(workColorScheme).primaryColor,
                      ),
                    ),
                  ),
                ];
              } else {
                children = <Widget>[loading.createProgressIndicator()];
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ],
      ),
      drawer: const DrawerScreen(),
    );
  }
}
