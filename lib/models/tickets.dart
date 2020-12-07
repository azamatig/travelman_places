// To parse this JSON data, do
//
//     final tickets = ticketsFromMap(jsonString);

import 'dart:convert';

class Tickets {
  Tickets({
    this.success,
    this.data,
    this.error,
    this.currency,
  });

  bool success;
  Data data;
  String error;
  String currency;

  factory Tickets.fromJson(String str) => Tickets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tickets.fromMap(Map<String, dynamic> json) => Tickets(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        error: json["error"],
        currency: json["currency"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
        "error": error,
        "currency": currency,
      };
}

class Data {
  Data({
    this.mow,
  });

  Map<String, Mow> mow;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        mow: Map.from(json["MOW"])
            .map((k, v) => MapEntry<String, Mow>(k, Mow.fromMap(v))),
      );

  Map<String, dynamic> toMap() => {
        "MOW": Map.from(mow)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
      };
}

class Mow {
  Mow({
    this.price,
    this.airline,
    this.flightNumber,
    this.departureAt,
    this.returnAt,
    this.expiresAt,
  });

  int price;
  String airline;
  int flightNumber;
  DateTime departureAt;
  DateTime returnAt;
  DateTime expiresAt;

  factory Mow.fromJson(String str) => Mow.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mow.fromMap(Map<String, dynamic> json) => Mow(
        price: json["price"],
        airline: json["airline"],
        flightNumber: json["flight_number"],
        departureAt: DateTime.parse(json["departure_at"]),
        returnAt: DateTime.parse(json["return_at"]),
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toMap() => {
        "price": price,
        "airline": airline,
        "flight_number": flightNumber,
        "departure_at": departureAt.toIso8601String(),
        "return_at": returnAt.toIso8601String(),
        "expires_at": expiresAt.toIso8601String(),
      };
}
