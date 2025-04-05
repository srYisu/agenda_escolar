import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Asegúrate de agregar esta dependencia en pubspec.yaml
import 'package:agenda_escolar/data/boxMaterias.dart';

class FormularioAgregarMateria extends StatefulWidget {
  final Function agregarMateria;
  final Materia? materiaExistente;

  const FormularioAgregarMateria({
    super.key,
    required this.agregarMateria,
    this.materiaExistente,
  });

  @override
  State<FormularioAgregarMateria> createState() =>
      _FormularioAgregarMateriaState();
}

class _FormularioAgregarMateriaState extends State<FormularioAgregarMateria> {
  late TextEditingController nombreController;
  late TextEditingController profesorController;
  late TextEditingController salonController;
  late Color colorSeleccionado;

  @override
  void initState() {
    super.initState();
    final materia = widget.materiaExistente;

    nombreController = TextEditingController(text: materia?.nombreMateria ?? '');
    profesorController =
        TextEditingController(text: materia?.nombreProfesor ?? '');
    salonController = TextEditingController(text: materia?.salonClases ?? '');
    colorSeleccionado = materia?.color ?? Colors.pinkAccent;
  }

  @override
  void dispose() {
    nombreController.dispose();
    profesorController.dispose();
    salonController.dispose();
    super.dispose();
  }

  void _mostrarSelectorDeColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: colorSeleccionado,
              onColorChanged: (Color color) {
                setState(() {
                  colorSeleccionado = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Seleccionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.materiaExistente != null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(maxHeight: 450),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                esEdicion ? 'Editar Materia' : 'Agregar Materia',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la Materia',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextField(
                controller: profesorController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Profesor',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextField(
                controller: salonController,
                decoration: InputDecoration(
                  labelText: 'Salón de clases',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Color Seleccionado:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: _mostrarSelectorDeColor,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: colorSeleccionado,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancelar',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.agregarMateria(
                        nombreController.text,
                        profesorController.text,
                        salonController.text,
                        colorSeleccionado,
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(esEdicion ? 'Guardar cambios' : 'Agregar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}