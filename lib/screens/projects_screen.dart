import 'package:duvit/models/project_model.dart';
import 'package:duvit/providers/projects_provider.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {

  final projectsProvider = new ProjectsProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar( context ),
      body:  _crearListado(),
    );
  }

  PreferredSize _crearAppBar( BuildContext context ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text( 'Proyectos', style: TextStyle(color: Colors.black))
          ],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
    );

  }

  Widget _crearListado() {

    return FutureBuilder(
      future: projectsProvider.getProjects( prefs.idStaff ),
      builder: (BuildContext context, AsyncSnapshot<List<ProjectListModel>> snapshot) {

        final projects = snapshot.data;

        if (snapshot.hasData) {
          if ( projects!.isNotEmpty ) {
            return Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, i) => _crearItemProject( context, projects[i] ),
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
                      Icons.sentiment_very_dissatisfied,
                      size: 40.0,
                    ),
                    SizedBox(height: 8.0),
                    Text( 'Aún no está relacionado a algún proyecto', textAlign: TextAlign.center),
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

  Widget _crearItemProject( BuildContext context, ProjectListModel project ) {

    return Card(
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
            project.nombreProyecto,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.format_list_bulleted,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/project_tasks', arguments: project);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.group,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/project_members', arguments: project);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}