import 'dart:convert';

import 'package:duvit/models/project_model.dart';
import 'package:http/http.dart' as http;

class ProjectsProvider {

  final String _url = "http://creandoproyectosexitosos.com/WEBSERVICE/v2";

  Future<List<ProjectListModel>> getProjects( int idStaff ) async {

    final url = '$_url/projects.php?idStaff=$idStaff';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProjectListModel> listProject = [];

    decodedData.forEach((id, project) {

      final projectTemp = ProjectListModel.fromJson(project);

      listProject.add( projectTemp );

    });

    return listProject;

  }

}