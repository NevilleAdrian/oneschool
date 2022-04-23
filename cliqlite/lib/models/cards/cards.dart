// To parse this JSON data, do
//
//     final getCards = getCardsFromJson(jsonString);

import 'dart:convert';

List<GetCards> getCardsFromJson(String str) =>
    List<GetCards>.from(json.decode(str).map((x) => GetCards.fromJson(x)));

String getCardsToJson(List<GetCards> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCards {
  GetCards({
    this.card,
    this.id,
  });

  Card card;
  String id;

  factory GetCards.fromJson(Map<String, dynamic> json) => GetCards(
        card: Card.fromJson(json["card"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "card": card.toJson(),
        "_id": id,
      };
}

class Card {
  Card({
    this.cardType,
    this.last4,
    this.countryCode,
  });

  String cardType;
  String last4;
  String countryCode;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        cardType: json["card_type"],
        last4: json["last4"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "card_type": cardType,
        "last4": last4,
        "country_code": countryCode,
      };
}
