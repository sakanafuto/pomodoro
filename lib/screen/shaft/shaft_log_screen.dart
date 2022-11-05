// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/provider/pomo_provider.dart';
import 'package:pomodoro/screen/loading_state_view_model.dart';

class ShaftLogScreen extends HookConsumerWidget {
  const ShaftLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pomoViewModel = ref.watch(pomoViewModelProvider);
    final loading = ref.watch(loadingStateProvider);

    final workLog = pomoViewModel.showLog();

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
      body: FutureBuilder<String>(
        future: workLog,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = <Widget>[
              Center(
                child: Text(
                  snapshot.data!,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primaryContainer,
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
      drawer: const DrawerScreen(),
    );
  }
}
