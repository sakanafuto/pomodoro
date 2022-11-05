// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shaft_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShaftStateAdapter extends TypeAdapter<ShaftState> {
  @override
  final int typeId = 1;

  @override
  ShaftState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShaftState.work;
      case 1:
        return ShaftState.hoby;
      case 2:
        return ShaftState.rest;
      default:
        return ShaftState.work;
    }
  }

  @override
  void write(BinaryWriter writer, ShaftState obj) {
    switch (obj) {
      case ShaftState.work:
        writer.writeByte(0);
        break;
      case ShaftState.hoby:
        writer.writeByte(1);
        break;
      case ShaftState.rest:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShaftStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
