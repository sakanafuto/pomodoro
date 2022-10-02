// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:pomodoro/data/model/pomo/pomo.dart';

// ignore: avoid_classes_with_only_static_members
class Boxes {
  static Box<Pomo> getPomos() => Hive.box<Pomo>('pomosBox');
}
