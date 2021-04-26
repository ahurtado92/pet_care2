import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/src/models/anuncio_model.dart';

class AnunciosProvider {
  final String _url =
      'flutter-varios-60121-default-rtdb.europe-west1.firebasedatabase.app';
  final _prefs = new PreferenciasUsuario();


  Future<bool> crearAnuncio(AnuncioModel Anuncio) async {
    final res = await http.post(
        Uri.https(_url, 'Anuncios.json', {"auth": "${_prefs.token}"}),
        body: anuncioToJson(Anuncio));
    final decodedData = json.decode(res.body);
    print(decodedData);
    return true;
  }

  Future<bool> editarAnuncio(AnuncioModel Anuncio) async {
    final res = await http.put(
        Uri.https(
            _url, 'Anuncios/${Anuncio.id}.json', {"auth": "${_prefs.token}"}),
        //Uri.https(_url, 'Anuncios/${Anuncio.id}.json'),
        body: anuncioToJson(Anuncio));
    final decodedData = json.decode(res.body);
    print(decodedData);
    return true;
  }

  Future<List<AnuncioModel>> cargarAnuncios() async {
    final res = await http.get(
      Uri.https(_url, 'Anuncios.json', {"auth": "${_prefs.token}"}),
    );
    final Map<String, dynamic> decodedData = json.decode(res.body);
    final List<AnuncioModel> Anuncios = new List();
    print(res.body);
    if (decodedData == null) return [];
    decodedData.forEach((id, prod) {
      final prodTemp = AnuncioModel.fromJson(prod);
      prodTemp.id = id;
      Anuncios.add(prodTemp);
    });
    //print(Anuncios);
    return Anuncios;
  }

  Future<int> detallesAnuncio(String id) async {
    final res = await http.get(
      Uri.https(_url, 'Anuncios/$id.json', {"auth": "${_prefs.token}"}),
    );
    final Map<String, dynamic> decodedData = json.decode(res.body);
    print(res.body);
    if (id != null) {
      decodedData.forEach((id, prod) {
        final prodTemp = AnuncioModel.fromJson(prod);
        print(prodTemp.nombre);
        print(prodTemp.descripcion);
        print(prodTemp.tipo);
        print(prodTemp.observaciones);
      });
    }
  }

  Future<int> eliminarAnuncio(String id) async {
    final res = await http.delete(
      Uri.https(_url, 'Anuncios/$id.json', {"auth": "${_prefs.token}"}),
    );
    final decodedData = json.decode(res.body);
    print(decodedData);
    return 1;
  }
}
