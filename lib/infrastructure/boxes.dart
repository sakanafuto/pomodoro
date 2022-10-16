// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:pomodoro/model/shaft/shaft.dart';

Box<Shaft> getShafts() => Hive.box<Shaft>('shaftBox');
