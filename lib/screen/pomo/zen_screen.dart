// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/provider/pomo_provider.dart';

class ZenScreen extends HookConsumerWidget {
  const ZenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayTime = ref.watch(displayTimeProvider);
    final minute = displayTime ~/ 60;
    final second = displayTime - (minute * 60);

    final minuteDisplay = useState(true);

    return Scaffold(
      body: ColoredBox(
        color: const Color(0xFF000000),
        child: Center(
          child: GestureDetector(
            onTap: () => minuteDisplay.value = !minuteDisplay.value,
            child: minuteDisplay.value
                ? Text(
                    '$minute : $second',
                    style: const TextStyle(
                      color: Color(0xFFFFFFFD),
                      fontSize: 64,
                    ),
                  )
                : Text(
                    displayTime.toString(),
                    style: const TextStyle(
                      color: Color(0xFFFFFFFD),
                      fontSize: 128,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
