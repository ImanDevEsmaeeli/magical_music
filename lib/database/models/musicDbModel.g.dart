// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musicDbModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicDbModelAdapter extends TypeAdapter<MusicDbModel> {
  @override
  final int typeId = 1;

  @override
  MusicDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicDbModel()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..description = fields[2] as String
      ..musicAddress = fields[3] as String
      ..textAddress = fields[4] as String
      ..isFavorite = fields[5] as bool
      ..musicCategory = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, MusicDbModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.musicAddress)
      ..writeByte(4)
      ..write(obj.textAddress)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.musicCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
