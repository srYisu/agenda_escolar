import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/horariosController.dart';
import 'package:agenda_escolar/src/containerHorario.dart';
import 'package:intl/intl.dart';
import 'package:agenda_escolar/data/boxHorarios.dart';
import 'package:agenda_escolar/src/botonAgregarHorario.dart';

class Pantallahorario extends StatefulWidget {
  const Pantallahorario({super.key});

  @override
  State<Pantallahorario> createState() => _HorarioState();
}

class _HorarioState extends State<Pantallahorario> {
  final HorarioController _horarioController = HorarioController();
  late PageController _pageController;

  // Agregar días adicionales al inicio y al final para el efecto de "loop"
  final List<String> _diasSemana = [
    "Sábado", // Día adicional al inicio
    "Domingo",
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo", // Día adicional al final
  ];
    final List<String> _diasSemanaDesktop = [
    "Domingo",
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
  ];
  int _diaActualIndex = 1; // Comenzar en "Domingo"

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _diaActualIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _eliminarHorario(Horario horario) {
    _horarioController.eliminarMateria(horario.key as int); // Usar la clave de Hive
    setState(() {}); // Actualizar la lista después de eliminar
  }

  void _editarHorario(Horario horario) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioHorario(
          horarioExistente: horario, // Pasar el horario a editar
          onGuardar: () {
            setState(() {}); // Actualizar la lista después de editar
          },
        ),
      ),
    );
  }

  TimeOfDay _convertirStringATimeOfDay(String hora) {
    final formato = DateFormat("hh:mm a"); // Formato con AM/PM
    final DateTime dateTime = formato.parse(hora);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  bool _esHorarioActivo(String horaInicio, String horaFin) {
    final TimeOfDay ahora = TimeOfDay.now();
    final TimeOfDay inicio = _convertirStringATimeOfDay(horaInicio);
    final TimeOfDay fin = _convertirStringATimeOfDay(horaFin);

    int convertirAMinutos(TimeOfDay time) => time.hour * 60 + time.minute;

    final int minutosAhora = convertirAMinutos(ahora);
    final int minutosInicio = convertirAMinutos(inicio);
    final int minutosFin = convertirAMinutos(fin);

    return minutosAhora >= minutosInicio && minutosAhora <= minutosFin;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isDesktop
          ? _buildHorariosParaEscritorio()
          : _buildHorariosParaMovil(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Abrir el formulario para agregar un nuevo horario
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioHorario(
                onGuardar: () {
                  setState(() {}); // Actualizar la lista después de guardar
                },
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHorariosParaEscritorio() {
    final horariosPorDia = <String, List<Horario>>{};

    for (final dia in _diasSemanaDesktop) {
      horariosPorDia[dia] = _horarioController.obtenerTodas().where((horario) {
        return horario.diasSemana.contains(dia);
      }).toList();

      // Ordenar los horarios por hora de inicio
      horariosPorDia[dia]!.sort((a, b) {
        final TimeOfDay horaInicioA = _convertirStringATimeOfDay(a.horaInicio);
        final TimeOfDay horaInicioB = _convertirStringATimeOfDay(b.horaInicio);
        return horaInicioA.hour.compareTo(horaInicioB.hour) != 0
            ? horaInicioA.hour.compareTo(horaInicioB.hour)
            : horaInicioA.minute.compareTo(horaInicioB.minute);
      });
    }

    return SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _diasSemanaDesktop.map((dia) {
      final horarios = horariosPorDia[dia]!;
      return Container(
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dia,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            horarios.isEmpty
                ? Text(
                    'No hay horarios disponibles.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : Column(
                    children: horarios.map((horario) {
                      final bool esActivo = _esHorarioActivo(
                          horario.horaInicio, horario.horaFin);
                      return Horariocontainer(
                        nombreMateria: horario.materia.nombreMateria,
                        horaInicio: horario.horaInicio,
                        horaFin: horario.horaFin,
                        colorMateria: horario.color,
                        esActivo: esActivo,
                        onEditar: () => _editarHorario(horario),
                        onEliminar: () => _eliminarHorario(horario), // Pasar el objeto completo
                      );
                    }).toList(),
                  ),
          ],
        ),
      );
    }).toList(),
  ),
);
  }

  Widget _buildHorariosParaMovil() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado con el día de la semana
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left,
                    color: Theme.of(context).primaryIconTheme.color),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              Text(
                _diasSemana[_diaActualIndex],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: Icon(Icons.arrow_right,
                    color: Theme.of(context).primaryIconTheme.color),
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // PageView para los horarios
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _diasSemana.length,
            onPageChanged: (nuevoIndex) {
              setState(() {
                _diaActualIndex = nuevoIndex;
              });

              // Ajustar el índice para el efecto de "loop"
              if (nuevoIndex == 0) {
                // Si estamos en el primer "Sábado", saltar al último "Sábado"
                Future.microtask(() {
                  _pageController.jumpToPage(_diasSemana.length - 2);
                  setState(() {
                    _diaActualIndex = _diasSemana.length - 2;
                  });
                });
              } else if (nuevoIndex == _diasSemana.length - 1) {
                // Si estamos en el último "Domingo", saltar al primer "Domingo"
                Future.microtask(() {
                  _pageController.jumpToPage(1);
                  setState(() {
                    _diaActualIndex = 1;
                  });
                });
              }
            },
            itemBuilder: (context, index) {
              // Filtrar los horarios para el día actual
              final horarios = _horarioController.obtenerTodas().where((horario) {
                return horario.diasSemana.contains(_diasSemana[index]);
              }).toList();

              // Ordenar los horarios por hora de inicio
              horarios.sort((a, b) {
                final TimeOfDay horaInicioA =
                    _convertirStringATimeOfDay(a.horaInicio);
                final TimeOfDay horaInicioB =
                    _convertirStringATimeOfDay(b.horaInicio);
                return horaInicioA.hour.compareTo(horaInicioB.hour) != 0
                    ? horaInicioA.hour.compareTo(horaInicioB.hour)
                    : horaInicioA.minute.compareTo(horaInicioB.minute);
              });

              // Mostrar mensaje si no hay horarios
              if (horarios.isEmpty) {
                return Center(
                  child: Text(
                    'No hay horarios disponibles para este día.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              // Construir la lista de horarios
              return ListView.builder(
  itemCount: horarios.length,
  itemBuilder: (context, horarioIndex) {
    final horario = horarios[horarioIndex];
    final bool esActivo = _esHorarioActivo(horario.horaInicio, horario.horaFin);

    return Horariocontainer(
      nombreMateria: horario.materia.nombreMateria,
      horaInicio: horario.horaInicio,
      horaFin: horario.horaFin,
      colorMateria: horario.color,
      esActivo: esActivo,
      onEditar: () => _editarHorario(horario),
      onEliminar: () => _eliminarHorario(horario), // Pasar el objeto completo
    );
  },
);
            },
          ),
        ),
      ],
    );
  }
}