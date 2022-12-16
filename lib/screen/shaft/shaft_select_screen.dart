// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/shaft_provider.dart';

// TODO: スタイルを統一する。

class ShaftSelectScreen extends HookConsumerWidget {
  const ShaftSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShaft = ref.watch(shaftViewModelProvider);

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
        title: const Text('軸をえらぶ'),
      ),
      drawer: const DrawerScreen(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          RadioListTile<ShaftState>(
            value: ShaftState.work,
            groupValue: currentShaft,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (ShaftState? newShaft) {
              ref
                  .read(shaftViewModelProvider.notifier)
                  .change(newShaft ??= ShaftState.work);

              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            title: const Text('仕事'),
          ),
          RadioListTile<ShaftState>(
            value: ShaftState.hoby,
            groupValue: currentShaft,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (ShaftState? newShaft) {
              /// TODO: View は値を表示するに留める。viewModel.change で、viewModel もしくは useCase の StateNotifier で処理を行う。
              ref
                  .read(shaftViewModelProvider.notifier)
                  .change(newShaft ??= ShaftState.hoby);

              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            title: const Text('趣味'),
          ),
          RadioListTile<ShaftState>(
            value: ShaftState.rest,
            groupValue: currentShaft,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (ShaftState? newShaft) {
              ref
                  .read(shaftViewModelProvider.notifier)
                  .change(newShaft ??= ShaftState.rest);

              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            title: const Text('休息'),
          ),
        ],
      ),
    );
  }
}
