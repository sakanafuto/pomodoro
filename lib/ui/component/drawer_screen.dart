// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pomodoro/ui/settings/settings_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('Simple Drawer'),
          IconButton(
            onPressed: () => Navigator.of(context).push<dynamic>(
              MaterialPageRoute<Widget>(
                builder: (context) => const SettingScreen(),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
