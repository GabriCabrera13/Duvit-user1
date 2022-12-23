import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Checkin extends StatefulWidget {
  const Checkin({Key? key}) : super(key: key);

  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  bool? isChecked = false;
  String hora = '';
  String hora2 = '';
  bool? isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Check In'),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          width: size.width,
          height: double.infinity,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(bottom: 70)),
              Text(
                'Check in',
                style: TextStyle(fontSize: 40),
              ),
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                activeColor: Colors.red,
                tristate: true,
                onChanged: (value) {
                  setState(() {
                    hora = sacarFecha();
                    isChecked = value;
                  });
                },
              ),
              Text('Usted hizo check in a las: ' + hora),
              Padding(padding: EdgeInsets.only(bottom: 70)),
              Text(
                'Check out',
                style: TextStyle(fontSize: 40),
              ),
              Checkbox(
                checkColor: Colors.white,
                value: isChecked2,
                activeColor: Colors.red,
                tristate: true,
                onChanged: (value1) {
                  setState(() {
                    hora2 = sacarFecha();
                    isChecked2 = value1;
                    isChecked = false;
                  });
                },
              ),
              Text('Usted hizo check in a las: ' + hora2),
            ],
          ),
        ),
      ),
    );
  }

  String sacarFecha() {
    String tdata = DateFormat("HH:mm:ss").format(DateTime.now());

    return tdata;
  }
}
