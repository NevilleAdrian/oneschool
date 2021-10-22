// To parse this JSON data, do
//
//     final forgotPassword = forgotPasswordFromJson(jsonString);

import 'dart:convert';

ForgotPassword forgotPasswordFromJson(String str) => ForgotPassword.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  ForgotPassword({
    this.email,
  });

  String email;

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
