import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    padding: const EdgeInsets.all(16),
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 500,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              esEdicion ? 'Editar Materia' : 'Añadir Materia',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre de la Materia',
                labelStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).primaryTextTheme.bodyMedium
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: profesorController,
              decoration:  InputDecoration(
                labelText: 'Nombre del Profesor',
                labelStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: salonController,
              decoration:  InputDecoration(
                labelText: 'Salón de Clases',
                labelStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color Seleccionado:',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
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
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (nombreController.text.isNotEmpty) {
                  widget.agregarMateria(
                    nombreController.text,
                    profesorController.text,
                    salonController.text,
                    colorSeleccionado,
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, completa todos los campos.'),
                    ),
                  );
                }
              },
              child: Text(esEdicion ? 'Guardar Cambios' : 'Agregar'),
            ),
          ],
        ),
      ),
    ),
  );
}
}