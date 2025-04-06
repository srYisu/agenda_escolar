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