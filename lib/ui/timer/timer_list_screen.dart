// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/ui/timer/timer_view_model.dart';

final showFormProvider = StateProvider<bool>((ref) => false);

class TimerListScreen extends HookConsumerWidget {
  TimerListScreen({super.key});

  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(timerViewModelProvider);
    final showForm = ref.watch(showFormProvider);
    return Scaffold(
      body: showForm
          ? Stack(
              children: <Widget>[
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: 10,
                //   itemBuilder: (BuildContext context, int index) =>
                //       _buildTimerList(context),
                // ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    // height: 100,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: TextField(
                      maxLength: 10,
                      style: const TextStyle(color: Colors.red),
                      controller: titleController,
                      autofocus: true,
                      // onSubmitted: (value) => {
                      //   viewModel.add(titleController.text),
                      //   ref
                      //       .read(showFormProvider.state)
                      //       .update((state) => !state),
                      // },
                    ),
                  ),
                ),
              ],
            )
          // : ValueListenableBuilder<Box<Timer>>(
          //     valueListenable: Boxes.getTimers().listenable(),
          //     builder: (context, box, _) {
          //       final timers = box.values.toList().cast<Timer>();
          //       return _buildContent(timers, timerModel, context);
          //     },
          //   ),
          : null,
      floatingActionButton: !showForm
          ? FloatingActionButton(
              onPressed: () =>
                  ref.read(showFormProvider.state).update((state) => !state),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  // Widget _buildContent(List<Timer> timers, Timer timerModel, BuildContext context) {
  //   return Card(
  //     // color: Theme.of(context).colorScheme.primaryContainer,
  //     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     elevation: 3,
  //     child: InkWell(
  //       onTap: () {},
  //       child: ListTile(
  //         leading: IconButton(
  //           icon: const Icon(Icons.local_offer),
  //           onPressed: () {},
  //         ),
  //         dense: true,
  //         title: const Text('title'),
  //         subtitle: const Text('subtitle'),
  //         trailing: IconButton(
  //           icon: const Icon(Icons.more_vert),
  //           onPressed: () {},
  //         ),
  //         onTap: () => <Widget>{},
  //         // Navigator.of(context).push(
  //         //   MaterialPageRoute(
  //         //     builder: (context) => TimerDetailScreen(),
  //         //   ),
  //         // ),
  //       ),
  //     ),
  //   );
  // }
}
