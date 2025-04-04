import 'package:agenda_escolar/data/boxHorarios.dart';
import 'package:agenda_escolar/data/boxMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallInicio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MateriaAdapter());
  Hive.registerAdapter(HorarioAdapter());

  await Hive.openBox<Materia>('materias');
  await Hive.openBox<Horario>('horarios');

  runApp(MaterialApp(
    home: Pantallinicio(),
    debugShowCheckedModeBanner: false,
  ));
}