import 'package:agenda_escolar/screen/movil/pantallaResumen.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/screen/movil/pantallaMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallaCalendario.dart';
import 'package:agenda_escolar/screen/movil/pantallaHorario.dart';
import 'package:agenda_escolar/main.dart';
import 'package:agenda_escolar/src/navegacionInferior.dart';

class Pantallinicio extends StatefulWidget {
  const Pantallinicio({super.key});

  @override
  State<Pantallinicio> createState() => _PantallinicioState();
}

class _PantallinicioState extends State<Pantallinicio> {
  int _currentIndex = 0;


  // Lista de pantallas para cada pestaña
  final List<Widget> _screens = [
    Pantallaresumen(),
    Pantallamaterias(),
    Pantallacalendario(),
    Pantallahorario(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          _currentIndex == 0
              ? 'Resumen'
              : _currentIndex == 1
                  ? 'Materias'
                  : _currentIndex == 2
                      ? 'Calendario'
                      : 'Horario',
          style: Theme.of(context).textTheme.bodyLarge,
          
        ),
        actions: [
          IconButton(
            icon: Icon(
              MyApp.isDarkModeNotifier.value ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {
                MyApp.isDarkModeNotifier.value = !MyApp.isDarkModeNotifier.value;
                print('Background color: ${Theme.of(context).bottomNavigationBarTheme.backgroundColor}');
                print('Selected item color: ${Theme.of(context).bottomNavigationBarTheme.selectedItemColor}');
                print('Unselected item color: ${Theme.of(context).bottomNavigationBarTheme.unselectedItemColor}');
              });
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavegacionInferior(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
),
    );
  }
}