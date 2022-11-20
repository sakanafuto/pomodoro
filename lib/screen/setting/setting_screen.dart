// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:pomodoro/component/app_bar_screen.dart';
import 'package:pomodoro/component/drawer_screen.dart';
import 'package:pomodoro/screen/setting/reset_screen.dart';

// Project imports:

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Widget _arrow() {
    return const Icon(Icons.arrow_forward_ios, size: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPopScreen(),
      drawer: const DrawerScreen(),
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
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Others',
                        style: TextStyle(
                          // fontFamily: 'NotoSansJP',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ),
                    const Gap(10),
                    ItemCard(
                      screen: const SizedBox(),
                      title: 'Settings Item 02',
                      rightWidget: _arrow(),
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
                    const ItemCard(
                      screen: ResetScreen(),
                      title: '追跡のリセット',
                      textColor: Colors.red,
                    ),
                    const ItemCard(
                      screen: SizedBox(),
                      title: 'version',
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
                    const Gap(200),
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

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    this.color,
    this.rightWidget,
    this.textColor,
    required this.screen,
  });

  final Color? color;
  final Color? textColor;
  final String title;
  final Widget? rightWidget;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60,
        color: color,
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
            Container(
              padding: const EdgeInsets.only(right: 24),
              child: rightWidget,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push<dynamic>(
          MaterialPageRoute<Widget>(
            builder: (context) => screen,
          ),
        );
      },
    );
  }
}
