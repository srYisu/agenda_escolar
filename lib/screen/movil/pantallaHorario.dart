import 'package:agenda_escolar/src/colores.dart';
import 'package:flutter/material.dart';

class Pantallahorario extends StatefulWidget {
  const Pantallahorario({super.key});

  @override
  State<Pantallahorario> createState() => _HorarioState();
}

class _HorarioState extends State<Pantallahorario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores().colorPrimario,
    );
  }
}