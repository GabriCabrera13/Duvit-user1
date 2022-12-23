import 'dart:convert';
import 'package:duvit/models/member_model.dart';
import 'package:http/http.dart' as http;


class MembersProvider {

  final String _url = "http://creandoproyectosexitosos.com/WEBSERVICE/v2";

  Future<List<MemberModel>> getMembersByProject(int idProyecto) async {

    final url = '$_url/members.php?idProyecto=$idProyecto';
    
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<MemberModel> listMember = [];

    decodedData.forEach((id, member) {

      final memberTemp = MemberModel.fromJson(member);

      listMember.add( memberTemp );

    });

    return listMember;

  }

}