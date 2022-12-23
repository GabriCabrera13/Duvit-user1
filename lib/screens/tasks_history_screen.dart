import 'package:duvit/models/task_model.dart';
import 'package:duvit/providers/tasks_provider.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

class TasksHistoryScreen extends StatelessWidget {

  final tasksProvider = new TasksProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _crearAppBar( context ),
      body:  _crearListado(),
    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: tasksProvider.getTasks(prefs.idStaff, 'get_by_end'),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {

        final tasks = snapshot.data;

        if (snapshot.hasData) {
          if ( tasks!.isNotEmpty ) {
            return Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, i) => _crearItem( tasks[i] ),
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done,
                      size: 40.0,
                    ),
                    SizedBox(height: 8.0),
                    Text( 'Aún no cuenta con alguna tarea terminada', textAlign: TextAlign.center),
                  ],
                ),
              ],
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem( TaskModel task ) {

    return Card(
      key: ValueKey(task.idPlaneacion),
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          bottomLeft: Radius.circular(26.0),
          bottomRight: Radius.circular(26.0),
          topRight: Radius.circular(26.0)
        ),
      ),
      elevation: 0.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
          title: Text(
            'Tarea: ${task.tarea}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                height: 60,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0)),
                ),
              ),
              new Flexible(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          text: 'Act. ${task.actividad}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      SizedBox(height: 2.0),
                      RichText(
                        text: TextSpan(
                          text: 'Detalle: ${task.detalle}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      ),
                      SizedBox(height: 2.0),
                      RichText(
                        text: TextSpan(
                          text: 'Proyecto: ${task.proyecto}',
                          style: TextStyle(color: Colors.black54),
                        ),
                        maxLines: 3,
                        softWrap: true,
                      )
                    ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _crearAppBar( BuildContext context ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text( 'Historial', style: TextStyle(color: Colors.black))
          ],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            color: Colors.black87,
            icon: Icon(
              Icons.close,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

  }

}
