// Project imports:
import 'package:pomodoro/data/model/timer/timer.dart';
import 'package:pomodoro/data/model/timer/timer_info.dart';

abstract class TimerRepository {
  void save(TimerInfo timerInfo);
  void delete(Timer timer);
}
