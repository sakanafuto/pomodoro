// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';

class ShaftLog extends HookConsumerWidget {
  const ShaftLog({super.key});

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
      drawer: const DrawerScreen(),
    );
  }
}
