import 'package:agenda_escolar/src/botonAgregarEventro.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: BotonAgregarEvento(),
    );
  }
}