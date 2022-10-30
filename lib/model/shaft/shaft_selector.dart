// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Project imports:
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 軸の変更・記憶を行う StateNotifier
class ShaftSelector extends StateNotifier<ShaftState> {
  ShaftSelector(this._ref) : super(ShaftState.work) {
    initialize();
  }

  static const shaftPrefsKey = 'selectedShaft';

  // ignore: unused_field
  final Ref _ref;

  /// 選択されたテーマの記憶があれば取得して反映
  Future<void> initialize() async {
    final shaftIndex = await _shaftIndex;
    state = ShaftState.values.firstWhere(
      (e) => e.index == shaftIndex,
      orElse: () => ShaftState.work,
    );
  }

  Future<void> change(ShaftState shaft) async {
    await _save(shaft.index);
    state = shaft;
  }

  Future<int?> get _shaftIndex async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(shaftPrefsKey);
  }

  Future<void> _save(int shaftIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(shaftPrefsKey, shaftIndex);
  }
}
