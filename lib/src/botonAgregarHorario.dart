import 'dart:ffi';

import 'package:agenda_escolar/main.dart';
import 'package:agenda_escolar/src/colores.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/materiasController.dart';
import 'package:agenda_escolar/data/horariosController.dart';
import 'package:agenda_escolar/data/boxHorarios.dart';
import 'package:intl/intl.dart';

class FormularioHorario extends StatefulWidget {
  final Function() onGuardar;
  final Horario? horarioExistente; // Horario a editar (opcional)

  const FormularioHorario({
    super.key,
    required this.onGuardar,
    this.horarioExistente,
  });

  @override
  State<FormularioHorario> createState() => _FormularioHorarioState();
}

class _FormularioHorarioState extends State<FormularioHorario> {
  final MateriaController _materiaController = MateriaController();
  final HorarioController _horarioController = HorarioController();

  String? _materiaSeleccionada;
  List<String> _diasSeleccionados = [];
  DateTime? _horaInicio;
  DateTime? _horaFin;


  final List<String> _diasSemana = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo"
  ];

  @override
  void initState() {
    super.initState();
    if (widget.horarioExistente != null) {
      // Prellenar los campos si se está editando un horario
      final horario = widget.horarioExistente!;
      _materiaSeleccionada = horario.materia.nombreMateria;
      _diasSeleccionados = List<String>.from(horario.diasSemana);
      _horaInicio = _parseHora(horario.horaInicio);
      _horaFin = _parseHora(horario.horaFin);
    }
  }

  DateTime _parseHora(String hora) {
    final formato = DateFormat("hh:mm a"); // Formato con AM/PM
    return formato.parse(hora);
  }

  String _formatHora(DateTime hora) {
    final formato = DateFormat("hh:mm a"); // Formato con AM/PM
    return formato.format(hora);
  }

  @override
  Widget build(BuildContext context) {
    final materias = _materiaController.obtenerTodas();
    final esEdicion = widget.horarioExistente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion ? "Editar Horario" : "Agregar Horario",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecciona una materia:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  decoration: BoxDecoration(
    color: Theme.of(context).cardColor, // Cambia este color según lo que necesites
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey.shade400), // Opcional: borde para simular el OutlineInputBorder
  ),
  child: DropdownButton<String>(
    value: _materiaSeleccionada,
    hint: Text(
      "Selecciona una materia",
      style: Theme.of(context).primaryTextTheme.bodyMedium,
    ),
    isExpanded: true,
    underline: const SizedBox(), // Elimina la línea por defecto debajo del dropdown
    dropdownColor: Theme.of(context).cardColor, // Fondo del menú desplegable
    items: materias.map((materia) {
      return DropdownMenuItem<String>(
        value: materia.nombreMateria,
        child: Text(
          materia.nombreMateria,
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        _materiaSeleccionada = value;
      });
    },
  ),
),
            const SizedBox(height: 16),
            Text(
              "Selecciona los días:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Wrap(
              spacing: 8.0,
              children: _diasSemana.map((dia) {
                return FilterChip(
                  disabledColor: Theme.of(context).shadowColor,
                  backgroundColor: Theme.of(context).cardColor,
                  label: Text(
                    dia,
                    style: Theme.of(context).primaryTextTheme.bodyMedium, 
                  ),
                  selected: _diasSeleccionados.contains(dia),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _diasSeleccionados.add(dia);
                      } else {
                        _diasSeleccionados.remove(dia);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              "Selecciona la hora de inicio:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () async {
final hora = await showTimePicker(
  context: context,
  initialTime: _horaInicio != null
      ? TimeOfDay.fromDateTime(_horaInicio!)
      : TimeOfDay.now(),
  builder: (BuildContext context, Widget? child) {
    return Localizations.override(
      context: context,
      locale: const Locale('en', 'US'), // Forzar formato de 12 horas (AM/PM)
      child: Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: Theme.of(context).timePickerTheme,
        ),
        child: child!,
      ),
    );
  },
);
                if (hora != null) {
                  setState(() {
                    _horaInicio = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      hora.hour,
                      hora.minute,
                    );
                  });
                }
              },
              child: Text(
                _horaInicio != null
                    ? "Hora de inicio: ${_formatHora(_horaInicio!)}"
                    : "Seleccionar hora de inicio",
                style: TextStyle(color: const Color.fromARGB(255, 174, 154, 230), fontSize: 15),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Selecciona la hora de fin:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () async {
final hora = await showTimePicker(
  context: context,
  initialTime: _horaInicio != null
      ? TimeOfDay.fromDateTime(_horaInicio!)
      : TimeOfDay.now(),
  builder: (BuildContext context, Widget? child) {
    return Localizations.override(
      context: context,
      locale: const Locale('en', 'US'), // Forzar formato de 12 horas (AM/PM)
      child: Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: Theme.of(context).timePickerTheme,
        ),
        child: child!,
      ),
    );
  },
);
                if (hora != null) {
                  setState(() {
                    _horaFin = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      hora.hour,
                      hora.minute,
                    );
                  });
                }
              },
              child: Text(
                _horaFin != null
                    ? "Hora de fin: ${_formatHora(_horaFin!)}"
                    : "Seleccionar hora de fin",
                style: TextStyle(color: const Color.fromARGB(255, 174, 154, 230), fontSize: 15),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_materiaSeleccionada != null &&
                      _diasSeleccionados.isNotEmpty &&
                      _horaInicio != null &&
                      _horaFin != null) {
                    final materia = _materiaController.obtenerTodas().firstWhere(
                        (m) => m.nombreMateria == _materiaSeleccionada);

                    final horario = Horario(
                      materia: materia,
                      horaInicio: _formatHora(_horaInicio!),
                      horaFin: _formatHora(_horaFin!),
                      diasSemana: _diasSeleccionados,
                      colorMateria: materia.colorMateria,
                    );

                    if (esEdicion) {
                      widget.horarioExistente!.delete();
                    }
                    _horarioController.agregarMateria(horario);

                    widget.onGuardar();
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Por favor, completa todos los campos.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Text(
                  esEdicion ? "Guardar cambios" : "Agregar",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}