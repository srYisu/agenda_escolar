import 'package:flutter/material.dart';

class Horariocontainer extends StatefulWidget {
  final String nombreMateria;
  final String horaInicio;
  final String horaFin;
  final Color colorMateria;
  final bool esActivo; // Indica si el horario está activo
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const Horariocontainer({
    super.key,
    required this.nombreMateria,
    required this.horaInicio,
    required this.horaFin,
    required this.colorMateria,
    required this.esActivo,
    required this.onEditar,
    required this.onEliminar,
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
        color: Theme.of(context).cardColor,
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
          // Ícono dinámico (relleno si está activo, vacío si no)
          Icon(
            widget.esActivo ? Icons.circle : Icons.circle_outlined,
            color: widget.colorMateria,
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
              children: [
                Text(
                  widget.nombreMateria,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  "${widget.horaInicio} - ${widget.horaFin}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          // Menú desplegable para editar y eliminar
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'Editar') {
                widget.onEditar();
              } else if (value == 'Eliminar') {
                widget.onEliminar();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Editar', child: Text('Editar')),
              const PopupMenuItem(value: 'Eliminar', child: Text('Eliminar')),
            ],
          ),
        ],
      ),
    );
  }
}