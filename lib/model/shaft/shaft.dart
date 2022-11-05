// Package imports:
import 'package:hive/hive.dart';

// Project imports:

part 'shaft.g.dart';

@HiveType(typeId: 0, adapterName: 'ShaftAdapter')
class Shaft extends HiveObject {
  Shaft({required this.type, required this.totalTime, required this.date});

  @HiveField(0)
  final String type;

  @HiveField(1, defaultValue: 0)
  late int totalTime;

  @HiveField(2)
  final DateTime date;
}
