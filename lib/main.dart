import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 150, 100, 181),);

var kDarkColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 99, 155),);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true,
      colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8),
        ),),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,

          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
        ),),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        )
          ),
      themeMode: ThemeMode.system,


      home: Expenses(),
    );
  }
}