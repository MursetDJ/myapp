import 'dart:convert';

Ponentes ponentesFromJson(String str) => Ponentes.fromJson(json.decode(str));

String ponentesToJson(Ponentes data) => json.encode(data.toJson());

class Ponentes {
  final int? id;
  final String fullname;
  final String especialidad;
  final String descripcion;
  final String ruta;

  Ponentes({
    this.id,
    required this.fullname,
    required this.especialidad,
    required this.descripcion,
    required this.ruta,
  });

  Ponentes copyWith({
    int? id,
    String? fullname,
    String? especialidad,
    String? descripcion,
    String? ruta,
  }) =>
      Ponentes(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        especialidad: especialidad ?? this.especialidad,
        descripcion: descripcion ?? this.descripcion,
        ruta: ruta ?? this.ruta,
      );

  factory Ponentes.fromJson(Map<String, dynamic> json) => Ponentes(
        id: json["id"],
        fullname: json["fullname"],
        especialidad: json["especialidad"],
        descripcion: json["descripcion"],
        ruta: json["ruta"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "especialidad": especialidad,
        "descripcion": descripcion,
        "ruta": ruta,
      };
}
