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

  Future<void> eliminarEvento(Evento evento) async {
    await _box.delete(evento.key);
  }

  Future<void> editarEvento(int index, Evento eventoActualizado) async {
    await _box.putAt(index, eventoActualizado);
  }

  Future<void> actualizarEvento(Evento evento) async {
  await evento.save();
  }
  
  List<Evento> obtenerEventosPorRango(DateTime inicio, DateTime fin) {
  return _box.values
      .where((evento) =>
          evento.fecha.isAfter(inicio.subtract(const Duration(days: 1))) &&
          evento.fecha.isBefore(fin.add(const Duration(days: 1))))
      .toList();
}
}