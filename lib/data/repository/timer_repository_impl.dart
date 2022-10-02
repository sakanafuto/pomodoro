// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/data/boxes.dart';
import 'package:pomodoro/data/model/timer/timer.dart';
import 'package:pomodoro/data/model/timer/timer_info.dart';
import 'package:pomodoro/data/repository/timer_repository.dart';

final timerRepositoryProvider =
    Provider<TimerRepositoryImpl>(TimerRepositoryImpl.new);

class TimerRepositoryImpl implements TimerRepository {
  TimerRepositoryImpl(this._ref);

  // final util = SharedPreferencesUtils();

  final Ref _ref;

  // @override
  // Future<Result<TimerInfo?>> get() async {
  //   return util.getTimerInfo().then((data) {
  //     if (data?.name != null) {
  //       return Result<TimerInfo?>.success(data);
  //     }
  //     return Result<TimerInfo?>.failure(data);
  //   });
  // }

  @override
  Future<void> save(TimerInfo timerInfo) async {
    final timer = Timer()..name = timerInfo.name;
    final box = Boxes.getTimers();
    await box.add(timer);
  }
}
