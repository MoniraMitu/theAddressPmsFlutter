// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  String? name;
  String? address;
  String? area;
  String? type;
  String? description;
  int? price;
  String? bedrooms;
  String? bathrooms;
  String? size;
  bool? approval;
  String? image1;
  String? image2;
  String? image3;

  PropertyModel({
    this.name,
    this.address,
    this.area,
    this.type,
    this.description,
    this.price,
    this.bedrooms,
    this.bathrooms,
    this.size,
    this.approval,
    this.image1,
    this.image2,
    this.image3,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        name: json["name"],
        address: json["address"],
        area: json["area"],
        type: json["type"],
        description: json["description"],
        price: json["price"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        size: json["size"],
        approval: json["approval"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "area": area,
        "type": type,
        "description": description,
        "price": price,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "size": size,
        "approval": approval,
        "image1": image1,
        "image2": image2,
        "image3": image3,
      };
}
