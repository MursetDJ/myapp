// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

List<Register> registerFromJson(String str) =>
    List<Register>.from(json.decode(str).map((x) => Register.fromJson(x)));

String registerToJson(List<Register> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Register {
  Register({
    required this.name,
    required this.lastname,
    required this.university,
    required this.dni,
    required this.typeStudent,
    required this.hotmail,
    required this.cicle,
    required this.imgPerfil,
    required this.pagoCompr,
    required this.constance,
    required this.modality,
    required this.inscripction,
    required this.detailInscription,
    required this.opinion,
    this.id,
  });
  final String name;
  final String lastname;
  final String university;

  final String dni;
  final String typeStudent;
  final String hotmail;
  final String cicle;
  final String imgPerfil;
  final String pagoCompr;
  final String constance;
  final String modality;
  final String inscripction;
  final String detailInscription;
  final String opinion;
  final String? id;

  Register copyWith({
    String? name,
    String? lastname,
    String? university,
    String? dni,
    String? typeStudent,
    String? hotmail,
    String? cicle,
    String? imgPerfil,
    String? pagoCompr,
    String? constance,
    String? modality,
    String? inscripction,
    String? detailInscription,
    String? opinion,
    String? id,
  }) =>
      Register(
          name: name ?? this.name,
          lastname: lastname ?? this.lastname,
          university: university ?? this.university,
          dni: dni ?? this.dni,
          typeStudent: typeStudent ?? this.typeStudent,
          hotmail: hotmail ?? this.hotmail,
          cicle: cicle ?? this.cicle,
          imgPerfil: imgPerfil ?? this.imgPerfil,
          pagoCompr: pagoCompr ?? this.pagoCompr,
          constance: constance ?? this.constance,
          modality: modality ?? this.modality,
          inscripction: inscripction ?? this.inscripction,
          detailInscription: detailInscription ?? this.detailInscription,
          opinion: opinion ?? this.opinion,
          id: id ?? this.id);

  factory Register.fromJson(Map<String, dynamic> json) => Register(
      name: json["name"],
      lastname: json["lastname"],
      university: json["university"],
      dni: json["dni"],
      typeStudent: json["type_student"],
      hotmail: json["hotmail"],
      cicle: json["cicle"],
      imgPerfil: json["img_Perfil"],
      pagoCompr: json["pago_Compr"],
      constance: json["constance"],
      modality: json["modality"],
      inscripction: json["inscripction"],
      detailInscription: json["detail_inscription"],
      opinion: json["opinion"],
      id: json['id']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "university": university,
        "dni": dni,
        "type_student": typeStudent,
        "hotmail": hotmail,
        "cicle": cicle,
        "img_Perfil": imgPerfil,
        "pago_Compr": pagoCompr,
        "constance": constance,
        "modality": modality,
        "inscripction": inscripction,
        "detail_inscription": detailInscription,
        "opinion": opinion,
      };
}
