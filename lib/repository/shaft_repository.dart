// Project imports:

// Project imports:
import 'package:pomodoro/model/shaft/shaft_state.dart';

abstract class ShaftRepository {
  Future<void> save(ShaftState shaftState);
  Future<ShaftState?> get();
}
