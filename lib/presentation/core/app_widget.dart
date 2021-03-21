import 'package:flutter/material.dart';
import 'package:notes2/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes 2',
      home: SignInPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        accentColor: Colors.blueAccent,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.amberAccent,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
