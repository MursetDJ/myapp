// To parse this JSON data, do
//
//     final salidas = salidasFromJson(jsonString);

import 'dart:convert';

Salidas salidasFromJson(String str) => Salidas.fromJson(json.decode(str));

String salidasToJson(Salidas data) => json.encode(data.toJson());

class Salidas {
  final int? id;
  final DateTime fecha;
  final String lugarDeSalida;
  final String lugar;
  final String tipo;
  final int cupos;
  final double precio;

  Salidas({
    this.id,
    required this.fecha,
    required this.lugarDeSalida,
    required this.lugar,
    required this.tipo,
    required this.cupos,
    required this.precio,
  });

  Salidas copyWith({
    int? id,
    DateTime? fecha,
    String? lugarDeSalida,
    String? lugar,
    String? tipo,
    int? cupos,
    double? precio,
  }) =>
      Salidas(
        id: id ?? this.id,
        fecha: fecha ?? this.fecha,
        lugarDeSalida: lugarDeSalida ?? this.lugarDeSalida,
        lugar: lugar ?? this.lugar,
        tipo: tipo ?? this.tipo,
        cupos: cupos ?? this.cupos,
        precio: precio ?? this.precio,
      );

  factory Salidas.fromJson(Map<String, dynamic> json) => Salidas(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        lugarDeSalida: json["lugarDeSalida"],
        lugar: json["lugar"],
        tipo: json["tipo"],
        cupos: json["cupos"],
        precio: json["precio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha.toString(),
        "lugarDeSalida": lugarDeSalida,
        "lugar": lugar,
        "tipo": tipo,
        "cupos": cupos,
        "precio": precio,
      };
}
