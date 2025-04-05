import 'package:hive/hive.dart';
import 'boxEventos.dart';

class EventosController {
  final Box<Evento> _box = Hive.box<Evento>('eventos');

  List<Evento> obtenerEventosPorFecha(DateTime fecha) {
    return _box.values
        .where((evento) =>
            evento.fecha.year == fecha.year &&
            evento.fecha.month == fecha.month &&
            evento.fecha.day == fecha.day)
        .toList();
  }

  Future<void> agregarEvento(Evento evento) async {
    await _box.add(evento);
  }

  Future<void> eliminarEvento(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> editarEvento(int index, Evento eventoActualizado) async {
    await _box.putAt(index, eventoActualizado);
  }
}