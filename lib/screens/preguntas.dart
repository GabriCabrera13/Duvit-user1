import 'package:duvit/widgets/ventana_pregunta.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../providers/kpi_provider.dart';

class Preguntas extends StatefulWidget {
  Preguntas(this.idCuestionario);

  final idCuestionario;
  TextEditingController _controller = new TextEditingController();
  @override
  State<Preguntas> createState() => _PreguntasState();
}

class _PreguntasState extends State<Preguntas> {
  @override
  var db = CuestionarioData();
  bool isChecked = false;
  String _dropdownValue = 'No';
  Rx<List<String>> selectedOptionsList = Rx<List<String>>([]);
  var selectOpcion = ''.obs;
  late Future<Map<dynamic, dynamic>> _fetchAndSetFuture;
  Map valuesChoiceBox = {};
  Map valuesChoiceBox2 = {};

  void initState() {
    super.initState();
    _fetchAndSetFuture = db.getKpis(int.parse(widget.idCuestionario));
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cuestionarios'),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          //  color: ColorSelect.container,
          width: size.width,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                (
                    //
                    FutureBuilder(
                  initialData: const [],
                  future: _fetchAndSetFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('Waiting for connection');
                      return const Center();
                    } else {
                      if (!snapshot.hasData) {
                        return Text('There is no data');
                      } else {
                        Map<dynamic, dynamic> data = snapshot.data;
                        print('/////////////////////////');
                        var band = '';

                        for (var element in data['datos']) {
                          List listaDatos = element.keys.toList();

                          if (listaDatos.contains('Respuesta')) {
                            print(element['Respuesta']);
                          }
                          // if (element.keys =) {

                          // }
                        }
                        // print(data['datos'][3]['Respuesta'][1]);
                        return Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: data["datos"].length - 1,
                              itemBuilder: (context, index) => Card(
                                    // semanticContainer: false,
                                    elevation: 0,

                                    color: data["datos"][index]
                                                    ["idTipoPregunta"]
                                                .toString() ==
                                            '3'
                                        ? Colors.white
                                        : Color.fromRGBO(156, 39, 176, 1),
                                    // color: Color.fromRGBO(156, 39, 176, 1),
                                    child: cards(
                                        data["datos"][index]['idTipoPregunta']
                                            .toString(),
                                        data["datos"][index]['pregunta']
                                            .toString(),
                                        data["datos"][index]['idPregunta']
                                            .toString(),
                                        index,
                                        data),
                                  )),
                        );
                      }
                    }
                  },
                )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  onPressed: () {},
                  child: Text('Enviar'),
                )
              ],
            ),
          ),
        ));
  }

  Widget cards(String idTipoPregunta, String pregunta, String idPregunta,
      int index, dynamic dataRespuesta) {
    late Widget card_return = Card();

    if (idTipoPregunta == '1') {
      String idPregunta1 = 'pregunta1-' + index.toString();
      print('escribir');
      card_return = Card(
        child: Column(
          children: [
            ListTile(
              title: Text("Pregunta: $idPregunta"),
              subtitle: Column(
                children: [
                  Text("$pregunta"),
                  TextController(
                    valueChoiceText: (String value) {
                      valuesChoiceBox[idPregunta1] = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      valuesChoiceBox[idPregunta1] = '';
      print(valuesChoiceBox);
    }

    if (idTipoPregunta == '2') {
      List Respuesta = dataRespuesta['datos'][index + 1]['Respuesta'].toList();
      print('RESPUESTA');
      print(Respuesta);
      String idPregunta3 = 'pregunta3-' + index.toString();
      card_return = Card(
        child: Column(
          children: [
            ListTile(
              title: Text("Pregunta: $idPregunta"),
              subtitle: Column(
                children: [
                  Text("$pregunta"),
                  ChoiseBoxe2(
                    valueChoice2: (String value) {
                      valuesChoiceBox2[idPregunta3] = value;
                    },
                    respuestas: Respuesta,
                    index: index,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (idTipoPregunta == '4') {
      String idPregunta2 = 'pregunta4-' + index.toString();

      card_return = Card(
        child: Column(
          children: [
            ListTile(
              title: Text("Pregunta: $idPregunta"),
              subtitle: Column(
                children: [
                  Text("$pregunta"),
                  ChoiseBoxe(
                    valueChoice: (String value) {
                      valuesChoiceBox[idPregunta2] = value;
                    },
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       print(valuesChoiceBox);
                  //     },
                  //     child: Text('AAAA'))
                ],
              ),
            ),
          ],
        ),
      );
      valuesChoiceBox[idPregunta2] = 'No';
      // print(valuesChoiceBox);
    }
    if (idTipoPregunta == '3') {
      card_return = Text(
        pregunta,
        style: TextStyle(fontSize: 20),
      );
    }
    return card_return;
  }

  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        print('CAMBIO EL VALOR ${selectedValue}');
        _dropdownValue = selectedValue;
      });
    }
  }

  dynamic datos() async {
    var db = CuestionarioData();

    // var peticion = await db.getKpis(int.parse(widget.idCuestionario));
    var peticion = await db.getKpis(int.parse(widget.idCuestionario));
    Map<dynamic, dynamic> data = peticion;
    print("__________________________________________________");
    print(data["datos"]);
    return data["datos"];
  }
}

class ChoiseBoxe extends StatefulWidget {
  ValueChanged<String> valueChoice;
  ChoiseBoxe({required this.valueChoice});

  @override
  State<ChoiseBoxe> createState() => _ChoiseBoxeState();
}

class _ChoiseBoxeState extends State<ChoiseBoxe> {
  String _dropdownValue = 'No';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Selecciona una opcion'),
        DropdownButton(
          items: const [
            DropdownMenuItem(child: Text('Si'), value: 'Si'),
            DropdownMenuItem(child: Text('No'), value: 'No'),
          ],
          value: _dropdownValue,
          onChanged: dropdownCallBack,
        )
      ],
    );
  }

  void dropdownCallBack(String? value) {
    setState(() {
      _dropdownValue = value!;
      widget.valueChoice(_dropdownValue);
      print('CAmbio valor ${value}');
    });
  }
}

class TextController extends StatefulWidget {
  ValueChanged<String> valueChoiceText;
  TextController({required this.valueChoiceText});

  @override
  State<TextController> createState() => _TextController();
}

class _TextController extends State<TextController> {
  final TextEditingController myController = TextEditingController();
  String textValue = '';
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Respuesta',
      ),
      onChanged: textCallBack,
      onTap: () {
        print(textCallBack);
      },
    );
  }

  void textCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        textValue = selectedValue;
        widget.valueChoiceText(textValue);
        print('CAMBIO EL VALOR ${selectedValue}');
        var a = myController.value.text;
        a = selectedValue;
      });
    }
  }
}

class ChoiseBoxe2 extends StatefulWidget {
  ValueChanged<String> valueChoice2;
  late List respuestas;
  int index = 0;
  ChoiseBoxe2(
      {required this.valueChoice2,
      required this.respuestas,
      required this.index});

  @override
  State<ChoiseBoxe2> createState() => _ChoiseBoxe2State();
}

class _ChoiseBoxe2State extends State<ChoiseBoxe2> {
  String _dropdownValue = '';
  List<String> listValue = [];
  @override
  Widget build(BuildContext context) {
    print(widget.respuestas);

    List<DropdownMenuItem<String>>? respuestas_total = [];
    for (var i = 0; i < widget.respuestas.length - 1; i++) {
      DropdownMenuItem<String> res = DropdownMenuItem(
          child: Text(widget.respuestas[i]), value: widget.respuestas[i]);
      listValue.add(widget.respuestas[i]);
      respuestas_total.add(res);
    }
    print(
        "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
    print(respuestas_total);
    print(listValue);

    _dropdownValue = listValue.first;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Selecciona una opcion'),
        DropdownButton(
          items: respuestas_total,
          value: _dropdownValue,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              _dropdownValue = value!;
              widget.valueChoice2(_dropdownValue);
            });
          },
        )
      ],
    );
  }

  void dropdownCallBack2(String? value) {
    setState(() {
      _dropdownValue = value!;
      widget.valueChoice2(_dropdownValue);
      print('CAmbio valor ${value}');
    });
  }
}
