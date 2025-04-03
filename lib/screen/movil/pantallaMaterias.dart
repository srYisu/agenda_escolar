import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/materiasLista.dart';
import 'package:agenda_escolar/src/materiaContainer.dart';
import 'package:agenda_escolar/src/colores.dart';
import 'package:agenda_escolar/src/botonAgregarMateria.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agenda_escolar/data/boxMaterias.dart';

class Pantallamaterias extends StatefulWidget {
  const Pantallamaterias({super.key});

  @override
  State<Pantallamaterias> createState() => _PantallamateriasState();
}

class _PantallamateriasState extends State<Pantallamaterias> {
  final Box<Materia> box = Hive.box<Materia>('materias');

  void _mostrarFormularioAgregarMateria() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FormularioAgregarMateria(
          agregarMateria: (String nombreMateria, String nombreProfesor,
              String salon, Color colorMateria) {
            final nuevaMateria = Materia(
              nombreMateria: nombreMateria,
              nombreProfesor: nombreProfesor,
              salonClases: salon,
              colorMateria: colorMateria.value,
            );
            box.add(nuevaMateria); // Se guarda directamente en Hive
          },
        );
      },
    );
  }

  void _mostrarFormularioEditarMateria(int index, Materia materia) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FormularioAgregarMateria(
          materiaExistente: materia, // Si quieres prellenar los datos
          agregarMateria: (String nombreMateria, String nombreProfesor,
              String salon, Color colorMateria) {
            final materiaEditada = Materia(
              nombreMateria: nombreMateria,
              nombreProfesor: nombreProfesor,
              salonClases: salon,
              colorMateria: colorMateria.value,
            );
            box.putAt(index, materiaEditada); // Actualizar el elemento en Hive
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
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Materia> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                'No hay materias disponibles',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final materia = box.getAt(index);

              // Validar que la materia no sea null
              if (materia == null) {
                return const SizedBox.shrink(); // Retorna un widget vacío
              }

              return Dismissible(
                key: Key(materia.nombreMateria + index.toString()),
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Confirmar eliminación
                    final confirmar = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Eliminar"),
                        content: const Text("¿Estás seguro de eliminar esta materia?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Eliminar"),
                          ),
                        ],
                      ),
                    );
                    return confirmar ?? false;
                  } else {
                    // Editar (no elimina)
                    _mostrarFormularioEditarMateria(index, materia);
                    return false;
                  }
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    box.deleteAt(index); // Eliminar la materia
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: materiasContaioner(
                    colorMateria: Color(materia.colorMateria),
                    nombreMateria: materia.nombreMateria,
                    nombreProfesor: materia.nombreProfesor,
                    salonClases: materia.salonClases,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormularioAgregarMateria,
        backgroundColor: Colores().colorBoton,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}