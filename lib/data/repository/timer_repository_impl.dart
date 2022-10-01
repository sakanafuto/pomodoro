// // Package imports:
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// // Project imports:
// import 'package:pomodoro/data/model/result.dart';
// import 'package:pomodoro/data/model/shared_preferences_util.dart';
// import 'package:pomodoro/data/model/timer/timer_state_info.dart';
// import 'package:pomodoro/data/repository/timer_repository.dart';

// final timerRepositoryProvider =
//     Provider<TimerRepository>((ref) => TimerRepositoryImpl(ref.read));

// class TimerRepositoryImpl implements TimerRepository {
//   TimerRepositoryImpl(this._reader);

//   final util = SharedPreferencesUtils();

//   final Reader _reader;

//   @override
//   Future<Result<TimerInfo?>> get() async {
//     return util.getTimerInfo().then((data) {
//       if (data?.name != null) {
//         return Result<TimerInfo?>.success(data);
//       }
//       return Result<TimerInfo?>.failure(data);
//     });
//   }

//   @override
//   Future<void> save(TimerInfo timerInfo) {
//     return util.setTimerInfo(timerInfo);
//   }
// }
