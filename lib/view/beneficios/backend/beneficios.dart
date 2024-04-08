// To parse this JSON data, do
//
//     final beneficios = beneficiosFromJson(jsonString);

import 'dart:convert';

Beneficios beneficiosFromJson(String str) =>
    Beneficios.fromJson(json.decode(str));

String beneficiosToJson(Beneficios data) => json.encode(data.toJson());

class Beneficios {
  final int? id;
  final String name;
  final String descripcion;
  final String tipo;
  final String rutaImagen;
  final String beneficios;
  final String ubicacion;

  Beneficios({
    this.id,
    required this.name,
    required this.descripcion,
    required this.tipo,
    required this.rutaImagen,
    required this.beneficios,
    required this.ubicacion,
  });

  Beneficios copyWith({
    int? id,
    String? name,
    String? descripcion,
    String? lugar,
    String? tipo,
    String? rutaImagen,
    String? beneficios,
    String? ubicacion,
  }) =>
      Beneficios(
        id: id ?? this.id,
        name: name ?? this.name,
        descripcion: descripcion ?? this.descripcion,
        tipo: tipo ?? this.tipo,
        rutaImagen: rutaImagen ?? this.rutaImagen,
        beneficios: beneficios ?? this.beneficios,
        ubicacion: ubicacion ?? this.ubicacion,
      );

  factory Beneficios.fromJson(Map<String, dynamic> json) => Beneficios(
        id: json["id"],
        name: json["name"],
        descripcion: json["descripcion"],
        tipo: json["tipo"],
        rutaImagen: json["rutaImagen"],
        beneficios: json["beneficios"],
        ubicacion: json["ubicacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "descripcion": descripcion,
        "tipo": tipo,
        "rutaImagen": rutaImagen,
        "beneficios": beneficios,
        "ubicacion": ubicacion,
      };
}
