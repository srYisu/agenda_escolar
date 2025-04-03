// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxMaterias.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MateriaAdapter extends TypeAdapter<Materia> {
  @override
  final int typeId = 0;

  @override
  Materia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Materia(
      nombreMateria: fields[0] as String,
      nombreProfesor: fields[1] as String,
      salonClases: fields[2] as String,
      colorMateria: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Materia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nombreMateria)
      ..writeByte(1)
      ..write(obj.nombreProfesor)
      ..writeByte(2)
      ..write(obj.salonClases)
      ..writeByte(3)
      ..write(obj.colorMateria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MateriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
