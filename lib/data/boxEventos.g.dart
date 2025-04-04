// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxEventos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventoAdapter extends TypeAdapter<Evento> {
  @override
  final int typeId = 2;

  @override
  Evento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Evento(
      materia: fields[1] as Materia,
      titulo: fields[0] as String,
      fecha: fields[2] as DateTime,
      notas: fields[3] as String,
      colorMateria: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Evento obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.materia)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.notas)
      ..writeByte(4)
      ..write(obj.colorMateria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
