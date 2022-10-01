// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class Timer with _$Timer {
  @HiveType(typeId: 0, adapterName: 'TimerAdapter')
  const factory Timer({
    @HiveField(0) @Default('timer1') String name,
  }) = _Timer;
}
