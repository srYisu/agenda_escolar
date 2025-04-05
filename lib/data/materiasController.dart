import 'package:hive/hive.dart';
import 'boxMaterias.dart'; // Asegúrate que este es tu modelo de Materia

class MateriaController {
  final Box<Materia> _box = Hive.box<Materia>('materias');

  List<Materia> obtenerTodas() {
    return _box.values.toList();
  }

  Future<void> agregarMateria(Materia materia) async {
    await _box.add(materia);
    print('Materia agregada: ${materia.nombreMateria}');
  }

  Future<void> eliminarMateria(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> editarMateria(int index, Materia materiaActualizada) async {
    await _box.putAt(index, materiaActualizada);
  }

  Materia? obtenerPorIndice(int index) {
    return _box.getAt(index);
  }

  int get cantidad => _box.length;
  
}