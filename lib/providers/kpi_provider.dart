import 'dart:convert';

import 'package:http/http.dart' as http;

class CuestionarioData {
  CuestionarioData();

  Future<Map<dynamic, dynamic>> getInversion() async {
    final response = await http.get(
        Uri.parse(
            "http://creandoproyectosexitosos.com/WEBSERVICE/cuestionariosFlutter.php"),
        headers: {"Content-Type": "application/json"});
    try {
      if (response.statusCode == 200) {
        // ignore: avoid_print
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        // print(response.body);
        // print(jsonResponse["datos"]);
        return jsonResponse;
      } else {
        return {};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<dynamic, dynamic>> getKpis(int id) async {
    final response = await http.get(
        Uri.parse(
            "http://creandoproyectosexitosos.com/WEBSERVICE/traerCuestionariosF.php?id=$id"),
        headers: {"Content-Type": "application/json"});
    try {
      if (response.statusCode == 200) {
        // ignore: avoid_print
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        // print(response.body);
        // print(jsonResponse["datos"]);
        return jsonResponse;
      } else {
        return {};
      }
    } catch (e) {
      return {"error": e};
    }
  }
}
