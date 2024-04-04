// To parse this JSON data, do
//
//     final perfil = perfilFromJson(jsonString);

import 'dart:convert';

List<Perfil> perfilFromJson(String str) =>
    List<Perfil>.from(json.decode(str).map((x) => Perfil.fromJson(x)));

String perfilToJson(List<Perfil> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Perfil {
  final int? id;
  final String nombre;
  final String apellido;
  final String university;
  final String inscription;
  final String rutaimg;
  final List<String>? detalleInscription;
  final String correo;
  final String dni;
  final String tipoProEstEgre;
  final String conceptotipoProEstEgre;
  final List<Asistencia>? asistencia;

  Perfil({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.university,
    required this.inscription,
    required this.rutaimg,
    this.detalleInscription,
    required this.correo,
    required this.dni,
    required this.tipoProEstEgre,
    required this.conceptotipoProEstEgre,
    this.asistencia,
  });

  Perfil copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? university,
    String? inscription,
    String? rutaimg,
    List<String>? detalleInscription,
    String? correo,
    String? dni,
    String? tipoProEstEgre,
    String? conceptotipoProEstEgre,
    List<Asistencia>? asistencia,
  }) =>
      Perfil(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        university: university ?? this.university,
        apellido: apellido ?? this.apellido,
        rutaimg: rutaimg ?? this.rutaimg,
        inscription: inscription ?? this.inscription,
        detalleInscription: detalleInscription ?? this.detalleInscription,
        correo: correo ?? this.correo,
        dni: dni ?? this.dni,
        tipoProEstEgre: tipoProEstEgre ?? this.tipoProEstEgre,
        conceptotipoProEstEgre:
            conceptotipoProEstEgre ?? this.conceptotipoProEstEgre,
        asistencia: asistencia ?? this.asistencia,
      );

  factory Perfil.fromJson(Map<String, dynamic> json) => Perfil(
        id: json["id"],
        nombre: json["name"],
        apellido: json["lastname"],
        university: json["university"],
        rutaimg: json["imgperfil"],
        inscription: json["inscription"],
        detalleInscription:
            List<String>.from(json["detalleInscription"].map((x) => x) ?? []),
        correo: json["email"],
        dni: json["dni"],
        tipoProEstEgre: json["typeStudent"],
        conceptotipoProEstEgre: json["ciclo"],
        asistencia: List<Asistencia>.from(
            json["asists"].map((x) => Asistencia.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "name": nombre,
        "lastname": apellido,
        "university": university,
        "imgperfil": rutaimg,
        "inscription": inscription,
        "detalleInscription":
            List<String>.from(detalleInscription?.map((x) => x) ?? []),
        "email": correo,
        "dni": dni,
        "typeStudent": tipoProEstEgre,
        "ciclo": conceptotipoProEstEgre,
        "asists":
            List<Asistencia>.from(asistencia?.map((x) => x.toJson()) ?? []),
      };
}

class Asistencia {
  final int id;
  final int conferenciaId;
  final int userId;
  final int asistencia;

  Asistencia({
    required this.id,
    required this.conferenciaId,
    required this.userId,
    required this.asistencia,
  });

  Asistencia copyWith({
    int? id,
    int? conferenciaId,
    int? userId,
    int? asistencia,
  }) =>
      Asistencia(
        id: id ?? this.id,
        conferenciaId: conferenciaId ?? this.conferenciaId,
        userId: userId ?? this.userId,
        asistencia: asistencia ?? this.asistencia,
      );

  factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
        id: json["id"],
        conferenciaId: json["conference_id"],
        userId: json["user_id"],
        asistencia: json["asist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conference_id": conferenciaId,
        "user_id": userId,
        "asist": asistencia,
      };
}
