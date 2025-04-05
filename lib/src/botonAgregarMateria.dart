import 'package:agenda_escolar/data/boxMaterias.dart';
import 'package:flutter/material.dart';


class FormularioAgregarMateria extends StatefulWidget {
  final Function agregarMateria;
  final Materia? materiaExistente;

  const FormularioAgregarMateria({
    super.key,
    required this.agregarMateria,
    this.materiaExistente,
  });

  @override
  State<FormularioAgregarMateria> createState() => _FormularioAgregarMateriaState();
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
    profesorController = TextEditingController(text: materia?.nombreProfesor ?? '');
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

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.materiaExistente != null;
    final coloresDisponibles = [
  Colors.pinkAccent,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.orangeAccent,
];

colorSeleccionado = coloresDisponibles.contains(widget.materiaExistente?.color)
    ? widget.materiaExistente!.color
    : Colors.pinkAccent;
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
                  Text('Seleccionar Color:', style: Theme.of(context).textTheme.bodyMedium),
                  DropdownButton<Color>(
                    value: colorSeleccionado,
                    items: coloresDisponibles.map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Container(width: 24, height: 24, color: color),
                      );
                    }).toList(),
                    onChanged: (Color? newColor) {
                      if (newColor != null) {
                        setState(() => colorSeleccionado = newColor);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancelar', style: Theme.of(context).textTheme.bodyMedium),
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