import 'package:hive/hive.dart';
import 'boxHorarios.dart'; // Asegúrate que este es tu modelo de Materia

class HorarioController {
  final Box<Horario> _box = Hive.box<Horario>('horarios');

  List<Horario> obtenerTodas() {
    return _box.values.toList();
  }

  Future<void> agregarMateria(Horario hora) async {
    await _box.add(hora);
    print('Horario agregado: ${hora.materia} ${hora.horaInicio} - ${hora.horaFin}');
  }

  Future<void> eliminarMateria(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> editarMateria(int index, Horario horarioActualizado) async {
    await _box.putAt(index, horarioActualizado);
  } 

  Horario? obtenerPorIndice(int index) {
    return _box.getAt(index);
  }

  int get cantidad => _box.length;
}