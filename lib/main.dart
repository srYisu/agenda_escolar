import 'package:agenda_escolar/data/boxConfiguracion.dart';
import 'package:agenda_escolar/data/configuracionController.dart';
import 'package:agenda_escolar/data/boxEventos.dart';
import 'package:agenda_escolar/data/boxHorarios.dart';
import 'package:agenda_escolar/data/boxMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallInicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agenda_escolar/src/colores.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await initializeDateFormatting('es_ES', null); // Inicializar idioma español

  // Registrar adaptadores
  Hive.registerAdapter(MateriaAdapter());
  Hive.registerAdapter(HorarioAdapter());
  Hive.registerAdapter(EventoAdapter());
  Hive.registerAdapter(ConfiguracionAdapter());

  // Abrir cajas
  await Hive.openBox<Materia>('materias');
  await Hive.openBox<Horario>('horarios');
  await Hive.openBox<Evento>('eventos');
  try {
    await Hive.openBox<Configuracion>('configuracion');
  }   catch (e) {
    print('Error al abrir la caja de configuración: $e');
  }

  //await Hive.box('materias').clear();
  //await Hive.box('horarios').clear();
  //await Hive.box('eventos').clear();
  //await Hive.box('configuracion').clear();

  // Obtener configuración inicial
  final configuracionController = ConfiguracionController();
final configuracion = configuracionController.obtenerConfiguracion();
print('Modo oscuro inicial: ${configuracion.isDarkMode}');

 // Inicializar ValueNotifier para el modo oscuro
  MyApp.isDarkModeNotifier = ValueNotifier(configuracion.isDarkMode);

  runApp(MyApp(isDarkMode: configuracion.isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: MyApp.isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          theme: AppColors.getTheme(isDarkMode),
          darkTheme: AppColors.getTheme(isDarkMode),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Pantallinicio(),
          debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('es'), // Español
    Locale('en'), // Inglés, por si quieres fallback
  ],
  locale: Locale('es'), // Fuerza español (o usa LocaleSettings si es dinámico)
        );
      },
    );
  }

  static late final ValueNotifier<bool> isDarkModeNotifier;
}