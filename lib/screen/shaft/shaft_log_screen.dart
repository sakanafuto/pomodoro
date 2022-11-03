// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/model/shaft/shaft.dart';

class ShaftLogScreen extends HookConsumerWidget {
  const ShaftLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Center(
        child: TextButton(
          child: Text(
            'Simple Pomo',
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          onPressed: () async {
            final box = await Hive.openBox<Shaft>('shaftsBox');

            final sampleInstance = box.get('work');

            const sampleInt = 30;
            sampleInstance!.totalTime += sampleInt;

            await box.put('work', sampleInstance);

            debugPrint('${box.get('work')?.type}');
            debugPrint(
              'Total: ${box.get('work')?.totalTime.toString()}',
            );
            debugPrint('Total: ${box.get('work')?.date.toString()}');
          },
        ),
      ),
      drawer: const DrawerScreen(),
    );
  }
}
