import 'dart:convert';

Conferencia conferenciaFromJson(String str) =>
    Conferencia.fromJson(json.decode(str));

String conferenciaToJson(Conferencia data) => json.encode(data.toJson());

class Conferencia {
  final int? id;
  final String name;
  final String description;
  final String lugar;
  final DateTime startConference;
  final DateTime endConference;
  final int? ponenteId;

  Conferencia({
    this.id,
    required this.name,
    required this.description,
    required this.lugar,
    required this.startConference,
    required this.endConference,
    this.ponenteId,
  });

  Conferencia copyWith({
    int? id,
    String? name,
    String? description,
    String? lugar,
    DateTime? startConference,
    DateTime? endConference,
    int? ponenteId,
  }) =>
      Conferencia(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        lugar: lugar ?? this.lugar,
        startConference: startConference ?? this.startConference,
        endConference: endConference ?? this.endConference,
        ponenteId: ponenteId,
      );

  factory Conferencia.fromJson(Map<String, dynamic> json) => Conferencia(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        lugar: json["lugar"],
        startConference: DateTime.parse(json["startConference"]),
        endConference: DateTime.parse(json["endConference"]),
        ponenteId: json["ponente_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "lugar": lugar,
        "startConference": startConference.toString(),
        "endConference": endConference.toString(),
        "ponente_id": ponenteId,
      };
}
