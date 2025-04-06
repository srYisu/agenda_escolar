import 'package:flutter/material.dart';

class AppColors {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF4F6FB),
    primaryColor: const Color(0xFFD2DCF2),
    cardColor: Colors.white,
    shadowColor:   Color(0xFFB7C9E2),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500)
    ),
    primaryTextTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),
    ),
    canvasColor: Colors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    ),
    
    timePickerTheme: const TimePickerThemeData(
          backgroundColor: Color(0xFFF4F6FB), //fono general
          hourMinuteColor: Color.fromARGB(255, 195, 180, 235),
          hourMinuteTextColor: Colors.black, //color de los numeros
          dialBackgroundColor: Colors.white, //fundillo del reloj
          dialHandColor: Color.fromARGB(255, 162, 137, 230), //color del circulito
          dayPeriodColor: Color.fromARGB(255, 162, 137, 230), //la pendejea de amPM
          dialTextColor: Colors.black, //color de los numeros del reloj
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: const Color(0xFFF4F6FB),
      headerBackgroundColor: const Color.fromARGB(255, 195, 180, 235),
      headerForegroundColor: Colors.black,
      dayForegroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white; // Texto del día seleccionado
          }
          return Colors.black; // Texto de otros días
        },
      ),
      dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color.fromARGB(255, 162, 137, 230); // Fondo del día seleccionado
          }
          return Colors.white; // Fondo de otros días
        },
      ),
      todayForegroundColor: const MaterialStatePropertyAll(Colors.white),
      todayBackgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 162, 137, 230)),
      yearForegroundColor: const MaterialStatePropertyAll(Colors.black),
      yearBackgroundColor: const MaterialStatePropertyAll(Colors.white),
    ),

    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black)
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFFD2DCF2),
    cardColor: const Color(0xFF2A2A2A),
    shadowColor:   Color.fromARGB(255, 71, 100, 139),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
    ),
    primaryTextTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
    ),

    timePickerTheme: const TimePickerThemeData(
        backgroundColor: Color(0xFF121212), //fono general
        hourMinuteTextColor: Colors.black, //color de los numeros
        hourMinuteColor: Color.fromARGB(255, 173, 151, 233),
        dialBackgroundColor: Color.fromARGB(255, 104, 103, 103), //fundillo del reloj
        dialHandColor: Color.fromARGB(255, 173, 151, 233), //color del circulito
        dayPeriodColor: Color.fromARGB(255, 173, 151, 233), //la pendejea de amPM
        dialTextColor: Colors.black, //color de los numeros del reloj
        entryModeIconColor: Colors.deepPurpleAccent,
        dayPeriodTextColor: Colors.white, //color de la pendejea de amPM
    ),

datePickerTheme: DatePickerThemeData(
  backgroundColor: const Color(0xFF121212), // Fondo del diálogo
  headerBackgroundColor: const Color.fromARGB(255, 173, 151, 233), // Cabecera púrpura
  headerForegroundColor: Colors.white, // Texto del mes/año

  /// 💬 Texto principal de la cabecera (ej: "sab, 5 abr")
  headerHeadlineStyle: const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),

  /// 💬 Texto auxiliar de la cabecera (opcional)
  headerHelpStyle: const TextStyle(
    color: Colors.white70,
    fontSize: 14,
  ),

  /// 🔢 Texto de los días (L, M, M, J, V, S, D)
  weekdayStyle: const TextStyle(
    color: Colors.white,
  ),

  /// 🗓 Texto de cada día numérico
  dayForegroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.black; // Texto del día seleccionado
      }
      return Colors.white; // Texto de otros días
    },
  ),

  /// 🎨 Fondo de los días
  dayBackgroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Color.fromARGB(255, 195, 182, 233); // Día seleccionado
      }
      return const Color(0xFF2A2A2A); // Fondo normal
    },
  ),

  /// 📅 Hoy
  todayForegroundColor: const MaterialStatePropertyAll(Colors.black),
  todayBackgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 195, 182, 233)),

  /// 📆 Selector de año
  yearForegroundColor: const MaterialStatePropertyAll(Colors.white),
  yearBackgroundColor: const MaterialStatePropertyAll(Color(0xFF2A2A2A)),
),
    canvasColor: Colors.deepPurpleAccent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white)

  );

  static ThemeData getTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}