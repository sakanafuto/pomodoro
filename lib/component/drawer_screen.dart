// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:pomodoro/constant/colors.dart';
import 'package:pomodoro/model/shaft/shaft.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/screen/setting/setting_screen.dart';
import 'package:pomodoro/screen/shaft/shaft_log.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pomoLog = Shaft(
      type: ShaftState.work.toString(),
      totalTime: 20,
      date: DateTime.now(),
    );
    return Drawer(
      width: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextButton(
            child: const Text('Simple Drawer'),
            onPressed: () async {
              final box = await Hive.openBox<Shaft>('shaftsBox');
              await box.put('work', pomoLog);

              debugPrint('Total: ${box.get('work')?.type}');
              debugPrint('Total: ${box.get('work')?.totalTime.toString()}');
              debugPrint('Total: ${box.get('work')?.date.toString()}');
            },
          ),
          const Gap(16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push<dynamic>(
                    MaterialPageRoute<Widget>(
                      builder: (context) => const ShaftLog(),
                    ),
                  );
                },
                child: const Text(
                  '#追跡',
                  style: TextStyle(
                    color: subTextColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(32),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push<dynamic>(
                MaterialPageRoute<Widget>(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
