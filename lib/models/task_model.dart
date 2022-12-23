import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {

  TaskModel({
    this.idPlaneacion     = 0,
    this.actividad        = "",
    this.tarea            = "",
    this.detalle          = "",
    this.idEstatusTarea   = 0,
    this.idProyecto       = 0,
    this.proyecto         = "",
    this.statusPlaneacion = "",
    this.statusSeguimientoUser = "",
    this.fechaInicio      = "",
    this.fechaFin         = "",
    this.fechaLimite      = ""

  });

  int idPlaneacion;
  String actividad;
  String tarea;
  String detalle;
  int idEstatusTarea;
  int idProyecto;
  String proyecto;
  String statusPlaneacion;
  String statusSeguimientoUser;
  String fechaInicio;
  String fechaFin;
  String fechaLimite;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        idPlaneacion     : json["idPlaneacion"],
        actividad        : json["actividad"],
        tarea            : json["tarea"],
        detalle          : json["detalle"],
        idEstatusTarea   : json["idEstatusTarea"],
        idProyecto       : json["idProyecto"],
        proyecto         : json["proyecto"],
        statusPlaneacion : json["statusPlaneacion"],
        statusSeguimientoUser : json["statusSeguimientoUser"],
        fechaInicio      : json["fechaInicio"],
        fechaFin         : json["fechaFin"],
        fechaLimite      : json["fechaLimite"],
      );

  Map<String, dynamic> toJson() => {
        "idPlaneacion"     : idPlaneacion,
        "actividad"        : actividad,
        "tarea"            : tarea,
        "detalle"          : detalle,
        "idEstatusTarea"   : idEstatusTarea,
        "idProyecto"       : idProyecto,
        "proyecto"         : proyecto,
        "statusPlaneacion" : statusPlaneacion,
        "statusSeguimientoUser" : statusSeguimientoUser,
        "fechaInicio"      : fechaInicio,
        "fechaFin"         : fechaFin,
        "fechaLimite"      : fechaLimite,
      };
}
