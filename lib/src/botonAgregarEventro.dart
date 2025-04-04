import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/colores.dart';
import 'package:agenda_escolar/data/materiasController.dart';

class BotonAgregarEvento extends StatelessWidget {
  const BotonAgregarEvento({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _mostrarFormularioAgregarEvento(context);
      },
      backgroundColor: Colores().colorBoton,
      child: const Icon(Icons.add, color: Colors.black),
    );
  }

  void _mostrarFormularioAgregarEvento(BuildContext context) {
    final MateriaController materiaController = MateriaController();
    final List<String> materias = materiaController
        .obtenerTodas()
        .map((materia) => materia.nombreMateria)
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String? materiaSeleccionada;

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Añadir Evento',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Materia (Opcional)',
                    border: OutlineInputBorder(),
                  ),
                  items: materias
                      .map((materia) => DropdownMenuItem(
                            value: materia,
                            child: Text(materia),
                          ))
                      .toList(),
                  onChanged: (value) {
                    materiaSeleccionada = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      // Aquí puedes manejar la fecha seleccionada
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nota Adicional',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes manejar el guardado del evento
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colores().colorBoton,
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}