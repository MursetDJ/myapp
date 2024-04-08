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
    required this.email,
    required this.ciclo,
    required this.imgperfil,
    required this.pagoComprob,
    required this.constance,
    required this.modality,
    required this.inscription,
    this.detailInscription,
    required this.opinion,
    this.id,
  });
  final String name;
  final String lastname;
  final String university;
  final String dni;
  final String typeStudent;
  final String email;
  final String ciclo;
  final String imgperfil;
  final String pagoComprob;
  final String constance;
  final String modality;
  final String inscription;
  final List<String>? detailInscription;
  final String opinion;
  final int? id;

  Register copyWith({
    String? name,
    String? lastname,
    String? university,
    String? dni,
    String? typeStudent,
    String? email,
    String? ciclo,
    String? imgperfil,
    String? pagoComprob,
    String? constance,
    String? modality,
    String? inscription,
    List<String>? detailInscription,
    String? opinion,
    int? id,
  }) =>
      Register(
          name: name ?? this.name,
          lastname: lastname ?? this.lastname,
          university: university ?? this.university,
          dni: dni ?? this.dni,
          typeStudent: typeStudent ?? this.typeStudent,
          email: email ?? this.email,
          ciclo: ciclo ?? this.ciclo,
          imgperfil: imgperfil ?? this.imgperfil,
          pagoComprob: pagoComprob ?? this.pagoComprob,
          constance: constance ?? this.constance,
          modality: modality ?? this.modality,
          inscription: inscription ?? this.inscription,
          detailInscription: detailInscription ?? this.detailInscription,
          opinion: opinion ?? this.opinion,
          id: id ?? this.id);

  factory Register.fromJson(Map<String, dynamic> json) => Register(
      name: json["name"],
      lastname: json["lastname"],
      university: json["university"],
      dni: json["dni"],
      typeStudent: json["typeStudent"],
      email: json["email"],
      ciclo: json["ciclo"],
      imgperfil: json["imgperfil"],
      pagoComprob: json["pagoComprob"],
      constance: json["constance"],
      modality: json["modality"],
      inscription: json["inscription"],
      detailInscription: json["detailInscription"],
      opinion: json["opinion"],
      id: json['id']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "university": university,
        "dni": dni,
        "typeStudent": typeStudent,
        "email": email,
        "ciclo": ciclo,
        "imgperfil": imgperfil,
        "pagoComprob": pagoComprob,
        "constance": constance,
        "modality": modality,
        "inscription": inscription,
        "detailInscription": detailInscription,
        "opinion": opinion,
      };
}
