import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

part 'boxEventos.g.dart'; // Asegúrate de que el nombre coincida con tu archivo .g.dart

@HiveType(typeId: 2)
class Evento extends HiveObject {
  @HiveField(0)
  String titulo;

  @HiveField(1)
  String materia; // Cambiado de Materia a String

  @HiveField(2)
  DateTime fecha;

  @HiveField(3)
  String notas;

  @HiveField(4)
  int colorMateria; // Guardamos también el color

  @HiveField(5)
  bool completado; // Nuevo campo para marcar si el evento está completado

  Evento({
    required this.titulo,
    required this.materia,
    required this.fecha,
    required this.notas,
    required this.colorMateria,
    this.completado = false, // Por defecto está en false (no completado)
  });

  Color get color => Color(colorMateria); // Acceso directo al color
}