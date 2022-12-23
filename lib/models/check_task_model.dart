import 'dart:convert';

CheckTaskModel checkTaskModelFromJson(String str) => CheckTaskModel.fromJson(json.decode(str));

String checkTaskModelToJson(CheckTaskModel data) => json.encode(data.toJson());

class CheckTaskModel {
  CheckTaskModel({
    this.id,
    required this.idPlaneacion,
    required this.idUser,
    required this.status,
  });

  int? id;
  int idPlaneacion;
  int idUser;
  String status;

  factory CheckTaskModel.fromJson(Map<String, dynamic> json) => CheckTaskModel(
        id: json["id"],
        idPlaneacion: json["idPlaneacion"],
        idUser: json["idUser"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idPlaneacion": idPlaneacion,
        "idUser": idUser,
        "status": status,
      };
}
