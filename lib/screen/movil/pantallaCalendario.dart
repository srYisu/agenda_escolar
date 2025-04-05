import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/botonAgregarEventro.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:agenda_escolar/data/eventosController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';

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
                            : Theme.of(context).primaryColor, // Color predeterminado si no hay materia
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            evento.titulo,
                            style: Theme.of(context).primaryTextTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            evento.notas,
                            style: Theme.of(context).primaryTextTheme.bodyMedium,
                          ),
                          trailing: Text(
                            '${evento.fecha.day}/${evento.fecha.month}/${evento.fecha.year}',
                            style: Theme.of(context).primaryTextTheme.bodyMedium,
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