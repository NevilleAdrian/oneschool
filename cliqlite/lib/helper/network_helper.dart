import 'dart:convert';

import 'package:cliqlite/exceptions/api_failure_exception.dart';
import 'package:cliqlite/models/auth_model/forgot_password.dart';
import 'package:cliqlite/models/auth_model/login_model.dart';
import 'package:cliqlite/models/auth_model/registration_model.dart';
import 'package:cliqlite/models/users_model/add_user/add_user.dart';
import 'package:cliqlite/models/users_model/updateUser.dart';
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

    return await postRequest(body: body, url: url, context: context);
    ;
  }

  //Forgot Password
  Future<dynamic> forgotPassword(
      String email, BuildContext context, String url) async {
    var body = ForgotPassword(email: email).toJson();

    return await postRequest(body: body, url: url, context: context);
  }

  //Change Password
  Future<dynamic> changePassword(String currentPassword, String newPassword,
      String token, String url, BuildContext context) async {
    print('token:$token');
    var body = ChangePassword(
            currentPassword: currentPassword, newPassword: newPassword)
        .toJson();

    return await putRequest(
        body: body, url: url, token: token, context: context);
  }

  //Edit User Details
  Future<dynamic> updateUser(String name, int age, String imgUrl, String grade,
      String childId, String token, BuildContext context) async {
    var body =
        UpdateUser(name: name, age: age, grade: grade, photo: imgUrl).toJson();

    return await putRequest(
        body: body, url: 'users/$childId', token: token, context: context);
  }

  // Register User
  Future<dynamic> register(
      String email,
      String phone,
      String fullName,
      String password,
      String childName,
      String childAge,
      String childClass,
      String url,
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
    var childBody = {
      "email": email,
      "name": fullName,
      "password": password,
      "age": childAge,
      "grade": childClass
    };
    print(body);
    return await postRequest(
        body: url == 'auth/user/register' ? childBody : body,
        url: url,
        context: context);
  }

  //Get Grades
  Future<dynamic> getGrades(BuildContext context) async {
    final result = await getRequest(url: 'grades', context: context);
    return result['data'];
  }

  //Get Children
  Future<dynamic> getChildren(BuildContext context, String token) async {
    final result = await getRequest(
        url: 'parents/children', context: context, token: token);
    return result['data'];
  }

  //Get Subject
  Future<dynamic> getSubject(
      BuildContext context, String gradeId, String token) async {
    final result = await getRequest(
        url: 'grades/$gradeId/subjects', context: context, token: token);
    return result['data'];
  }

  //Get Subject by search
  Future<dynamic> getSubjectBySearch(
      BuildContext context, String description, String token) async {
    var params = {"searchKey": description, "limit": "4"};

    final result = await getParamRequest(
        url: 'subjects/search', params: params, context: context, token: token);
    return result['data'];
  }

  //Get Topic
  Future<dynamic> getTopic(
      BuildContext context, String subjectId, String token) async {
    final result = await getRequest(
        url: 'subjects/$subjectId/topics', context: context, token: token);
    return result['data'];
  }

  //Get Subject by search
  Future<dynamic> getTopicBySearch(
      BuildContext context, String description, String token) async {
    var params = {"searchKey": description, "limit": "4"};

    final result = await getParamRequest(
        url: 'topics/search', params: params, context: context, token: token);
    return result['data'];
  }

  //Get Topic
  Future<dynamic> getVideo(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'videos', context: context, token: token);
    return result['data'];
  }

  //Get Subject by search
  Future<dynamic> getVideoBySearch(
      BuildContext context, String description, String token) async {
    var params = {"searchKey": description, "limit": "4"};

    final result = await getParamRequest(
        url: 'videos/search', params: params, context: context, token: token);
    return result['data'];
  }

  //Get Quiz
  Future<dynamic> getQuiz(
      BuildContext context, String topicId, String token) async {
    final result = await getRequest(
        url: 'topics/$topicId/quizzes', context: context, token: token);
    return result['data'][0]['questions'];
  }

  //Get a Subscription
  Future<dynamic> getSubscription(
      BuildContext context, String childId, String token) async {
    final result = await getRequest(
        url: 'users/subscriptions/$childId', context: context, token: token);
    return result['data'];
  }

  //Get all Subscription
  Future<dynamic> getAllSubscriptions(
      BuildContext context, String token) async {
    final result =
        await getRequest(url: 'subscriptions', context: context, token: token);
    return result['data'];
  }

  //Get Support
  Future<dynamic> getSupport(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'faqs', context: context, token: token);
    return result['data'];
  }

  //Add User
  Future<dynamic> addUser(String name, int age, String grade, String token,
      BuildContext context) async {
    var body = AddUser(
      name: name,
      age: age,
      grade: grade,
    ).toJson();

    return await postRequest(
        body: body, url: 'parents/children', token: token, context: context);
  }

  Future<dynamic> getParamRequest(
      {String url,
      Map<String, dynamic> params,
      String token,
      BuildContext context}) async {
    var response = await http.get(uriConverterWithQuery(url, params),
        headers: kHeaders(token ?? null));
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(
          decoded['message'] ?? response.reasonPhrase ?? 'Unknown error');
    }
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

  Future<dynamic> putRequest(
      {Map body, String url, String token, BuildContext context}) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.put(uriConverter(url),
        headers: kHeaders(token ?? null), body: json.encode(body));
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

  Future<dynamic> postRequest(
      {Map body, String url, String token, BuildContext context}) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.post(uriConverter(url),
        headers: kHeaders(token ?? null), body: json.encode(body));
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
