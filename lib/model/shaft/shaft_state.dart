// Package imports:
import 'package:hive/hive.dart';

part 'shaft_state.g.dart';

@HiveType(typeId: 1, adapterName: 'ShaftStateAdapter')
enum ShaftState {
  @HiveField(0)
  work,
  @HiveField(1)
  hoby,
  @HiveField(2)
  rest,
}

extension ShaftDisplayName on ShaftState {
  String get displayName {
    switch (this) {
      case ShaftState.work:
        return '仕事';
      case ShaftState.hoby:
        return '趣味';
      case ShaftState.rest:
        return '休息';
    }
  }
}
