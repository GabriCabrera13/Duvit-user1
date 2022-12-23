import 'package:flutter/material.dart';

  Widget ventanaDato(data, index, titulo, titulo2, subtitulo, subtitulo2) {
    return ListTile(
      title: Text("$titulo ${data["datos"][index][titulo2]}"),
      subtitle: SizedBox(
        child: Text("$subtitulo ${data["datos"][index][subtitulo2]}"),
      ),
    );
  }