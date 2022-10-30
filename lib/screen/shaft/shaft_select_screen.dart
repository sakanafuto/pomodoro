// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/app_bar_screen.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/shaft_provider.dart';

class ShaftSelectScreen extends HookConsumerWidget {
  const ShaftSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShaft = ref.watch(shaftSelectorProvider);

    return Scaffold(
      appBar: const AppBarScreen(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          RadioListTile<ShaftState>(
            value: ShaftState.work,
            groupValue: currentShaft as ShaftState?,
            onChanged: (ShaftState? newShaft) {
              ref
                  .read(shaftSelectorProvider.notifier)
                  .change(newShaft ??= ShaftState.work);
              ref
                  .read(shaftStateProvider.notifier)
                  .update((state) => ShaftState.work);
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            title: Text(ShaftState.work.name),
            secondary: const Icon(Icons.work),
          ),
          RadioListTile<ShaftState>(
            value: ShaftState.hoby,
            groupValue: currentShaft,
            onChanged: (ShaftState? newShaft) {
              ref
                  .read(shaftSelectorProvider.notifier)
                  .change(newShaft ??= ShaftState.hoby);
              ref
                  .read(shaftStateProvider.notifier)
                  .update((state) => ShaftState.hoby);
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            title: Text(ShaftState.hoby.name),
            secondary: const Icon(Icons.design_services),
          ),
          RadioListTile<ShaftState>(
            value: ShaftState.rest,
            groupValue: currentShaft,
            onChanged: (ShaftState? newShaft) {
              ref
                  .read(shaftSelectorProvider.notifier)
                  .change(newShaft ??= ShaftState.rest);
              ref
                  .read(shaftStateProvider.notifier)
                  .update((state) => ShaftState.rest);
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
            title: Text(ShaftState.rest.name),
            secondary: const Icon(Icons.mood),
          ),
        ],
      ),
    );
  }
}
