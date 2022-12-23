import 'dart:convert';
import 'package:duvit/models/task_model.dart';
import 'package:http/http.dart' as http;

class TasksProvider {
  final String _url = "http://creandoproyectosexitosos.com/WEBSERVICE/v2";

  Future<List<TaskModel>> getTasks(int idStaff, String type) async {
    // Type get_all      = Todas las tareas by idStaff
    // Type get_by_end   = Todas las tareas terminadas by idStaff
    // Type get_by_start = Todas las tareas empezadas by idStaff

    final url = '$_url/tasks.php?idStaff=$idStaff&type=$type';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<TaskModel> listTask = [];

    decodedData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      listTask.add(taskTemp);
    });
    
    return listTask;
  }

  Future<List<TaskModel>> getTasksByIdProject(
      int idStaff, int idProyecto) async {
    final url =
        '$_url/tasks.php?idStaff=$idStaff&type=get_by_project&idProyecto=$idProyecto';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<TaskModel> listTask = [];

    decodedData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      listTask.add(taskTemp);
    });
    return listTask;
  }

  Future<bool> checkTask(int idPlaneacion, int tipo) async {
    final url = '$_url/check-tasks.php?idPlaneacion=$idPlaneacion&tipo=$tipo';

    final response = await http.get(Uri.parse(url));
    final decodedData = json.decode(response.body);

    if (decodedData['ok']) {
      return true;
    } else {
      return false;
    }
  }
}
