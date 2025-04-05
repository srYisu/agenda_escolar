import 'package:flutter/material.dart';
import 'package:agenda_escolar/main.dart';

class NavegacionInferior extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavegacionInferior({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: MyApp.isDarkModeNotifier,
      builder: (context, isDarkMode, _) {
        final theme = Theme.of(context).bottomNavigationBarTheme;
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.backgroundColor,
          selectedItemColor: theme.selectedItemColor,
          unselectedItemColor: theme.unselectedItemColor,
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Materias'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
            BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Horario'),
          ],
        );
      },
    );
  }
}