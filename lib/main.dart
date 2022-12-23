import 'package:duvit/screens/checkIn_screen.dart';
import 'package:duvit/screens/kpi_screen.dart';
import 'package:duvit/screens/preguntas.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:duvit/screens/screens.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(DuvitApp());
}

class DuvitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    var logeado = prefs.logeado;

    return MaterialApp(
      initialRoute: logeado == false ? '/login' : '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => LoginScreen(),
        '/map': (_) => MapScreen(),
        '/tasks': (_) => TasksScreen(),
        '/tasks_history': (_) => TasksHistoryScreen(),
        '/projects': (_) => ProjectsScreen(),
        '/project_tasks': (_) => ProjectTasksScreen(),
        '/project_members': (_) => ProjectMembersScreen(),
        '/info': (_) => InfoScreen(),
        '/cuestionario': (_) => CuestionarioPage(),
        '/CheckIn': (_) => Checkin(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}
