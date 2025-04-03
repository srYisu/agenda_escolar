import 'package:agenda_escolar/screen/movil/pantallaResumen.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/src/colores.dart';
import 'package:agenda_escolar/screen/movil/pantallaMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallaCalendario.dart';
import 'package:agenda_escolar/screen/movil/pantallaHorario.dart';

class Pantallinicio extends StatefulWidget {
  const Pantallinicio({super.key});

  @override
  State<Pantallinicio> createState() => _PantallinicioState();
}

class _PantallinicioState extends State<Pantallinicio> {
  int _currentIndex = 0;

  // Lista de pantallas para cada pestaña
  final List<Widget> _screens = [
    Pantallaresumen(), // Pantalla de Horario
    Pantallamaterias(),
    Pantallacalendario(), // Pantalla de Resumen
    Pantallahorario(), // Pantalla de Calendario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores().colorPrimario,
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Resumen'
              : _currentIndex == 1
                  ? 'Materias'
                  :_currentIndex == 2
                  ? 'Calendario' // Cambiar el título según la pestaña seleccionada
                  : 'Horario',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colores().colorPrimario,
      ),
      body: _screens[_currentIndex], // Mostrar la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice de la pestaña seleccionada
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cambiar la pestaña seleccionada
          });
        },
        backgroundColor: Colores().colorPrimario,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
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