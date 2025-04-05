import 'package:flutter/material.dart';

class materiasContaioner extends StatefulWidget {
  final Color colorMateria;
  final String nombreMateria;
  final String nombreProfesor;
  final String salonClases;
  const materiasContaioner({super.key, required this.colorMateria, required this.nombreMateria, required this.salonClases, required this.nombreProfesor});

  @override
  State<materiasContaioner> createState() => _materiasContaionerState();
}

class _materiasContaionerState extends State<materiasContaioner> {
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
            offset: const Offset(0, 3), // changes position of shadow
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
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Profesor: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      widget.nombreProfesor,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Salon de clases: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      widget.salonClases,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}