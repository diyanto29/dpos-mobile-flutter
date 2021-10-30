// To parse this JSON data, do
//
//     final CityModel = CityModelFromJson(jsonString);

import 'dart:convert';

CityModel CityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String CityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
    this.Citys,
  });

  Query? query;
  Status? status;
  List<City>? Citys;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    query: Query.fromJson(json["query"]),
    status: Status.fromJson(json["status"]),
    Citys: List<City>.from(json["results"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "query": query!.toJson(),
    "status": status!.toJson(),
    "results": List<dynamic>.from(Citys!.map((x) => x.toJson())),
  };
}

class Query {
  Query({
    this.provinceId,
  });

  String? provinceId;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    provinceId: json["province_id"],
  );

  Map<String, dynamic> toJson() => {
    "province_id": provinceId,
  };
}

class City {
  City({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  factory City.fromJson(Map<String, dynamic> json) => City(
    cityId: json["city_id"],
    provinceId: json["province_id"],
    province: json["province"],
    type: json["type"],
    cityName: json["city_name"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "province_id": provinceId,
    "province": province,
    "type": type,
    "city_name": cityName,
    "postal_code": postalCode,
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
