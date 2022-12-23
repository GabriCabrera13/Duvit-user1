import 'dart:convert';

KpiModel kpiModelFromJson(String str) => KpiModel.fromJson(json.decode(str));

String kpiModelToJson(KpiModel data) => json.encode(data.toJson());

class KpiModel {
  KpiModel(
      {this.idCuestionario = 0,
      this.nombreCuestionario = "",
      this.descripcion = "",
      this.fechaAlta = "",
      this.fechaFin = "",
      this.FechaInicio = "",
      this.idTipoCuestionario = 0,
      this.idEstatus = 0,
     });

  int idCuestionario;
  String nombreCuestionario;
  String descripcion;
  String fechaAlta;
  String fechaFin;
  String FechaInicio;
  int idTipoCuestionario;
  int idEstatus;
  

  factory KpiModel.fromJson(Map<String, dynamic> json) => KpiModel(
        idCuestionario: json["idCuestionario"],
        nombreCuestionario: json["nombreCuestionario"],
        descripcion: json["descripcion"],
        fechaAlta: json["fechaAlta"],
        fechaFin: json["fechaFin"],
        FechaInicio: json["FechaInicio"],
        idTipoCuestionario: json["idTipoCuestionario"],
        idEstatus: json["idEstatus"],
      );

  Map<String, dynamic> toJson() => {
        "idCuestionario": idCuestionario,
        "nombreCuestionario": nombreCuestionario,
        "descripcion": descripcion,
        "fechaAlta": fechaAlta,
        "fechaFin": fechaFin,
        "FechaInicio": FechaInicio,
        "idTipoCuestionario": idTipoCuestionario,
        "idEstatus": idEstatus,
        
      };
}
