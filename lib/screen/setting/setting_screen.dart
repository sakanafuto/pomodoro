// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pomodoro/component/drawer_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const SizedBox(),
    );
  }
}
