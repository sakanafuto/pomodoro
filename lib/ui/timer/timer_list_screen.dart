// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

final showFormProvider = StateProvider<bool>((ref) => false);

class TimerListScreen extends HookConsumerWidget {
  TimerListScreen({super.key});

  TextEditingController titleController = TextEditingController();

  Widget _addTimer(WidgetRef ref) {
    ref.read(showFormProvider.state).update((state) => !state);
    return Stack(
      children: const [
        // Container(
        //   color: Colors.amber,
        //   child:
        TextField(),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showForm = ref.watch(showFormProvider);
    return Scaffold(
      body: showForm
          ? Stack(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildTimerList(context),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      maxLength: 10,
                      style: const TextStyle(color: Colors.red),
                      controller: titleController,
                      autofocus: true,
                      onSubmitted: (value) => {
                        debugPrint(value),
                        ref
                            .read(showFormProvider.state)
                            .update((state) => !state),
                      },
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) =>
                  _buildTimerList(context),
            ),
      floatingActionButton: !showForm
          ? FloatingActionButton(
              onPressed: () =>
                  ref.read(showFormProvider.state).update((state) => !state),
              child: const Icon(Icons.add),
            )
          : null,
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
