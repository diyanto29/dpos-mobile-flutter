// To parse this JSON data, do
//
//     final ProvinceModel = ProvinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel ProvinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String ProvinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
    rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
  );

  Map<String, dynamic> toJson() => {
    "rajaongkir": rajaongkir!.toJson(),
  };
}

class Rajaongkir {
  Rajaongkir({
    this.query,
    this.status,
    this.results,
  });

  List<dynamic>? query;
  Status? status;
  List<Province>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    query: List<dynamic>.from(json["query"].map((x) => x)),
    status: Status.fromJson(json["status"]),
    results: List<Province>.from(json["results"].map((x) => Province.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "query": List<dynamic>.from(query!.map((x) => x)),
    "status": status!.toJson(),
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Province {
  Province({
    this.provinceId,
    this.province,
  });

  String? provinceId;
  String? province;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    provinceId: json["province_id"],
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "province_id": provinceId,
    "province": province,
  };
}

class Status {
  Status({
    this.code,
    this.description,
  });

  int? code;
  String? description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
  };
}
