// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxHorarios.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HorarioAdapter extends TypeAdapter<Horario> {
  @override
  final int typeId = 1;

  @override
  Horario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Horario(
      materia: fields[0] as Materia,
      horaInicio: fields[1] as String,
      horaFin: fields[2] as String,
      diasSemana: (fields[3] as List).cast<String>(),
      colorMateria: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Horario obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.materia)
      ..writeByte(1)
      ..write(obj.horaInicio)
      ..writeByte(2)
      ..write(obj.horaFin)
      ..writeByte(3)
      ..write(obj.diasSemana)
      ..writeByte(4)
      ..write(obj.colorMateria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
