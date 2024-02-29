import 'package:expense_tracker/widgets/expences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hive_flutter/adapters.dart';

var kColourScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 216, 170, 92),
);
// var kkDarkColourScheme = const ColorScheme.dark();

var kDarkColourScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() /*async*/ {
  // await Hive.initFlutter();
  // var box = await Hive.openBox("myBox");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(
        MaterialApp(
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: kDarkColourScheme,
            cardTheme: const CardTheme().copyWith(
              color: kDarkColourScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          theme: ThemeData().copyWith(
            useMaterial3: true,
            // scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
            colorScheme: kColourScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColourScheme.onPrimaryContainer,
              foregroundColor: kColourScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: kColourScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColourScheme.primaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge:
                      TextStyle(color: kColourScheme.onSecondaryContainer),
                ),
          ),
          themeMode: ThemeMode.system,
          home: const Expences(),
        ),
      ));
}
