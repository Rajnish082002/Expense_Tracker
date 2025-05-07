import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/expenses.dart';

//->seting up as a global variable
var kcolorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
//
// ->to configure a dark theme
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
);
//
void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        // ->to set dark theme
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor:kDarkColorScheme.primaryContainer,
            ),
          ),
        ),
        // copyWith->preforming some default style with the some extra style
        theme: ThemeData().copyWith(
          useMaterial3: true,
          //->previous scheme(older approch)
          colorScheme: kcolorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kcolorScheme.onPrimaryContainer,
            foregroundColor: kcolorScheme.primaryContainer,
          ),
          cardTheme: CardTheme().copyWith(
            color: kcolorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kcolorScheme.onSecondaryContainer,
                  fontSize: 16,
                ),
              ),
        ),
        title: 'expenses tracker',
        // themeMode: ThemeMode.system,default
        home: Expenses()),
  );
}
