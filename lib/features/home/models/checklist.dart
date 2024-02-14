// To parse this JSON data, do
//
//     final Checklist = ChecklistFromJson(jsonString);

import 'dart:convert';

Checklist ChecklistFromJson(String str) => Checklist.fromJson(json.decode(str));

String ChecklistToJson(Checklist data) => json.encode(data.toJson());

class Checklist {
  final String? name;
  final List<String>? collaborators;
  final Map<String,bool>? items;
  final String? createdBy;
  final String? docId;

  Checklist({
    this.name,
    this.collaborators,
    this.items,
    this.createdBy,
    this.docId
  });

  Checklist copyWith({
    String? name,
    List<String>? collaborators,
    Map<String,bool>? items,
    String? createdBy,
    String? docId

  }) =>
      Checklist(
        name: name ?? this.name,
        collaborators: collaborators ?? this.collaborators,
        items: items ?? this.items,
        createdBy: createdBy ?? this.createdBy,
        docId: docId ?? this.docId,
      );

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
    name: json["name"],
    collaborators: json["collaborators"] == null ? [] : List<String>.from(json["collaborators"]!.map((x) => x)),
    items: json["items"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "collaborators": collaborators == null ? [] : List<dynamic>.from(collaborators!.map((x) => x)),
    "items": items,
    "createdBy": createdBy,
  };
}
