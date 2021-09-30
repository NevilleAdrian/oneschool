import 'dart:convert';

AddChild addChildFromJson(String str) => AddChild.fromJson(json.decode(str));

String addChildToJson(AddChild data) => json.encode(data.toJson());

class AddChild {
  AddChild({
    this.name,
    this.imageUrl,
  });

  String name;
  String imageUrl;

  factory AddChild.fromJson(Map<String, dynamic> json) => AddChild(
        name: json["name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
      };
}
