import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/materiasController.dart';
import 'package:agenda_escolar/data/horariosController.dart';
import 'package:agenda_escolar/data/boxHorarios.dart';

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
  TimeOfDay? _horaInicio;
  TimeOfDay? _horaFin;

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

  TimeOfDay _parseHora(String hora) {
    final partes = hora.split(":");
    final horas = int.parse(partes[0]);
    final minutos = int.parse(partes[1].split(" ")[0]);
    return TimeOfDay(hour: horas, minute: minutos);
  }

  @override
  Widget build(BuildContext context) {
    final materias = _materiaController.obtenerTodas();
    final esEdicion = widget.horarioExistente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? "Editar Horario" : "Agregar Horario"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ComboBox para seleccionar la materia
            const Text(
              "Selecciona una materia:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _materiaSeleccionada,
              hint: const Text("Selecciona una materia"),
              isExpanded: true,
              items: materias.map((materia) {
                return DropdownMenuItem<String>(
                  value: materia.nombreMateria,
                  child: Text(materia.nombreMateria),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _materiaSeleccionada = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Selección de días
            const Text(
              "Selecciona los días:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: _diasSemana.map((dia) {
                return FilterChip(
                  label: Text(dia),
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

            // Selección de hora de inicio
            const Text(
              "Selecciona la hora de inicio:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () async {
                final hora = await showTimePicker(
                  context: context,
                  initialTime: _horaInicio ?? TimeOfDay.now(),
                );
                if (hora != null) {
                  setState(() {
                    _horaInicio = hora;
                  });
                }
              },
              child: Text(
                _horaInicio != null
                    ? "Hora de inicio: ${_horaInicio!.format(context)}"
                    : "Seleccionar hora de inicio",
              ),
            ),
            const SizedBox(height: 16),

            // Selección de hora de fin
            const Text(
              "Selecciona la hora de fin:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () async {
                final hora = await showTimePicker(
                  context: context,
                  initialTime: _horaFin ?? TimeOfDay.now(),
                );
                if (hora != null) {
                  setState(() {
                    _horaFin = hora;
                  });
                }
              },
              child: Text(
                _horaFin != null
                    ? "Hora de fin: ${_horaFin!.format(context)}"
                    : "Seleccionar hora de fin",
              ),
            ),
            const SizedBox(height: 24),

            // Botón para guardar
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
                      horaInicio: _horaInicio!.format(context),
                      horaFin: _horaFin!.format(context),
                      diasSemana: _diasSeleccionados,
                      colorMateria: materia.colorMateria,
                    );

                    if (esEdicion) {
                      // Editar horario existente
                      widget.horarioExistente!.delete();
                    }
                    _horarioController.agregarMateria(horario);

                    widget.onGuardar(); // Notificar que se guardó
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Por favor, completa todos los campos."),
                      ),
                    );
                  }
                },
                child: Text(esEdicion ? "Guardar cambios" : "Agregar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}