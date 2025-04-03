import 'package:agenda_escolar/src/colores.dart';
import 'package:flutter/material.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colores().colorBoton,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}