// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toolDbModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToolDbModelAdapter extends TypeAdapter<ToolDbModel> {
  @override
  final int typeId = 2;

  @override
  ToolDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToolDbModel()
      ..musicCategory = fields[0] as String
      ..index = fields[1] as int
      ..id = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, ToolDbModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.musicCategory)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
