// Project imports:
import 'package:pomodoro/data/model/pomo/pomo.dart';
import 'package:pomodoro/data/model/pomo/pomo_info.dart';

abstract class PomoRepository {
  void save(PomoInfo pomoInfo);
  void delete(Pomo pomo);
}
