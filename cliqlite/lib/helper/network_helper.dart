import 'dart:convert';

import 'package:cliqlite/exceptions/api_failure_exception.dart';
import 'package:cliqlite/models/auth_model/forgot_password.dart';
import 'package:cliqlite/models/auth_model/login_model.dart';
import 'package:cliqlite/models/auth_model/registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

/// Helper class to make http request

uriConverter(String url) {
  print('$kUrl$kAppUrl/$url');
  return Uri.https(kUrl, '$kAppUrl/$url');
}

uriConverterWithQuery(String url, Map<String, dynamic> params) {
  return Uri.https(kUrl, '$kAppUrl/$url', params);
}

class NetworkHelper {
  //Login User
  Future<dynamic> loginUser(
      String email, String password, String url, BuildContext context) async {
    var body = Login(
      email: email,
      password: password,
    ).toJson();
    return await postRequest(body, url, context);
  }

  //Forgot Password
  Future<dynamic> forgotPassword(String email, BuildContext context) async {
    var body = ForgotPassword(email: email).toJson();
    return await postRequest(body, 'auth/user/forgotpassword', context);
  }

  // Register User
  Future<dynamic> registerParent(
      String email,
      String phone,
      String fullName,
      String password,
      String childName,
      String childAge,
      String childClass,
      BuildContext context) async {
    var body = Register(
            email: email,
            fullName: fullName,
            phone: phone,
            password: password,
            childName: childName,
            childAge: childAge,
            childClass: childClass)
        .toJson();
    print(body);
    return await postRequest(body, 'auth/parent/register', context);
  }

  //Get Grades
  Future<dynamic> getGrades(BuildContext context) async {
    final result = await getRequest(url: 'grades', context: context);
    return result['data'];
  }

  Future<dynamic> getRequest(
      {String url, String token, BuildContext context}) async {
    var response =
        await http.get(uriConverter(url), headers: kHeaders(token ?? null));
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(
          decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<dynamic> postTokenRequest(
      Map body, String url, String token, BuildContext context) async {
    print('body is $body');
    var response = await http.post(uriConverter(url),
        headers: kHeaders(token), body: json.encode(body));
    print(response.body);
    var decoded = jsonDecode(response.body);
    print('decoded is $decoded');
    if (response.statusCode.toString().startsWith('2')) {
      print('data: $decoded');
      return decoded;
    } else {
      print(
          'reason is ${response.reasonPhrase} message is ${decoded['message']}');
      throw ApiFailureException(decoded['message'] ?? response.reasonPhrase);
    }
  }

  Future<dynamic> postRequest(
      Map body, String url, BuildContext context) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(uriConverter(url),
        headers: kHeaders(null), body: json.encode(body));
    print(response.body);
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('data: $decoded');
      return decoded;
    } else {
      print(
          'reason is ${response.reasonPhrase} message is ${decoded['error']}');
      throw ApiFailureException(decoded['error'] ?? response.reasonPhrase);
    }
  }
}
