import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/materiasController.dart';
import 'package:agenda_escolar/data/eventosController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';
import 'package:agenda_escolar/data/boxMaterias.dart';

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
    final List<Materia> materias = materiaController.obtenerTodas();
    final List<String> nombresMaterias = materias.map((m) => m.nombreMateria).toList();

    final TextEditingController tituloController = TextEditingController();
    final TextEditingController notasController = TextEditingController();
    DateTime? fechaSeleccionada;
    String? nombreMateriaSeleccionada;

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
                  items: nombresMaterias
                      .map((nombre) => DropdownMenuItem(
                            value: nombre,
                            child: Text(nombre),
                          ))
                      .toList(),
                  onChanged: (value) {
                    nombreMateriaSeleccionada = value;
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
                      // Buscar el color asociado al nombre de la materia, si existe
                      int colorFinal = Colors.blue.value; // Valor por defecto
                      final materiaEncontrada = materias.firstWhere(
                        (m) => m.nombreMateria == nombreMateriaSeleccionada,
                        orElse: () => Materia(nombreMateria: '', colorMateria: Colors.blue.value, nombreProfesor: '', salonClases: ''),
                      );
                      colorFinal = materiaEncontrada.colorMateria;

                      final nuevoEvento = Evento(
                        titulo: tituloController.text,
                        materia: nombreMateriaSeleccionada ?? '',
                        fecha: fechaSeleccionada!,
                        notas: notasController.text,
                        colorMateria: colorFinal,
                      );

                      eventosController.agregarEvento(nuevoEvento);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Por favor, completa todos los campos obligatorios.'),
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
