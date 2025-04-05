import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/botonAgregarEventro.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:agenda_escolar/data/eventosController.dart';
import 'package:agenda_escolar/data/materiasController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';
import 'package:intl/intl.dart';
import 'package:agenda_escolar/data/boxMaterias.dart';

class Pantallacalendario extends StatefulWidget {
  const Pantallacalendario({super.key});

  @override
  State<Pantallacalendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Pantallacalendario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final EventosController _eventosController = EventosController();
  List<Evento> _eventosDelDia = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _cargarEventosDelDia(_selectedDay!);
  }

  void _cargarEventosDelDia(DateTime dia) {
    setState(() {
      _eventosDelDia = _eventosController.obtenerEventosPorFecha(dia);
    });
  }

  void _eliminarEvento(Evento evento) {
    setState(() {
      _eventosController.eliminarEvento(evento);
      _cargarEventosDelDia(_selectedDay!);
    });
  }
void _mostrarFormularioEditarEvento(BuildContext context, Evento evento) {
  final TextEditingController tituloController =
      TextEditingController(text: evento.titulo);
  final TextEditingController notasController =
      TextEditingController(text: evento.notas);
  DateTime? fechaSeleccionada = evento.fecha;
  final MateriaController materiaController = MateriaController();
  final List<Materia> materias = materiaController.obtenerTodas();
  Materia? materiaSeleccionada = materias.firstWhere(
    (m) => m.nombreMateria == evento.materia,
    orElse: () => materias.first,
  );

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
                'Editar Evento',
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
              DropdownButtonFormField<Materia>(
                decoration: InputDecoration(
                  labelText: 'Materia',
                  border: const OutlineInputBorder(),
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
                value: materiaSeleccionada,
                items: materias
                    .map((materia) => DropdownMenuItem(
                          value: materia,
                          child: Text(materia.nombreMateria),
                        ))
                    .toList(),
                onChanged: (value) {
                  materiaSeleccionada = value;
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
                    initialDate: fechaSeleccionada ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      fechaSeleccionada = selectedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(fechaSeleccionada!),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (tituloController.text.isNotEmpty &&
                      fechaSeleccionada != null) {
                    setState(() {
                      evento.titulo = tituloController.text;
                      evento.notas = notasController.text;
                      evento.fecha = fechaSeleccionada!;
                      evento.materia = materiaSeleccionada?.nombreMateria ?? '';
                      evento.colorMateria =
                          materiaSeleccionada?.colorMateria ??
                              Colors.blue.value;
                      _eventosController.actualizarEvento(evento);
                      _cargarEventosDelDia(_selectedDay!);
                    });
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _cargarEventosDelDia(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 16),
          Text(DateFormat('dd/MM/yyyy').format(_focusedDay),
              style: Theme.of(context).textTheme.bodyMedium),
          Expanded(
  child: _eventosDelDia.isEmpty
      ? const Center(
          child: Text(
            'No hay eventos para este día.',
          ),
        )
      : ListView.builder(
          itemCount: _eventosDelDia.length,
          itemBuilder: (context, index) {
            final evento = _eventosDelDia[index];
            return Card(
              color: evento.colorMateria != null
                  ? Color(evento.colorMateria)
                  : Theme.of(context).primaryColor,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    evento.completado
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: evento.completado ? Colors.green : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      evento.completado = !evento.completado;
                      _eventosController.actualizarEvento(evento);
                    });
                  },
                ),
                title: Text(
                  evento.titulo,
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                ),
                subtitle: Text(
                  evento.notas,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'Editar') {
                      _mostrarFormularioEditarEvento(context, evento);
                    } else if (value == 'Eliminar') {
                      _eliminarEvento(evento);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Editar',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem(
                      value: 'Eliminar',
                      child: Text('Eliminar'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
),
        ],
      ),
      floatingActionButton: const BotonAgregarEvento(),
    );
  }
}