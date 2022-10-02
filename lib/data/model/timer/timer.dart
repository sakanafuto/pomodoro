// Package imports:
import 'package:hive/hive.dart';

part 'timer.g.dart';

@HiveType(typeId: 0, adapterName: 'TimerAdapter')
class Timer extends HiveObject {
  @HiveField(0)
  late String name;
}
