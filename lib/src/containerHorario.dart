import 'package:flutter/material.dart';

class Horariocontainer extends StatefulWidget {
  final String nombreMateria;
  final String horaInicio;
  final String horaFin;
  final Color colorMateria;
  final Widget? icon; // Nuevo parámetro opcional para el icono

  const Horariocontainer({
    super.key,
    required this.nombreMateria,
    required this.horaInicio,
    required this.horaFin,
    required this.colorMateria,
    this.icon, // Acepta un widget opcional para el icono
  });

  @override
  State<Horariocontainer> createState() => _HorariocontainerState();
}

class _HorariocontainerState extends State<Horariocontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Cambia la posición de la sombra
          ),
        ],
      ),
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, color: widget.colorMateria, size: 16),
                    const SizedBox(width: 10),
                    Text(
                      widget.nombreMateria,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "${widget.horaInicio} - ${widget.horaFin}",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          // Agregar el icono si está presente
          if (widget.icon != null) widget.icon!,
        ],
      ),
    );
  }
}