import 'package:duvit/models/member_model.dart';
import 'package:duvit/models/project_model.dart';
import 'package:duvit/providers/members_provider.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectMembersScreen extends StatefulWidget {

  @override
  _ProjectMembersScreenState createState() => _ProjectMembersScreenState();
}

class _ProjectMembersScreenState extends State<ProjectMembersScreen> {
  final membersProvider = new MembersProvider();

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final projectListModel = ModalRoute.of(context)!.settings.arguments as ProjectListModel;

    return Scaffold(
      appBar: _crearAppBar( context, projectListModel.nombreProyecto),
      body:  _crearListado( projectListModel.idProyecto ),
    );
  }

  Widget _crearListado(int idProyecto) {

    return FutureBuilder(
      future: membersProvider.getMembersByProject(idProyecto),
      builder: (BuildContext context, AsyncSnapshot<List<MemberModel>> snapshot) {

        final members = snapshot.data;

        if (snapshot.hasData) {
          if ( members!.isNotEmpty ) {
            return Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, i) => _crearItemMember( context, members[i] ),
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_very_dissatisfied,
                      size: 40.0,
                    ),
                    SizedBox(height: 8.0),
                    Text( 'Ningún miembro está \n relacionado con este proyecto', textAlign: TextAlign.center),
                  ],
                ),
              ],
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItemMember( BuildContext context, MemberModel member ) {

    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          bottomLeft: Radius.circular(26.0),
          bottomRight: Radius.circular(26.0),
          topRight: Radius.circular(26.0)
        ),
      ),
      elevation: 0.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
          title: Text(
            member.nombre + " " + member.apellidoPaterno,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( member.telefonoCelular != '' ? member.telefonoCelular : 'Sin teléfono' ),
              Text( member.correoCorporativo != '' ? member.correoCorporativo : 'Sin correo electrónico')
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.textsms_outlined,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {

                  String _phone = member.telefonoCelular;

                  if ( _phone != "" ) {
                    _launchURL('sms:$_phone');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sin número de teléfono',
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                  
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.phone_forwarded_outlined,
                  size: 20.0,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  
                  String _phone = member.telefonoCelular;

                  if ( _phone != "" ) {
                    _launchURL('tel:$_phone');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sin número de teléfono',
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _crearAppBar( BuildContext context, String nombreProyecto ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text( 'Miembros', style: TextStyle(color: Colors.black)),
            Text( 'Proyecto • $nombreProyecto', style:  TextStyle( fontWeight : FontWeight.w400, fontSize : 12, letterSpacing : 0.2, color : Color(0xFF4A6572) )),
          ],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            color: Colors.black87,
            icon: Icon(
              Icons.close,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}