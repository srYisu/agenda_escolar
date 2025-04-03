import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'boxMaterias.g.dart';

@HiveType(typeId: 0)
class Materia extends HiveObject {
  @HiveField(0)
  String nombreMateria;

  @HiveField(1)
  String nombreProfesor;

  @HiveField(2)
  String salonClases;

  @HiveField(3)
  int colorMateria;

  Materia({
    required this.nombreMateria,
    required this.nombreProfesor,
    required this.salonClases,
    required this.colorMateria,
  });

  Color get color => Color(colorMateria);
}