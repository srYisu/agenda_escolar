import 'package:hive/hive.dart';
import 'boxEventos.dart'; // Asegúrate que este es tu modelo de Materia

class EventosController {
  final Box<Evento> _box = Hive.box<Evento>('materias');

  List<Evento> obtenerTodas() {
    return _box.values.toList();
  }

  Future<void> agregarMateria(Evento even) async {
    await _box.add(even);
    print('Materia agregada: ${even.titulo}');
  }

  Future<void> eliminarMateria(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> editarMateria(int index, Evento eventoActualizado) async {
    await _box.putAt(index, eventoActualizado);
  }

  Evento? obtenerPorIndice(int index) {
    return _box.getAt(index);
  }

  int get cantidad => _box.length;
}