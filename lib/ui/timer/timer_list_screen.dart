// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/boxes.dart';
import 'package:pomodoro/data/model/timer/timer.dart';
import 'package:pomodoro/ui/timer/timer_view_model.dart';

final showFormProvider = StateProvider<bool>((ref) => false);

class TimerListScreen extends HookConsumerWidget {
  TimerListScreen({super.key});

  final _nameController = TextEditingController();
  final _minuteController = TextEditingController();
  final _captionController = TextEditingController();

  final _minuteFocusNode = FocusNode();
  final _captionFocusNode = FocusNode();

  final sliderAmountProvider = StateProvider<int>((ref) => 25);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(timerViewModelProvider);
    final showForm = ref.watch(showFormProvider);
    final sliderAmount = ref.watch(sliderAmountProvider);
    return Scaffold(
      body: showForm
          ? Stack(
              children: <Widget>[
                _hiveBuilder(viewModel),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        height: 100,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          children: [
                            TextField(
                              controller: _minuteController,
                              decoration: const InputDecoration(
                                label: Text('分数'),
                                hintText: '集中する時間を入力',
                                prefixIcon: Icon(Icons.timer),
                                contentPadding: EdgeInsets.only(top: 8),
                                isDense: true,
                              ),
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_captionFocusNode);
                              },
                            ),
                            Expanded(
                              child: Slider(
                                label: '${sliderAmount.toString()} 分',
                                value: sliderAmount.toDouble(),
                                min: 1,
                                max: 60,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                inactiveColor:
                                    Theme.of(context).colorScheme.secondary,
                                divisions: 60,
                                onChanged: (value) {
                                  ref
                                      .read(sliderAmountProvider.notifier)
                                      .state = value.ceil();
                                  _minuteController.text =
                                      sliderAmount.toString();
                                },
                                onChangeStart: (value) {
                                  ref
                                      .read(sliderAmountProvider.notifier)
                                      .state = value.ceil();
                                  _minuteController.text =
                                      sliderAmount.toString();
                                },
                                onChangeEnd: (value) {
                                  ref
                                      .read(sliderAmountProvider.notifier)
                                      .state = value.ceil();
                                  _minuteController.text =
                                      sliderAmount.toString();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 80,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: TextField(
                          autofocus: true,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            label: Text('名前'),
                            hintText: 'タイマー名を入力',
                            prefixIcon: Icon(Icons.badge),
                            contentPadding: EdgeInsets.only(top: 8),
                            isDense: true,
                          ),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_minuteFocusNode);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 80,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: TextField(
                          controller: _captionController,
                          decoration: const InputDecoration(
                            hintText: '説明を入力',
                            prefixIcon: Icon(Icons.article),
                            contentPadding: EdgeInsets.only(top: 4),
                            isDense: true,
                          ),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_minuteFocusNode);
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          viewModel.add(
                            name: _nameController.text,
                            minute: int.parse(_minuteController.text),
                            caption: _captionController.text,
                          ),
                          _nameController.clear(),
                          _minuteController.clear(),
                          _captionController.clear(),
                        },
                        child: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : _hiveBuilder(viewModel),
      floatingActionButton: !showForm
          ? FloatingActionButton(
              onPressed: () =>
                  ref.read(showFormProvider.state).update((state) => !state),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _hiveBuilder(TimerViewModel viewModel) {
    return ValueListenableBuilder<Box<Timer>>(
      valueListenable: Boxes.getTimers().listenable(),
      builder: (context, box, _) {
        final timers = box.values.toList().cast<Timer>();
        return _buildContent(context, timers, viewModel);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Timer> timers,
    TimerViewModel viewModel,
  ) {
    if (timers.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1000,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: timers.length,
                itemBuilder: (BuildContext context, int index) {
                  final timer = timers[index];
                  return buildTimer(context, timer, viewModel);
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildTimer(
    BuildContext context,
    Timer timer,
    TimerViewModel viewModel,
  ) {
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
          title: Text(timer.name),
          subtitle: const Text('subtitle'),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => viewModel.delete(timer: timer),
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
