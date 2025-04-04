import 'package:hive_flutter/hive_flutter.dart';
import 'boxMaterias.dart'; // Importa la clase Materia
import 'package:flutter/material.dart';

part 'boxHorarios.g.dart';

@HiveType(typeId: 1)
class Horario extends HiveObject {
  @HiveField(0)
  Materia materia;

  @HiveField(1)
  String horaInicio;

  @HiveField(2)
  String horaFin;

  @HiveField(3)
  List<String> diasSemana;

  @HiveField(4)
  int colorMateria; // Guardamos también el color

  Horario({
    required this.materia,
    required this.horaInicio,
    required this.horaFin,
    required this.diasSemana,
    required this.colorMateria,

  }); // Copiamos el color al crear

  Color get color => Color(materia.colorMateria); // Acceso directo al color
}
