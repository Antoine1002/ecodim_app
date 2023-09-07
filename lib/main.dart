import 'package:ecodim_app/screens/auth_page.dart';
// import 'package:ecodim_app/screens/cours_biblique/cours_biblique.dart';
import 'package:flutter/material.dart';
import 'package:ecodim_app/screens/page_dacceuil.dart';
import 'package:ecodim_app/screens/quizz/facil.dart';
import 'package:ecodim_app/screens/quizz/normal.dart';
import 'package:ecodim_app/screens/quizz/difficile.dart';
import 'package:ecodim_app/screens/quizz/level_page.dart';
import 'package:ecodim_app/screens/evenements/events.dart';
import 'package:ecodim_app/menu/parametres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App with Routes',
      initialRoute: '/', // Route initiale
      routes: {
        '/': (context) => const AuthPage(), // Page d'accueil
        'main': (context) => const Acceuil(), // Page de publication
        'levelpage': (context) => const LevelPage(),
        'facile': (context) => FacileLevel(),
        'normal': (context) => NormalLevel(),
        'difficile': (context) => DifficileLevel(),
        'evenements': (context) => EvenementPage(),
        'parametre': (context) => Parmetre(),
        // 'cours': (context) => const Cours_biblique(),
      },
    );
  }
}
