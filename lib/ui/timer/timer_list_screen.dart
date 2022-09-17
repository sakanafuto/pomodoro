import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerListScreen extends HookConsumerWidget {
  TimerListScreen({Key? key});

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
      color: Theme.of(context).colorScheme.background,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: ListTile(
            leading: IconButton(
              icon: const Icon(Icons.local_offer),
              onPressed: () {},
            ),
            dense: true,
            title: Text("title"),
            subtitle: Text("subtitle"),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            onTap: () => {}
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
