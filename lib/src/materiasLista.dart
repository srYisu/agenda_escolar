import 'package:flutter/material.dart';

class materias{
  final Color colorMateria;
  final String nombreMateria;
  final String nombreProfesor;
  final String salon;
  const materias({required this.colorMateria, required this.nombreMateria, required this.nombreProfesor, required this.salon});
  // const materias({super.key, required this.colorMateria, required this.nombreMateria, required this.nombreProfesor});  
}

List<materias> listaMaterias = [
  materias(colorMateria: Colors.pinkAccent, nombreMateria: "Asereje", nombreProfesor: "Prof. Juanito", salon: "Lunes 10:00 AM"),
];