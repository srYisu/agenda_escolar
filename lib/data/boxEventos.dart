import 'package:hive_flutter/hive_flutter.dart';
import 'boxMaterias.dart'; // Importa la clase Materia
import 'package:flutter/material.dart';

part 'boxEventos.g.dart';

@HiveType(typeId: 2)
class Evento extends HiveObject {
  @HiveField(0)
  String titulo;

  @HiveField(1)
  Materia materia;

  @HiveField(2)
  DateTime fecha;

  @HiveField(3)
  String notas;

  @HiveField(4)
  int colorMateria; // Guardamos también el color

  Evento({
    required this.materia,
    required this.titulo,
    required this.fecha,
    required this.notas,
    required this.colorMateria,

  }); // Copiamos el color al crear

  Color get color => Color(materia.colorMateria); // Acceso directo al color
}
