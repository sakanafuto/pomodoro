// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerListScreen extends HookConsumerWidget {
  const TimerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) =>
            _buildTimerList(context),
      ),
    );
  }

  Widget _buildTimerList(BuildContext context) {
    return Card(
      // color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: IconButton(
            icon: const Icon(Icons.local_offer),
            onPressed: () {},
          ),
          dense: true,
          title: const Text('title'),
          subtitle: const Text('subtitle'),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          onTap: () => <Widget>{},
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => TimerDetailScreen(),
          //   ),
          // ),
        ),
      ),
    );
  }
}
