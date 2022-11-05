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
