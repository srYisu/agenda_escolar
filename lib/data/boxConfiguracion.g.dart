// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxConfiguracion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfiguracionAdapter extends TypeAdapter<Configuracion> {
  @override
  final int typeId = 3;

  @override
  Configuracion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Configuracion(
      isDarkMode: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Configuracion obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfiguracionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
