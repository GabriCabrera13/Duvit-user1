import 'package:duvit/screens/preguntas.dart';
import 'package:flutter/material.dart';
import '../providers/kpi_provider.dart';
import '../widgets/ventana_datos.dart';

void main() => runApp(const CuestionarioPage());

class CuestionarioPage extends StatefulWidget {
  const CuestionarioPage({key});

  @override
  State<CuestionarioPage> createState() => _CuestionarioPageState();
}

class _CuestionarioPageState extends State<CuestionarioPage> {
  var db = CuestionarioData();

  @override
  Widget build(BuildContext context) {
    db.getInversion();
    final Size size = MediaQuery.of(context).size;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Cuestionarios'),
              backgroundColor: Colors.purple,
            ),
            // body: Container(),
            body: Container(
                // color: ColorSelect.container,
                width: size.width,
                height: double.infinity,
                child: FutureBuilder(
                  initialData: const [],
                  future: db.getInversion(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('Waiting for connection');
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        print('There is no data');
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        Map<dynamic, dynamic> data = snapshot.data;
                        return RefreshIndicator(
                            // child: const Text('WELCOME LIST'),
                            child: ListView.builder(
                              itemCount: data["datos"].length,
                              itemBuilder: (context, index) => Card(
                                  color: Colors.black,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Preguntas(
                                                  data["datos"][index]['idCuestionario']
                                                      )));
                                    },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          ventanaDato(
                                              data,
                                              index,
                                              "",
                                              "nombreCuestionario",
                                              "Descripción: ",
                                              "descripcion"),
                                          ListTile(
                                            title: Text("Fecha alta:"),
                                            subtitle: Text(
                                                "${data["datos"][index]["fechaAlta"]}"),
                                          ),
                                          ListTile(
                                            title: Text("Fecha fin:"),
                                            subtitle: Text(
                                                "${data["datos"][index]["fechaFin"]}"),
                                          ),
                                          ListTile(
                                            title: Text("Fecha inicio:"),
                                            subtitle: Text(
                                                "${data["datos"][index]["FechaInicio"]}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            onRefresh: () async {
                              setState(() {});
                            });
                      }
                    }
                  },
                ))));
  }
}
