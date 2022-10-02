// Package imports:
import 'package:hive/hive.dart';

part 'pomo.g.dart';

@HiveType(typeId: 0, adapterName: 'PomoAdapter')
class Pomo extends HiveObject {
  Pomo({required this.name, required this.minute, required this.caption});
  @HiveField(0, defaultValue: '25分集中')
  String name;

  @HiveField(1, defaultValue: 25)
  int minute;

  @HiveField(2, defaultValue: '')
  String caption;
}
