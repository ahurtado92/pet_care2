import 'dart:convert';

import 'package:pet_care/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/src/models/addmascota_model.dart';

class AddMascotaProvider {
  final String _url =
      'flutter-varios-60121-default-rtdb.europe-west1.firebasedatabase.app';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearAddMascota(AddMascotaModel addmascota) async {
    final res = await http.post(
        Uri.https(_url, 'addmascota.json', {"auth": "${_prefs.token}"}),
        body: AddMascotaToJson(addmascota));
    final decodedData = json.decode(res.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarAddMascota(AddMascotaModel addmascota) async {
    final res = await http.put(
        Uri.https(
            _url, 'addmascota/${addmascota.id}.json', {"auth": "${_prefs.token}"}),
        //Uri.https(_url, 'productos/${producto.id}.json'),
        body: AddMascotaToJson(addmascota));
    final decodedData = json.decode(res.body);
    print(decodedData);
    return true;
  }

  Future<List<AddMascotaModel>> cargarMascotas() async {
    final res = await http.get(
      Uri.https(_url, 'addmascota.json', {"auth": "${_prefs.token}"}),
    );
    final Map<String, dynamic> decodedData = json.decode(res.body);
    final List<AddMascotaModel> productos = new List();
    print(res.body);
    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = AddMascotaModel.fromJson(prod);
      productos.add(prodTemp);
    });
    //print(productos);
    return productos;
  }

  Future<int> eliminarAddMascota(String id) async {
    final res = await http.delete(
      Uri.https(_url, 'addmascota/$id.json', {"auth": "${_prefs.token}"}),
    );
    final decodedData = json.decode(res.body);
    print(decodedData);
    return 1;
  }
}
