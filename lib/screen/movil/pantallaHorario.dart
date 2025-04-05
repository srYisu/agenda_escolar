import 'package:flutter/material.dart';
import 'package:agenda_escolar/data/horariosController.dart';
import 'package:agenda_escolar/src/botonAgregarHorario.dart';
import 'package:agenda_escolar/src/containerHorario.dart';

class Pantallahorario extends StatefulWidget {
  const Pantallahorario({super.key});

  @override
  State<Pantallahorario> createState() => _HorarioState();
}

class _HorarioState extends State<Pantallahorario> {
  final HorarioController _horarioController = HorarioController();
 late PageController _pageController;


  final List<String> _diasSemana = [
    "Domingo",
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
    "Lunes",
  ];
 int _diaActualIndex = 1;


  void _eliminarHorario(int index) {
    _horarioController.eliminarMateria(index);
    setState(() {}); // Actualizar la lista después de eliminar
  }

  void _editarHorario(int index) {
    final horario = _horarioController.obtenerPorIndice(index);
    if (horario != null) {
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
  }

 @override
  void initState() {
    super.initState();
    // Obtener el día actual y calcular el índice inicial
    final int diaActual = DateTime.now().weekday; // 1 = Lunes, 7 = Domingo
    _diaActualIndex = diaActual; // Ajustar al índice de la lista duplicada
    _pageController = PageController(initialPage: _diaActualIndex);
  }

  void _cambiarDia(int nuevoIndex) {
    setState(() {
      _diaActualIndex = nuevoIndex;
    });

    // Manejar el ciclo infinito
    if (nuevoIndex == 0) {
      // Si estamos en el primer "Domingo", saltar al último "Domingo"
      Future.microtask(() {
        _pageController.jumpToPage(_diasSemana.length - 2);
        setState(() {
          _diaActualIndex = _diasSemana.length - 2;
        });
      });
    } else if (nuevoIndex == _diasSemana.length - 1) {
      // Si estamos en el último "Lunes", saltar al primer "Lunes"
      Future.microtask(() {
        _pageController.jumpToPage(1);
        setState(() {
          _diaActualIndex = 1;
        });
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado con el día de la semana
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Theme.of(context).primaryIconTheme.color),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                Text(
                  _diasSemana[_diaActualIndex],
                  style: Theme.of(context).textTheme.bodyLarge
                ),
                IconButton(
                  icon:  Icon(Icons.arrow_right, color: Theme.of(context).primaryIconTheme.color),
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
    onPageChanged: _cambiarDia,
    itemBuilder: (context, index) {
      // Asegurar que los días se mapean correctamente
      final horarios = _horarioController.obtenerTodas().where((horario) {
        return horario.diasSemana.contains(_diasSemana[index]);
      }).toList();

      return ListView.builder(
        itemCount: horarios.length,
        itemBuilder: (context, horarioIndex) {
          final horario = horarios[horarioIndex];
          return Horariocontainer(
            nombreMateria: horario.materia.nombreMateria,
            horaInicio: horario.horaInicio,
            horaFin: horario.horaFin,
            colorMateria: horario.color,
            icon: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'Editar') {
                  _editarHorario(horarioIndex);
                } else if (value == 'Eliminar') {
                  _eliminarHorario(horarioIndex);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'Editar', child: Text('Editar')),
                const PopupMenuItem(value: 'Eliminar', child: Text('Eliminar')),
              ],
            ),
          );
        },
      );
    },
  ),
),
        ],
      ),
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
}