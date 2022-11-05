// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingStateProvider =
    ChangeNotifierProvider((ref) => LoadingStateViewModel());

class LoadingStateViewModel extends ChangeNotifier {
  bool isLoading = false;

  // Future<dynamic> whileLoading(Future<dynamic> Function() future) {
  //   return Future.microtask(toLoading)
  //       .then<dynamic>((_) => future())
  //       .whenComplete(toIdle);
  // }

  // // void toLoading() {
  // //   if (isLoading) {
  // //     return;
  // //   }
  // //   isLoading = true;
  // //   notifyListeners();
  // // }

  // // void toIdle() {
  // //   if (!isLoading) {
  // //     return;
  // //   }
  // //   isLoading = false;
  // //   notifyListeners();
  // // }

  Widget createProgressIndicator() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: Colors.green,
      ),
    );
  }
}
