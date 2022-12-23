import 'dart:convert';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
  MemberModel({
    this.idProyecto = 0,
    this.nombreProyecto = "",
    this.nombre = "",
    this.apellidoPaterno = "",
    this.telefonoCelular = "",
    this.correoCorporativo = "",
  });

  int idProyecto;
  String nombreProyecto;
  String nombre;
  String apellidoPaterno;
  String telefonoCelular;
  String correoCorporativo;

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        idProyecto        : json["idProyecto"],
        nombreProyecto    : json["nombreProyecto"],
        nombre            : json["nombre"],
        apellidoPaterno   : json["apellidoPaterno"],
        telefonoCelular   : json["telefonoCelular"],
        correoCorporativo : json["correoCorporativo"],
      );

  Map<String, dynamic> toJson() => {
        "idProyecto"        : idProyecto,
        "nombreProyecto"    : nombreProyecto,
        "nombre"            : nombre,
        "apellidoPaterno"   : apellidoPaterno,
        "telefonoCelular"   : telefonoCelular,
        "correoCorporativo" : correoCorporativo,
      };
}
