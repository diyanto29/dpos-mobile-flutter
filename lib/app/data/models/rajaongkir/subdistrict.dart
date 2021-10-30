
import 'dart:convert';

SubdistrictModel SubdistrictModelFromJson(String str) => SubdistrictModel.fromJson(json.decode(str));

String SubdistrictModelToJson(SubdistrictModel data) => json.encode(data.toJson());

class SubdistrictModel {
  SubdistrictModel({
    this.rajaongkir,
  });

  Rajaongkir? rajaongkir;

  factory SubdistrictModel.fromJson(Map<String, dynamic> json) => SubdistrictModel(
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

  Query? query;
  Status? status;
  List<Subdistrict>? results;

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
    query: Query.fromJson(json["query"]),
    status: Status.fromJson(json["status"]),
    results: List<Subdistrict>.from(json["results"].map((x) => Subdistrict.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "query": query!.toJson(),
    "status": status!.toJson(),
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Query {
  Query({
    this.city,
  });

  String? city;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
  };
}

class Subdistrict {
  Subdistrict({
    this.subdistrictId,
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.type,
    this.subdistrictName,
  });

  String? subdistrictId;
  String? provinceId;
  String? province;
  String? cityId;
  String? city;
  String? type;
  String? subdistrictName;

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
    subdistrictId: json["subdistrict_id"],
    provinceId: json["province_id"],
    province: json["province"],
    cityId: json["city_id"],
    city: json["city"],
    type: json["type"],
    subdistrictName: json["subdistrict_name"],
  );

  Map<String, dynamic> toJson() => {
    "subdistrict_id": subdistrictId,
    "province_id": provinceId,
    "province": province,
    "city_id": cityId,
    "city": city,
    "type": type,
    "subdistrict_name": subdistrictName,
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
