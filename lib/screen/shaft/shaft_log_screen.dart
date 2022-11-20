// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/screen/loading_state_view_model.dart';

// TODO: 分数のテキストの色が変わらない！

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
        title: const Text('集中した時間'),
      ),
      drawer: const DrawerScreen(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Gap(8),
          // Hive から呼び出したログの値が入る。
          FutureBuilder<String>(
            future: pomoViewModel.showLog(ShaftState.work),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '仕事　',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: snapshot.data!,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(text: '　分'),
                        ],
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
                    child: RichText(
                      text: TextSpan(
                        text: '趣味　',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: snapshot.data!,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(text: '　分'),
                        ],
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
                    child: RichText(
                      text: TextSpan(
                        text: '休息　',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: snapshot.data!,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const TextSpan(text: '　分'),
                        ],
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

          const Gap(32),
        ],
      ),
    );
  }
}
