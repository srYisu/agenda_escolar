import 'package:agenda_escolar/data/boxEventos.dart';
import 'package:agenda_escolar/data/boxHorarios.dart';
import 'package:agenda_escolar/data/boxMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallInicio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agenda_escolar/src/colores.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MateriaAdapter());
  Hive.registerAdapter(HorarioAdapter());
  Hive.registerAdapter(EventoAdapter());

  await Hive.openBox<Materia>('materias');
  await Hive.openBox<Horario>('horarios');
  await Hive.openBox<Evento>('eventos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          theme: AppColors.getTheme(false),
          darkTheme: AppColors.getTheme(true),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const Pantallinicio(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}