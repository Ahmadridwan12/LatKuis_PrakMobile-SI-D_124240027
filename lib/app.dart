import 'package:flutter/material.dart';

import 'pages/login_page.dart';

class AnimalAtlasApp extends StatelessWidget {
  const AnimalAtlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF24594D);
    const ink = Color(0xFF202B27);

    return MaterialApp(
      title: 'Fauna Atlas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: const Color(0xFFD47A55),
          surface: const Color(0xFFFCFCF7),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F5EF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F5EF),
          foregroundColor: ink,
          centerTitle: false,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E5DC)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE1E5DC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: forest, width: 1.5),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE7E9E1)),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
