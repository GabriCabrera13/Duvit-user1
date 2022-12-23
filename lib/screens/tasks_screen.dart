import 'package:duvit/models/task_model.dart';
import 'package:duvit/providers/tasks_provider.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import '../providers/kpi_provider.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final tasksProvider = new TasksProvider();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _crearAppBar(),
          body: TabBarView(
            children: [_tapViewTasks("get_all"), _tapViewTasks("get_by_start")],
          ),
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  PreferredSize _crearAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        bottom: TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.purple,
          tabs: [Tab(text: 'Tareas'), Tab(text: 'Comenzadas')],
        ),
        centerTitle: true,
        title: Text('Planeación', style: TextStyle(color: Colors.black)),
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.black87),
            tooltip: 'Historial de tareas',
            onPressed: () {
              Navigator.pushNamed(context, '/tasks_history');
            },
          ),
        ],
      ),
    );
  }

  Widget _tapViewTasks(String type) {
    return FutureBuilder(
        future: tasksProvider.getTasks(prefs.idStaff, type),
        builder:
            (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data;

            if (tasks!.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) =>
                      _itemTasks(context, tasks[index], index),
                ),
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                          type == 'get_all'
                              ? 'No cuenta con tareas pendientes'
                              : 'Sin tareas comenzadas\nComienza a realizar alguna tarea',
                          textAlign: TextAlign.center),
                      Icon(Icons.play_arrow_rounded, size: 40.0),
                    ],
                  ),
                ],
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _itemTasks(BuildContext context, TaskModel task, int index) {
    index = index + 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ExpansionTileCard(
        /*key: cardA,*/
        leading: CircleAvatar(child: Text("T0" + index.toString())),
        title:
            Text(task.proyecto, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Act. " + task.actividad + "\nTarea:" + task.tarea),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "Detalle: " + task.detalle,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "Fecha inicio: " +
                    task.fechaInicio +
                    "\nFecha fin: " +
                    task.fechaFin +
                    "\nFecha límite: " +
                    task.fechaLimite,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              TextButton(
                style: flatButtonStyle,
                onPressed: task.statusSeguimientoUser == "comenzar"
                    ? null
                    : () {
                        final response =
                            tasksProvider.checkTask(task.idPlaneacion, 0);
                        response.then((value) async {
                          if (value) {
                            showMessage(
                                "Se ha registrado el inicio de la tarea");
                          } else {
                            showMessage(
                                "Hemos tenido un problema al registrar el inicio");
                          }
                          //await Future.delayed(Duration(seconds: 3));
                          setState(() {});
                        });
                      },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.play_arrow_rounded),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Iniciar'),
                  ],
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: task.statusSeguimientoUser == "pausar" ||
                        task.statusSeguimientoUser != "comenzar"
                    ? null
                    : () {
                        final response =
                            tasksProvider.checkTask(task.idPlaneacion, 1);
                        response.then((value) async {
                          if (value) {
                            showMessage(
                                "Se ha registrado la pausa de la tarea");
                          } else {
                            showMessage(
                                "Hemos tenido un problema al registrar la pausa");
                          }
                          //await Future.delayed(Duration(seconds: 3));
                          setState(() {});
                        });
                      },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.pause_rounded),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Pausar'),
                  ],
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  final response =
                      tasksProvider.checkTask(task.idPlaneacion, 2);
                  response.then((value) async {
                    if (value) {
                      showMessage(
                          "Se ha registrado la finalización de la tarea");
                    } else {
                      showMessage(
                          "Hemos tenido un problema al registrar la finalización");
                    }
                    //await Future.delayed(Duration(seconds: 3));
                    setState(() {});
                  });
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.stop_rounded),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Finalizar'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
