import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/materiasController.dart';
import 'package:agenda_escolar/data/eventosController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';

class BotonAgregarEvento extends StatelessWidget {
  const BotonAgregarEvento({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _mostrarFormularioAgregarEvento(context);
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  void _mostrarFormularioAgregarEvento(BuildContext context) {
    final MateriaController materiaController = MateriaController();
    final EventosController eventosController = EventosController();
    final List<String> materias = materiaController
        .obtenerTodas()
        .map((materia) => materia.nombreMateria)
        .toList();

    final TextEditingController tituloController = TextEditingController();
    final TextEditingController notasController = TextEditingController();
    DateTime? fechaSeleccionada;
    String? materiaSeleccionada;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
                Text(
                  'Añadir Evento',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: tituloController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: const OutlineInputBorder(),
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Materia (Opcional)',
                    border: const OutlineInputBorder(),
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
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
                  decoration: InputDecoration(
                    labelText: 'Fecha',
                    border: const OutlineInputBorder(),
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  readOnly: true,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      fechaSeleccionada = selectedDate;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: notasController,
                  decoration: InputDecoration(
                    labelText: 'Nota Adicional',
                    border: const OutlineInputBorder(),
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (tituloController.text.isNotEmpty &&
                        fechaSeleccionada != null) {
                      // Crear un nuevo evento
                      final nuevaMateria = materiaController.obtenerTodas().firstWhere(
                          (materia) => materia.nombreMateria == materiaSeleccionada,
                          orElse: () => materiaController.obtenerTodas().first);

                      final nuevoEvento = Evento(
                        titulo: tituloController.text,
                        materia: nuevaMateria,
                        fecha: fechaSeleccionada!,
                        notas: notasController.text,
                        colorMateria: nuevaMateria.colorMateria,
                      );

                      // Guardar el evento en Hive
                      eventosController.agregarEvento(nuevoEvento);

                      // Cerrar el formulario
                      Navigator.pop(context);
                    } else {
                      // Mostrar un mensaje de error si faltan datos obligatorios
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, completa todos los campos obligatorios.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
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