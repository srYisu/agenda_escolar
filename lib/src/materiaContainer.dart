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
        color: Colors.white,
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
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      "Profesor: ",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.nombreProfesor,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      "Salon de clases: ",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.salonClases,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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