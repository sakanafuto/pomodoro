// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PomoAdapter extends TypeAdapter<Pomo> {
  @override
  final int typeId = 0;

  @override
  Pomo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pomo(
      name: fields[0] == null ? '25分集中' : fields[0] as String,
      minute: fields[1] == null ? 25 : fields[1] as int,
      caption: fields[2] == null ? '' : fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pomo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.minute)
      ..writeByte(2)
      ..write(obj.caption);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
