import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/eventosController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';
import 'package:intl/intl.dart';
import 'package:agenda_escolar/src/botonAgregarEventro.dart';

class Pantallaresumen extends StatefulWidget {
  const Pantallaresumen({super.key});

  @override
  State<Pantallaresumen> createState() => _PantallaresumenState();
}

class _PantallaresumenState extends State<Pantallaresumen> {
  final EventosController _eventosController = EventosController();
  late List<Evento> _eventosSemana;

  @override
  void initState() {
    super.initState();
    _cargarEventosSemana();
  }

  void _cargarEventosSemana() {
    final DateTime hoy = DateTime.now();
    final DateTime finSemana = hoy.add(const Duration(days: 7));
    setState(() {
      _eventosSemana = _eventosController.obtenerEventosPorRango(hoy, finSemana);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime hoy = DateTime.now();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Resumen Semanal'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: 8, // Hoy + 7 días
        itemBuilder: (context, index) {
          final DateTime dia = hoy.add(Duration(days: index));
          final List<Evento> eventosDelDia = _eventosSemana
              .where((evento) =>
                  evento.fecha.year == dia.year &&
                  evento.fecha.month == dia.month &&
                  evento.fecha.day == dia.day)
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index == 0
                      ? 'Hoy'
                      : index == 1
                          ? 'Mañana'
                          : DateFormat('EEEE dd/MM').format(dia),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                eventosDelDia.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eventos pendientes',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Añade eventos',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: eventosDelDia.map((evento) {
                          return Card(
                            color: Theme.of(context).cardColor,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: Icon(
                                evento.completado
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: evento.completado
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              title: Text(
                                evento.titulo,
                                style: evento.completado
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )
                                    : Theme.of(context).textTheme.bodyLarge,
                              ),
                              subtitle: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Color(evento.colorMateria),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    evento.materia,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const BotonAgregarEvento(),
    );
  }
}