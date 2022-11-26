// Flutter imports:
// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:pomodoro/component/app_bar_screen.dart';
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/provider/shaft_provider.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'ログをリセットする',
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
                      title: '仕事',
                      shaft: ShaftState.work,
                    ),
                    const ItemCard(
                      screen: SizedBox(),
                      title: '趣味',
                      shaft: ShaftState.hoby,
                    ),
                    const ItemCard(
                      screen: SizedBox(),
                      title: '休息',
                      shaft: ShaftState.rest,
                    ),
                    const ItemCard(
                      screen: SizedBox(),
                      title: 'すべてのログをリセット',
                    ),
                  ],
                ),
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
    this.textColor,
    required this.screen,
    this.shaft,
  });

  final Color? textColor;
  final String title;
  final Widget screen;
  final ShaftState? shaft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 24),
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
            Container(padding: const EdgeInsets.only(right: 24))
          ],
        ),
      ),
      onTap: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: '本当にリセットしてもよろしいですか？',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            shaft != null
                ? ref
                    .read(shaftViewModelProvider.notifier)
                    .resetShaftLog(shaft!)
                : ref.read(shaftViewModelProvider.notifier).resetAllShaftLog();
            Navigator.popUntil(
              context,
              (Route<dynamic> route) => route.isFirst,
            );
          },
        ).show();
      },
    );
  }
}
