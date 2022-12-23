import 'package:duvit/providers/notifications.dart';
import 'package:duvit/screens/map_screen.dart';
import 'package:duvit/screens/projects_screen.dart';
import 'package:duvit/screens/screens.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:duvit/providers/tasks_provider.dart';
import 'package:duvit/screens/tasks_screen.dart';
import 'package:intl/intl.dart';
import 'package:duvit/providers/kpi_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  final tasksProvider = new TasksProvider();
  DateTime now = DateTime.now();

  @override
  @override
  void initState() {
    super.initState();

    notificationServices.initialiseNotifications();
    notification('type');
  }

  //Instance the shared preferences
  final prefs = new PreferenciasUsuario();

  int currentIndex = 1;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      drawer: _crearDrawer(),
      drawerEnableOpenDragGesture: false,
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(context),
      floatingActionButton: FloatingActionButton(
          elevation: 8.0, child: new Icon(Icons.add), onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void notification(String type) async {
    List<String> dates = [];
    List aux = [];
    List goodDates = [];
    List<String> finalDates = [];
    String formattedDate = DateFormat('dd-mm-yyyy').format(now);
    var resp = await tasksProvider.getTasks(prefs.idStaff, type);
    for (var i = 0; i < resp.length; i++) {
      dates.add(resp[i].fechaFin);
      aux = dates[i].split(",");
      for (var x = 0; x < dates.length; x++) {
        goodDates.add(aux[1]);
      }
      for (var y = 0; y < goodDates.length; y++) {
        finalDates.add(goodDates[i]
            .toString()
            .replaceAll('agosto-21', '08-2022')
            .replaceAll('septiembre-21', '09-2022')
            .replaceAll('octubre-21', '10-2022')
            .replaceAll('noviembre-21', '11-2022')
            .replaceAll('diciembre-21', '12-2022')
            .replaceAll('enero-21', '01-2022')
            .replaceAll('febrero-21', '02-2022')
            .replaceAll('marzo-21', '03-2022')
            .replaceAll('abril-21', '04-2022')
            .replaceAll('mayo-21', '05-2022')
            .replaceAll('junio-21', '06-2022')
            .replaceAll('julio-21', '07-2022')
            .replaceAll(' ', ''));

        if (DateFormat('dd-mm-yyyy')
            .parse(finalDates[i])
            .isAfter(DateFormat('dd-mm-yyyy').parse(formattedDate))) {
          notificationServices.sendNotification(
              title: "Alerta", body: "Tiene tareas que ya han caducado");
        }
      }
    }
  }

  Widget _crearBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      child: Container(
        height: 56,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  return globalKey.currentState!.openDrawer();
                }),
            IconButton(
              icon: Icon(Icons.add_location_alt_outlined),
              color: currentIndex == 1
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.checklist),
              color: currentIndex == 2
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.topic_outlined),
              color: currentIndex == 3
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 1:
        return MapScreen();
      case 2:
        return TasksScreen();
      case 3:
        return ProjectsScreen();

      default:
        return MapScreen();
    }
  }

  Widget _crearDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50.0,
              ),
            ),
            accountName: Text(prefs.name),
            accountEmail: Text(prefs.email.isNotEmpty
                ? prefs.email
                : 'Sin correo corporativo'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Profile Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.cached,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Recenceter"),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Acerca de nosotros"),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Configuración"),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Cerrar sesión"),
            onTap: () {
              prefs.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', ModalRoute.withName('/login'));
            },
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Cuestionario"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/cuestionario');
            },
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("CheckIn"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/CheckIn');
            },
          ),
        ],
      ),
    );
  }
}
