import 'package:agenda_escolar/data/configuracionController.dart';
import 'package:agenda_escolar/main.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/screen/movil/pantallaCalendario.dart';
import 'package:agenda_escolar/screen/movil/pantallaHorario.dart';
import 'package:agenda_escolar/screen/movil/pantallaMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallaResumen.dart';

class Pantallinicio extends StatefulWidget {
  const Pantallinicio({super.key});

  @override
  State<Pantallinicio> createState() => _PantallinicioState();
}

class _PantallinicioState extends State<Pantallinicio> {
  final ConfiguracionController _configuracionController =
      ConfiguracionController();

  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Pantallaresumen(),
    const Pantallamaterias(),
    const Pantallacalendario(),
    const Pantallahorario(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
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
            onPressed: () async {
              final isDarkMode = !MyApp.isDarkModeNotifier.value;
              MyApp.isDarkModeNotifier.value = isDarkMode;
              await _configuracionController.actualizarModoOscuro(isDarkMode);
              print('Modo oscuro actualizado: $isDarkMode');
            },
          ),
        ],
      ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              unselectedIconTheme: IconThemeData(
                color: Theme.of(context).iconTheme.color,
              ),
              selectedLabelTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
              unselectedLabelTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).iconTheme.color),
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Resumen'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.book),
                  label: Text('Materias'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.calendar_today),
                  label: Text('Calendario'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.schedule),
                  label: Text('Horario'),
                ),
              ],
            ),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Resumen'),
                BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Materias'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
                BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Horario'),
              ],
            ),
    );
  }
}