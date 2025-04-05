import 'package:hive_flutter/hive_flutter.dart';

part 'boxConfiguracion.g.dart';

@HiveType(typeId: 3)
class Configuracion extends HiveObject{
  @HiveField(0)
  bool isDarkMode;

  Configuracion({
    required this.isDarkMode,
  });
}