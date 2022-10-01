// Package imports:
// Project imports:
import 'package:pomodoro/data/model/timer/timer_state_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  final keyTimerInfoName = 'timer_name';

  Future<void> setTimerStateInfo(TimerStateInfo timerInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyTimerInfoName, timerInfo.name);
  }

  Future<TimerStateInfo?> getTimerStateInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return TimerStateInfo(name: prefs.getString(keyTimerInfoName)!);
  }
}
