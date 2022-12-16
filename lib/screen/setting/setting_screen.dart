// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:pomodoro/component/app_bar_screen.dart';
import 'package:pomodoro/component/pupup/dot.dart';
import 'package:pomodoro/component/pupup/dots_picker.dart';
import 'package:pomodoro/screen/setting/reset_screen.dart';
import 'package:wakelock/wakelock.dart';

// Project imports:

final awakeProvider = StateProvider<bool>((ref) => false);
final dotProvider = StateProvider<String>((ref) => '画面を自動でスリープしないようにします');

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});

  Widget _arrow() {
    return const Icon(Icons.arrow_forward_ios, size: 16);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final awakeStatus = ref.watch(awakeProvider);

    return Scaffold(
      appBar: const AppBarPopScreen(
        title: '設定',
        hasBackButton: false,
      ),
      // drawer: const DrawerScreen(),
      body: Container(
        padding: const EdgeInsets.only(right: 16, bottom: 32, left: 16),
        color: const Color(0xFFf0f0f0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: const Text(
                      'App Settings',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  const Gap(10),
                  const ItemCard(
                    screen: SizedBox(),
                    title: 'Settings Item 01',
                  ),
                  const Gap(40),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: const Text(
                      '一般',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  const Gap(10),
                  ItemCard(
                    title: 'カフェインモード',
                    caption: '画面を自動でスリープしないようにします',
                    rightWidget: FlutterSwitch(
                      width: 40,
                      height: 24,
                      toggleSize: 16,
                      value: awakeStatus,
                      borderRadius: 30,
                      padding: 8,
                      onToggle: (val) async {
                        debugPrint(val.toString());
                        await Wakelock.toggle(enable: val);
                        ref.read(awakeProvider.notifier).update((state) => val);
                      },
                    ),
                  ),
                  ItemCard(
                    screen: const SizedBox(),
                    title: 'Settings Item 03',
                    rightWidget: _arrow(),
                  ),
                  ItemCard(
                    screen: const SizedBox(),
                    title: 'Settings Item 04',
                    rightWidget: _arrow(),
                  ),
                  const ItemCard(
                    screen: SizedBox(),
                    title: 'Settings Item 05',
                  ),
                  const ItemCard(
                    screen: SizedBox(),
                    title: 'Settings Item 06',
                  ),
                  const ItemCard(
                    screen: SizedBox(),
                    title: 'Settings Item 07',
                  ),
                  const Gap(40),
                  const ItemCard(
                    screen: SizedBox(),
                    title: 'Settings Item 08',
                  ),
                  ItemCard(
                    screen: const ResetScreen(),
                    title: '追跡のリセット',
                    textColor: Colors.red,
                    rightWidget: _arrow(),
                    icon: const Icon(Icons.warning),
                  ),
                  const Gap(40),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: const Text(
                      'その他',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ),
                  const Gap(10),
                  ItemCard(
                    screen: const ResetScreen(),
                    title: '情報',
                    rightWidget: _arrow(),
                    icon: const Icon(Icons.info),
                  ),
                  const ItemCard(
                    title: 'バージョン',
                    rightWidget: Center(
                      child: Text(
                        '1.0.0',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends ConsumerWidget {
  const ItemCard({
    super.key,
    required this.title,
    this.caption,
    this.color,
    this.rightWidget,
    this.textColor,
    this.screen,
    this.icon,
  });

  final String title;
  final String? caption;
  final Color? color;
  final Color? textColor;
  final Widget? rightWidget;
  final Widget? screen;
  final Icon? icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dotsList = <Dot>[Dot(ref.watch(dotProvider), Colors.grey)];

    return InkWell(
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xffffffff),
        ),
        child: Row(
          children: <Widget>[
            icon != null
                ? Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: icon,
                  )
                : const Gap(0),
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
            ),
            caption != null
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: DotsPicker(
                      dots: dotsList,
                      onSelected: (id) {
                        ref
                            .read(dotProvider.notifier)
                            .update((state) => caption!);
                      },
                    ),
                  )
                : const Gap(0),
            const Expanded(
              child: Gap(0),
            ),
            Container(
              padding: const EdgeInsets.only(right: 24),
              child: rightWidget,
            )
          ],
        ),
      ),
      onTap: () {
        screen != null
            ? Navigator.of(context).push<dynamic>(
                MaterialPageRoute<Widget>(
                  builder: (context) => screen!,
                ),
              )
            : const Gap(0);
      },
    );
  }
}
