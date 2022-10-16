// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shaft.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShaftAdapter extends TypeAdapter<Shaft> {
  @override
  final int typeId = 0;

  @override
  Shaft read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shaft(
      type: fields[0] == null ? ShaftState.work : fields[0] as ShaftState,
      totalTime: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Shaft obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.totalTime)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShaftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
