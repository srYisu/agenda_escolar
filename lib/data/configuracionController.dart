import 'package:hive/hive.dart';
import 'boxConfiguracion.dart';

class ConfiguracionController {
  final Box<Configuracion> _box = Hive.box<Configuracion>('configuracion');

  Configuracion obtenerConfiguracion() {
    if (_box.isEmpty) {
      // Si no hay configuración guardada, crear una por defecto
      final configuracion = Configuracion(isDarkMode: false);
      _box.add(configuracion);
      return configuracion;
    }
    return _box.values.first;
  }

  Future<void> actualizarModoOscuro(bool isDarkMode) async {
    final configuracion = obtenerConfiguracion();
    configuracion.isDarkMode = isDarkMode;
    await configuracion.save();
  }
}