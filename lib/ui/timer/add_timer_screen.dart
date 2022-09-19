import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTimerScreen extends HookConsumerWidget {
  const AddTimerScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
        child: Center(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  height: 560,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1.0,
                        blurRadius: 10.0,
                        offset: Offset(10, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(),
                      const Text("999"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
