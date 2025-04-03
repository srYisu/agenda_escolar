import 'package:agenda_escolar/data/boxMaterias.dart';
import 'package:agenda_escolar/data/materiasController.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';


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
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                esEdicion ? 'Editar Materia' : 'Agregar Materia',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre de la Materia'),
              ),
              TextField(
                controller: profesorController,
                decoration: const InputDecoration(labelText: 'Nombre del Profesor'),
              ),
              TextField(
                controller: salonController,
                decoration: const InputDecoration(labelText: 'Salón de clases'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Seleccionar Color:', style: TextStyle(fontSize: 16)),
                  DropdownButton<Color>(
                    value: colorSeleccionado,
                    items: [
                      Colors.pinkAccent,
                      Colors.blueAccent,
                      Colors.greenAccent,
                      Colors.orangeAccent,
                    ].map((color) {
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
                    child: const Text('Cancelar'),
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