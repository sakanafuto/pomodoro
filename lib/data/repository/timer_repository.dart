// Project imports:
import 'package:pomodoro/data/model/timer/timer_info.dart';

abstract class TimerRepository {
  // Future<Result<TimerInfo?>> get();

  void save(TimerInfo timerInfo);
}
