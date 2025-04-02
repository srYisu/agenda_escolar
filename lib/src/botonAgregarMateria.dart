import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/materiasLista.dart';

class FormularioAgregarMateria extends StatelessWidget {
  final Function agregarMateria;

  const FormularioAgregarMateria({super.key, required this.agregarMateria});

  @override
  Widget build(BuildContext context) {
    String nombreMateria = '';
    String nombreProfesor = '';
    String salon = '';
    Color colorSeleccionado = Colors.pinkAccent;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          constraints: const BoxConstraints(
            maxHeight: 600, // Altura máxima del formulario
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Agregar Materia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre de la Materia'),
                onChanged: (value) {
                  nombreMateria = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre del Profesor',),
                onChanged: (value) {
                  nombreProfesor = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Próxima Clase'),
                onChanged: (value) {
                  salon = value;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Seleccionar Color:',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<Color>(
                    value: colorSeleccionado,
                    items: [
                      DropdownMenuItem(
                        value: Colors.pinkAccent,
                        child: Container(
                          width: 24,
                          height: 24,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Colors.blueAccent,
                        child: Container(
                          width: 24,
                          height: 24,
                          color: Colors.blueAccent,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Colors.greenAccent,
                        child: Container(
                          width: 24,
                          height: 24,
                          color: Colors.greenAccent,
                        ),
                      ),
                      DropdownMenuItem(
                        value: Colors.orangeAccent,
                        child: Container(
                          width: 24,
                          height: 24,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                    onChanged: (Color? newColor) {
                      colorSeleccionado = newColor!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      agregarMateria(
                        nombreMateria,
                        nombreProfesor,
                        salon,
                        colorSeleccionado,
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Agregar'),
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