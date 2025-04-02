import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/materiasLista.dart';
import 'package:agenda_escolar/src/materia.dart';
import 'package:agenda_escolar/src/colores.dart';
import 'package:agenda_escolar/src/botonAgregarMateria.dart';

class Pantallamaterias extends StatefulWidget {
  const Pantallamaterias({super.key});

  @override
  State<Pantallamaterias> createState() => _PantallamateriasState();
}

class _PantallamateriasState extends State<Pantallamaterias> {
  void _mostrarFormularioAgregarMateria() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FormularioAgregarMateria(
          agregarMateria: (String nombreMateria, String nombreProfesor,
              String proximaClase, Color colorMateria) {
            setState(() {
              listaMaterias.add(
                materias(
                  colorMateria: colorMateria,
                  nombreMateria: nombreMateria,
                  nombreProfesor: nombreProfesor,
                  salon: proximaClase,
                ),
              );
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores().colorPrimario,
      appBar: AppBar(
        title: const Text(
          'Materias',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colores().colorPrimario,
      ),
      body: ListView.builder(
        itemCount: listaMaterias.length,
        itemBuilder: (context, index) {
          final materia = listaMaterias[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: materiasContaioner(
              colorMateria: materia.colorMateria,
              nombreMateria: materia.nombreMateria,
              nombreProfesor: materia.nombreProfesor,
              proximaClase: materia.salon,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormularioAgregarMateria,
        backgroundColor: Colores().colorBoton,
        child: const Icon(Icons.add, color: Colors.black,),
      ),
    );
  }
}