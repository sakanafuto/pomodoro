// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pomodoro/screen/setting/setting_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('Simple Drawer'),
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
