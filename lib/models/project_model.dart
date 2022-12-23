import 'dart:convert';

ProjectListModel projectListModelFromJson(String str) => ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) => json.encode(data.toJson());

class ProjectListModel {
    ProjectListModel({
        this.idProyecto = 0,
        this.nombreProyecto = "",
    });

    int idProyecto;
    String nombreProyecto;

    factory ProjectListModel.fromJson(Map<String, dynamic> json) => ProjectListModel(
        idProyecto     : json["idProyecto"],
        nombreProyecto : json["nombreProyecto"],
    );

    Map<String, dynamic> toJson() => {
        "idProyecto"     : idProyecto,
        "nombreProyecto" : nombreProyecto,
    };
}
