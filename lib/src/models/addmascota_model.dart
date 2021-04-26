// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

import 'package:pet_care/src/pages/CrearMascota.dart';

AddMascotaModel AddMascotaFromJson(String str) =>
    AddMascotaModel.fromJson(json.decode(str));

String AddMascotaToJson(AddMascotaModel data) => json.encode(data.toJson());

class AddMascotaModel {
  AddMascotaModel({
    this.id,
    this.nombre = '',
    this.observaciones = '',
    this.descripcion ='',
    this.edad = '',
    this.tipo= ''
  });

  String id;
  String nombre;
  String tipo;
  String observaciones;
  String descripcion;
  String edad;

  factory AddMascotaModel.fromJson(Map<String, dynamic> json) => AddMascotaModel(
      id: json["id"],
      nombre: json["nombre"],
      observaciones: json["observaciones"],
      descripcion: json["descripcion"],
      tipo: json["tipo"],
      edad: json["edad"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "observaciones": observaciones,
    "descripcion": descripcion,
    "tipo": tipo,
    "edad": edad
  };
}
