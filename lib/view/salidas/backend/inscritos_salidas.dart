import 'dart:convert';

InscritosSalidas inscritosSalidasFromJson(String str) =>
    InscritosSalidas.fromJson(json.decode(str));

String inscritosSalidasToJson(InscritosSalidas data) =>
    json.encode(data.toJson());

class InscritosSalidas {
  int? id;
  final String fecha;
  final int idSalida;
  final int idUser;
  InscritosSalidas({
    this.id,
    required this.fecha,
    required this.idSalida,
    required this.idUser,
  });

  InscritosSalidas copyWith({
    int? id,
    String? fecha,
    int? idSalida,
    int? idUser,
  }) =>
      InscritosSalidas(
          id: id ?? this.id,
          fecha: fecha ?? this.fecha,
          idSalida: idSalida ?? this.idSalida,
          idUser: idUser ?? this.idUser);

  factory InscritosSalidas.fromJson(Map<String, dynamic> json) =>
      InscritosSalidas(
        id: json["id"],
        fecha: json["dateInscription"],
        idSalida: json["salidas_id"],
        idUser: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateInscription": fecha,
        "salidas_id": idSalida,
        "user_id": idUser,
      };
}
