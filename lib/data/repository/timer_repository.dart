// Project imports:
import 'package:pomodoro/data/model/result.dart';
import 'package:pomodoro/data/model/timer/timer_state_info.dart';

abstract class TimerRepository {
  Future<Result<TimerStateInfo?>> get();

  void save(TimerStateInfo timerStateInfo);
}