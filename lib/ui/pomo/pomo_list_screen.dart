// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/boxes.dart';
import 'package:pomodoro/data/model/pomo/pomo.dart';
import 'package:pomodoro/ui/home/home_screen.dart';
import 'package:pomodoro/ui/pomo/pomo_view_model.dart';

final showFormProvider = StateProvider<bool>((ref) => false);

class PomoListScreen extends HookConsumerWidget with WidgetsBindingObserver {
  PomoListScreen({super.key});

  final _nameController = TextEditingController();
  final _minuteController = TextEditingController();
  final _captionController = TextEditingController();

  final _minuteFocusNode = FocusNode();
  final _captionFocusNode = FocusNode();

  final sliderAmountProvider = StateProvider<int>((ref) => 25);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(pomoViewModelProvider);
    final showForm = ref.watch(showFormProvider);
    final sliderAmount = ref.watch(sliderAmountProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addObserver(this);
        ref.read(pomoProvider.notifier).state.cancel();
        return null;
      },
      const [],
    );

    return Scaffold(
      body: showForm
          ? Stack(
              children: <Widget>[
                _hiveBuilder(ref, viewModel),
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
          : _hiveBuilder(ref, viewModel),
      floatingActionButton: !showForm
          ? FloatingActionButton(
              onPressed: () =>
                  ref.read(showFormProvider.state).update((state) => !state),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _hiveBuilder(WidgetRef ref, PomoViewModel viewModel) {
    return ValueListenableBuilder<Box<Pomo>>(
      valueListenable: Boxes.getPomos().listenable(),
      builder: (context, box, _) {
        final pomos = box.values.toList().cast<Pomo>();
        return _buildContent(context, ref, pomos, viewModel);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<Pomo> pomos,
    PomoViewModel viewModel,
  ) {
    if (pomos.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1000,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pomos.length,
                itemBuilder: (BuildContext context, int index) {
                  final pomo = pomos[index];
                  return buildPomo(context, ref, pomo, viewModel);
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

  Widget buildPomo(
    BuildContext context,
    WidgetRef ref,
    Pomo pomo,
    PomoViewModel viewModel,
  ) {
    final minute = pomo.minute;
    return Card(
      // color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      // child: GestureDetector(
      // onTap: () {
      //   debugPrint('k');
      // },
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.play_circle),
          onPressed: () {
            // ref.read(timeInSecProvider.notifier).state = minute;
            viewModel.startPomo(pomo.minute, ref);
          },
        ),
        dense: true,
        title: Text(pomo.name),
        subtitle: Text(pomo.minute.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => viewModel.delete(pomo: pomo),
        ),
        onTap: () => <Widget>{},
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PomoDetailScreen(),
        //   ),
        // ),
        // ),
      ),
    );
  }
}
