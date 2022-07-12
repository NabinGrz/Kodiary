// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    this.data,
    this.meta,
  });

  List<Datum>? data;
  Meta? meta;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
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
    this.name,
    this.code,
    this.category,
    this.email,
    this.domain,
    this.logo,
    this.logoUrl,
    this.status,
    this.statusRemarks,
    this.details,
    this.verifiedAt,
    this.services,
  });

  int? id;
  String? name;
  String? code;
  String? category;
  String? email;
  String? domain;
  dynamic? logo;
  String? logoUrl;
  String? status;
  dynamic statusRemarks;
  dynamic details;
  dynamic verifiedAt;
  List<Service>? services;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        category: json["category"],
        email: json["email"],
        domain: json["domain"],
        logo: json["logo"],
        logoUrl: json["logo_url"],
        status: json["status"],
        statusRemarks: json["status_remarks"],
        details: json["details"],
        verifiedAt: json["verified_at"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "category": category,
        "email": email,
        "domain": domain,
        "logo": logo,
        "logo_url": logoUrl,
        "status": status,
        "status_remarks": statusRemarks,
        "details": details,
        "verified_at": verifiedAt,
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.id,
    this.name,
    this.slug,
    this.host,
    this.statsApi,
    this.description,
    this.status,
    this.statusRemarks,
    this.createdAt,
    this.updatedAt,
    this.companyServiceId,
  });

  int? id;
  String? name;
  String? slug;
  String? host;
  String? statsApi;
  String? description;
  String? status;
  String? statusRemarks;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? companyServiceId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        host: json["host"],
        statsApi: json["stats_api"],
        description: json["description"],
        status: json["status"],
        statusRemarks: json["status_remarks"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        companyServiceId: json["company_service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "host": host,
        "stats_api": statsApi,
        "description": description,
        "status": status,
        "status_remarks": statusRemarks,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "company_service_id": companyServiceId,
      };
}

class Meta {
  Meta({
    this.total,
    this.count,
    this.currentPage,
    this.lastPage,
    this.previousPage,
    this.nextPage,
  });

  int? total;
  int? count;
  int? currentPage;
  int? lastPage;
  dynamic? previousPage;
  dynamic? nextPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        count: json["count"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "current_page": currentPage,
        "last_page": lastPage,
        "previous_page": previousPage,
        "next_page": nextPage,
      };
}
