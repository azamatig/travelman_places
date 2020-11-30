// To parse this JSON data, do
//
//     final aviaSalesHotelModel = aviaSalesHotelModelFromMap(jsonString);

import 'dart:convert';

class AviaSalesCountriesModel {
  AviaSalesCountriesModel({
    this.name,
    this.currency,
    this.code,
  });

  String name;
  String currency;
  String code;

  factory AviaSalesCountriesModel.fromJson(String str) =>
      AviaSalesCountriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AviaSalesCountriesModel.fromMap(Map<String, dynamic> json) =>
      AviaSalesCountriesModel(
        name: json["name"],
        currency: json["currency"] == null ? null : json["currency"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "currency": currency == null ? null : currency,
        "code": code,
      };
}
