// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerAdapter extends TypeAdapter<Timer> {
  @override
  final int typeId = 0;

  @override
  Timer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timer()..name = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Timer obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}