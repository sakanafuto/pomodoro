// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// TODO: leading と actions の有無をを引数で渡して条件分岐したい。

class AppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarScreen({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: title != null ? Text(title!) : const Text(''),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class AppBarPopScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPopScreen({super.key, this.title, required this.hasBackButton});

  final String? title;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: hasBackButton,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: title != null ? Text(title!) : const Text(''),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => Navigator.popUntil(
            context,
            (Route<dynamic> route) => route.isFirst,
          ),
          icon: const Icon(Icons.close),
        ),
        const Gap(8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
