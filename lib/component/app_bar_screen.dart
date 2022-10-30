// Flutter imports:
import 'package:flutter/material.dart';

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
