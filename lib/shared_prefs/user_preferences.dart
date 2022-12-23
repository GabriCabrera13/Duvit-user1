import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instance = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instance;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  void clear(){
    _prefs.clear();
  }

  // GET y SET
  bool get logeado {
    return _prefs.getBool('logeado') ?? false;
  }
  set logeado( bool value ) {
    _prefs.setBool('logeado', value);
  }

  String get name {
    return _prefs.getString('name') ?? "";
  }
  set name( String value ) {
    _prefs.setString('name', value);
  }

  String get email {
    return _prefs.getString('email') ?? "";
  }
  set email( String value ) {
    _prefs.setString('email', value);
  }

  int get idUser {
    return _prefs.getInt('idUser') ?? 0;
  }
  set idUser( int value ) {
    _prefs.setInt('idUser', value);
  }

  int get idStaff {
    return _prefs.getInt('idStaff') ?? 0;
  }
  set idStaff( int value ) {
    _prefs.setInt('idStaff', value);
  }

  int get idCompany {
    return _prefs.getInt('idCompany') ?? 0;
  }
  set idCompany( int value ) {
    _prefs.setInt('idCompany', value);
  }

  int get idGender {
    return _prefs.getInt('idGender') ?? 0;
  }
  set idGender( int value ) {
    _prefs.setInt('idGender', value);
  }

  double get lat {
    return _prefs.getDouble('lat') ?? 0.0;
  }
  set lat( double value ) {
    _prefs.setDouble('lat', value);
  }

  double get long {
    return _prefs.getDouble('long') ?? 0.0;
  }
  set long( double value ) {
    _prefs.setDouble('long', value);
  }

  String get token {
    return _prefs.getString('token') ?? "";
  }
  set token( String value ) {
    _prefs.setString('token', value);
  }

  int get validateGPS {
    return _prefs.getInt('validateGPS') ?? 0;
  }
  set validateGPS( int value ) {
    _prefs.setInt('validateGPS', value);
  }

  int get active {
    return _prefs.getInt('active') ?? 0;
  }
  set active( int value ) {
    _prefs.setInt('active', value);
  }

}