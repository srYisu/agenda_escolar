import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/botonAgregarEventro.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:agenda_escolar/data/eventosController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';
import 'package:intl/intl.dart';

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
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    _eliminarEvento(evento);
                  },
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