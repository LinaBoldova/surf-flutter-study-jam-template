import 'package:flutter/material.dart';

// ThemeData theme() {
//   return ThemeData(
//     focusColor: const Color.fromRGBO(47, 108, 38, 1),
//     backgroundColor: const Color.fromRGBO(253, 253, 247, 1),
//     scaffoldBackgroundColor: const Color.fromRGBO(253, 253, 247, 1),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color.fromRGBO(47, 108, 38, 1),
//     ),
//     colorScheme: const ColorScheme.light(primary: Color.fromRGBO(47, 108, 38, 1), surface: Color.fromRGBO(253, 253, 247, 1),)
//   );
// }

ThemeData theme() {
  return ThemeData(
    focusColor: const Color(0xff677DB7),
    backgroundColor: const Color.fromRGBO(253, 253, 247, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(253, 253, 247, 1),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff677DB7)),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff677DB7),
      surface: Color.fromRGBO(253, 253, 247, 1),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
      )
    )
  );
}
