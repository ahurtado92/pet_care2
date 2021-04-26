// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

AnuncioModel anuncioFromJson(String str) =>
    AnuncioModel.fromJson(json.decode(str));

String anuncioToJson(AnuncioModel data) => json.encode(data.toJson());

class AnuncioModel {
  AnuncioModel({
    this.id,
    this.nombre = '',
    this.observaciones = '',
    this.descripcion,
    this.tipo = 0
  });

  String id;
  String nombre;
  int tipo;
  String observaciones;
  String descripcion;

  factory AnuncioModel.fromJson(Map<String, dynamic> json) => AnuncioModel(
        id: json["Id"],
        nombre: json["Nombre"],
        observaciones: json["Observaciones"],
        descripcion: json["Descripción"],
        tipo: json["Tipo"]
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
        "Observaciones": observaciones,
        "Descripción": descripcion,
        "Tipo": tipo,
      };
}
