import 'dart:convert';

import 'package:pet_care/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> nuevoUsuario(
      String displayName, String email, String password) async {
    final uri = Uri.https(
        "identitytoolkit.googleapis.com",
        "v1/accounts:signUp",
        {"key": "AIzaSyBtdPsSdmyBqias5-z33rzG40hlTShCz-4"});
    final res = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "displayName": displayName,
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    Map<String, dynamic> decodedRes = json.decode(res.body);
    //print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      _prefs.token = decodedRes['idToken']; // Salvar el token en el Storage
      _prefs.email = decodedRes['email'];
      _prefs.displayName = decodedRes['displayName'];
      _prefs.refreshtoken = decodedRes['refreshToken'];
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedRes['error']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.https(
        "identitytoolkit.googleapis.com",
        "v1/accounts:signInWithPassword",
        {"key": "AIzaSyBtdPsSdmyBqias5-z33rzG40hlTShCz-4"});
    final res = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    Map<String, dynamic> decodedRes = json.decode(res.body);
    //print(decodedRes);

    if (decodedRes.containsKey('idToken')) {
      _prefs.token = decodedRes['idToken']; // Salvar el token en el Storage
      _prefs.email = decodedRes['email'];
      _prefs.refreshtoken = decodedRes['refreshToken'];
      return {'ok': true, 'token': decodedRes['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedRes['error']['message']};
    }
  }
  Future<Map<String, dynamic>> refreshToken(String refreshtoken) async {
    final uri = Uri.https(
        "identitytoolkit.googleapis.com",
        "v1/token",
        {"key": "AIzaSyBtdPsSdmyBqias5-z33rzG40hlTShCz-4"});
    final res = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "grant_type":"refresh_token",
          "refresh_token":refreshtoken,

        }));
    Map<String, dynamic> decodedRes = json.decode(res.body);
    //print(decodedRes);

    if (decodedRes.containsKey('id_token')) {
      _prefs.token = decodedRes['id_token']; // Salvar el token en el Storage
      _prefs.refreshtoken = decodedRes['refresh_token']; // Salvar el token en el Storage

      return {'ok': true, 'token': decodedRes['id_token']};
    } else {
      return {'ok': false, 'mensaje': decodedRes['error']['message']};
    }
  }
}
