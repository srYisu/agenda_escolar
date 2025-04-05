import 'package:agenda_escolar/screen/movil/pantallaResumen.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/screen/movil/pantallaMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallaCalendario.dart';
import 'package:agenda_escolar/screen/movil/pantallaHorario.dart';
import 'package:agenda_escolar/main.dart';

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
              });
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor, // Cambiado para usar el color dinámico del tema
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor, // Cambiado para usar el color dinámico del tema
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor, // Cambiado para usar el color dinámico del tema
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Materias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Horario',
          ),
        ],
      ),
    );
  }
}