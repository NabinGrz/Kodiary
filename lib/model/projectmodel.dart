// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  ProjectModel({
    this.data,
    this.meta,
  });

  List<Datum>? data;
  Meta? meta;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta!.toJson(),
      };
}

class Datum {
  Datum({
    this.id,
    this.companyId,
    this.name,
    this.code,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.dailyRequests,
  });

  int? id;
  int? companyId;
  String? name;
  String? code;
  String? description;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? dailyRequests;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        code: json["code"],
        description: json["description"] ?? null,
        status: statusValues.map[json["status"]],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        dailyRequests: List<dynamic>.from(json["daily_requests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "code": code,
        "description": description ?? null,
        "status": statusValues.reverse[status],
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "daily_requests": List<dynamic>.from(dailyRequests!.map((x) => x)),
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"active": Status.ACTIVE});

class Meta {
  Meta({
    this.total,
    this.nextPage,
    this.count,
    this.previousPage,
    this.lastPage,
    this.currentPage,
  });

  int? total;
  int? nextPage;
  int? count;
  dynamic? previousPage;
  int? lastPage;
  int? currentPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        nextPage: json["next_page"],
        count: json["count"],
        previousPage: json["previous_page"],
        lastPage: json["last_page"],
        currentPage: json["current_page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "next_page": nextPage,
        "count": count,
        "previous_page": previousPage,
        "last_page": lastPage,
        "current_page": currentPage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => new MapEntry(v, k));
    return reverseMap!;
  }
}
