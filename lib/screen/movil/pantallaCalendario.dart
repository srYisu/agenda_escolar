import 'package:agenda_escolar/src/colores.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/botonAgregarEventro.dart';

class Pantallacalendario extends StatefulWidget {
  const Pantallacalendario({super.key});

  @override
  State<Pantallacalendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Pantallacalendario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores().colorPrimario,
      floatingActionButton: const BotonAgregarEvento(),
    );
  }
}