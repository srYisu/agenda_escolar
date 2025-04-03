import 'package:agenda_escolar/src/colores.dart';
import 'package:flutter/material.dart';

class Pantallaresumen extends StatefulWidget {
  const Pantallaresumen({super.key});

  @override
  State<Pantallaresumen> createState() => _PantallaresumenState();
}

class _PantallaresumenState extends State<Pantallaresumen> {
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