import 'package:agenda_escolar/data/boxMaterias.dart';
import 'package:agenda_escolar/screen/movil/pantallInicio.dart';
import 'package:agenda_escolar/screen/movil/pantallaMaterias.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MateriaAdapter());

  await Hive.openBox<Materia>('materias');

  runApp(MaterialApp(
    home: Pantallinicio(),
    debugShowCheckedModeBanner: false,
  ));
}


