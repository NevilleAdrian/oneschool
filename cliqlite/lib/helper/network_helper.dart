import 'dart:convert';
import 'dart:io';

import 'package:cliqlite/exceptions/api_failure_exception.dart';
import 'package:cliqlite/models/auth_model/forgot_password.dart';
import 'package:cliqlite/models/auth_model/login_model.dart';
import 'package:cliqlite/models/auth_model/registration_model.dart';
import 'package:cliqlite/models/users_model/add_user/add_user.dart';
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
  }

  //Forgot Password
  Future<dynamic> forgotPassword(
      String email, BuildContext context, String url) async {
    var body = ForgotPassword(email: email).toJson();

    return await postRequest(body: body, url: url, context: context);
  }

  //Verify Account
  Future<dynamic> verifyAccount(int token, BuildContext context,
      {String url}) async {
    var body = {"token": token};

    var data = await putRequest(
        body: body, url: url ?? 'auth/parent/verify', context: context);
    return data;
  }

  //Reset OTP
  Future<dynamic> resendOTP(String email, BuildContext context) async {
    var body = {
      "email": email,
    };

    var data = await postRequest(
        body: body, url: 'auth/parent/resend', context: context);
    return data;
  }

  //Reset Account
  Future<dynamic> resetPassword(int token, String password,
      String confirmPassword, BuildContext context) async {
    var body = {
      "token": token,
      "password": password,
      "retypePassword": confirmPassword
    };

    var data = await putRequest(
        body: body, url: 'auth/parent/resetpassword', context: context);
    return data;
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
  Future<dynamic> updateUser(String name, String dob, File imgFile,
      String grade, String childId, String token, BuildContext context) async {
    // var body =
    //     UpdateUser(name: name, age: age, grade: grade, photo: imgUrl).toJson();

    print('imgfile: $imgFile');
    var request =
        new http.MultipartRequest("PUT", uriConverter('users/$childId'));
    request.headers.addAll(kHeaders(token));
    request.fields['name'] = name;
    request.fields['dob'] = dob;
    request.fields['grade'] = grade;
    if (imgFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('photo', imgFile?.path));
    }

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    print('decode:${responsed.body}');

    final responseData = jsonDecode(responsed.body);

    if (response.statusCode.toString().startsWith('2')) {
      print('decode:$responseData');
      return responseData;
    } else {
      print(
          'reason is ${response.reasonPhrase} message is ${responseData['error']}');
      throw ApiFailureException(responseData['error'] ?? response.reasonPhrase);
    }
    // return await putRequest(
    //     body: map, url: 'users/$childId', token: token, context: context);
  }

  // Register User
  Future<dynamic> register(
      String email,
      String phone,
      String fullName,
      String password,
      String childName,
      String dob,
      String childClass,
      String catId,
      String url,
      BuildContext context) async {
    var body = Register(
            email: email,
            fullName: fullName,
            phone: phone,
            password: password,
            childName: childName,
            dob: dob,
            childClass: childClass,
            category: catId)
        .toJson();
    var childBody = {
      "email": email,
      "name": fullName,
      "password": password,
      "dob": dob,
      "grade": childClass,
      "category": catId
    };
    print(body);
    return await postRequest(
        body: url == 'auth/user/register' ? childBody : body,
        url: url,
        context: context);
  }

  //Get Categories
  Future<dynamic> getCategories(BuildContext context) async {
    final result = await getRequest(url: 'categories', context: context);
    return result['data'];
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

  //Get Children
  Future<dynamic> getChildUser(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'auth/user/me', context: context, token: token);
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
    var params = {"search": description};

    final result = await getParamRequest(
        url: 'topics', params: params, context: context, token: token);
    return result['data'];
  }

  //Get Topic
  Future<dynamic> getTopic(BuildContext context, String subjectId,
      String childId, String token) async {
    final result = await getRequest(
        url: 'topics/subjects/$subjectId/$childId',
        context: context,
        token: token);
    return result['data'];
  }

  //Get Recent Topic
  Future<dynamic> getRecentTopic(
      BuildContext context, String childId, String token) async {
    final result = await getRequest(
        url: 'topics/lastviewed/$childId', context: context, token: token);
    return result['data'];
  }

  //Get Subject by search
  Future<dynamic> getTopicBySearch(
      BuildContext context, String description, String token) async {
    var params = {"search": description};

    final result = await getParamRequest(
        url: 'topics', params: params, context: context, token: token);
    print('topicsResult:$result');
    return result['data'];
  }

  //Get Topic
  Future<dynamic> getVideo(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'videos', context: context, token: token);
    return result['data'];
  }

  //Get Topic
  Future<dynamic> getTopicVideos(
      String topicId, BuildContext context, String token) async {
    final result = await getRequest(
        url: 'topics/$topicId/videos', context: context, token: token);
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
    // var params = {
    //   "childId": childId,
    // };

    final result = await getRequest(
        url: 'questions/topics/$topicId',
        // params: params,
        context: context,
        token: token);
    return result['data'];
  }

  //Get Quiz
  Future<dynamic> getQuickQuiz(
      BuildContext context, String subjectId, String token) async {
    final result = await getRequest(
        url: 'questions/subjects/$subjectId', context: context, token: token);
    return result['data'];
  }

  //Submit Quiz
  Future<dynamic> submitQuiz(int score, String childId, String quizId,
      String token, BuildContext context) async {
    var body = {"score": score, "childId": childId};

    return await postRequest(
        body: body,
        url: 'quizzes/$quizId/submit',
        token: token,
        context: context);
  }

  //Submit Feedback
  Future<dynamic> submitFeedback(String topicId, String text, double rating,
      String token, BuildContext context) async {
    var body = {
      "message": text,
    };

    return await postRequest(
        body: body, url: 'feedbacks', token: token, context: context);
  }

  //Get a Subscription
  Future<dynamic> getSubscription(
      BuildContext context, String childId, String token) async {
    final result = await getRequest(
        url: 'subscriptions/children/$childId', context: context, token: token);
    print('result:$result');
    return result['data'];
  }

  //Get a Subscription
  Future<dynamic> getCards(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'cards', context: context, token: token);
    print('result:$result');
    return result['data'];
  }

  //Get a Subscription
  Future<dynamic> getTransactions(
      BuildContext context, String childId, String token) async {
    final result = await getRequest(
        url: 'subscriptions/plan/$childId', context: context, token: token);
    return result['data'];
  }

  //Get all Subscription
  Future<dynamic> getAllSubscriptions(
      BuildContext context, String token) async {
    final result =
        await getRequest(url: 'plans', context: context, token: token);
    return result['data'];
  }

  //Get Support
  Future<dynamic> getSupport(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'supports', context: context, token: token);
    return result['data'];
  }

  //Get Recommended
  Future<dynamic> getRecommendedVideo(
      String childId, BuildContext context, String token) async {
    final result = await getRequest(
        url: 'topics/videos/dashboard/random/$childId',
        context: context,
        token: token);
    print('result:$result');
    return result['data'];
  }

  //Get Notification
  Future<dynamic> getNotification(BuildContext context, String token) async {
    final result = await getRequest(
        url: 'notifications/me', context: context, token: token);
    return result['data'];
  }

  //Get Feedback
  Future<dynamic> getFeedback(BuildContext context, String token) async {
    final result =
        await getRequest(url: 'feedbacks', context: context, token: token);
    return result['data'];
  }

  //Get Analytics Subject
  Future<dynamic> getAnalyticsSubject(
      BuildContext context, String id, String token) async {
    final result = await getRequest(
        url: 'users/$id/dashboard/subjects', context: context, token: token);
    return result['data'];
  }

  //Get Analytics Topic
  Future<dynamic> getAnalyticsTopic(
      BuildContext context, String childId, String token) async {
    var params = {"status": "month"};
    final result = await getParamRequest(
        url: 'users/analysis/$childId',
        params: params,
        context: context,
        token: token);
    return result['data'];
  }

  //Get Analytics Topic
  Future<dynamic> getTestResults(
      BuildContext context, String childId, String token) async {
    final result = await getRequest(
        url: 'users/results/$childId', context: context, token: token);
    return result['data'];
  }

  //Get Analytics Subject
  Future<dynamic> getLiveStream(
      BuildContext context, String grade, String token) async {
    var params = {"grade": grade};

    final result = await getParamRequest(
        url: 'livestreams', params: params, context: context, token: token);

    print('result!!:$result');
    return result['data'];
  }

  //Add Subscription
  Future<dynamic> toggleSubscription(
      String subId, String type, String token, BuildContext context) async {
    var params = {"type": type};

    return await patchParamRequest(
        url: 'subscriptions/$subId',
        params: params,
        token: token,
        context: context);
  }

  //Add Subscription
  Future<dynamic> addSubscription(String subId, String childId, String type,
      String token, BuildContext context,
      [String cardId]) async {
    var body = {
      "plan": subId,
      "childId": childId,
      "type": type,
      "device": "mobile"
    };

    var cardBody = {
      "plan": subId,
      "childId": childId,
      "type": type,
      "card": cardId,
      "device": "mobile"
    };

    return await postRequest(
        body: cardId == null ? body : cardBody,
        url: 'subscriptions',
        token: token,
        context: context);
  }

  //Add Card
  Future<dynamic> addCard(String token, BuildContext context) async {
    return await postRequest(url: 'cards', token: token, context: context);
  }

  //delete Card
  Future<dynamic> deleteCard(
      String id, String token, BuildContext context) async {
    return await http.delete(
      uriConverter('cards/$id'),
      headers: kHeaders(token ?? null),
    );
  }

  //Verify Subscription
  Future<dynamic> verifySubscription(
      String id, String ref, BuildContext context, String token) async {
    final result = await getRequest(
        url: 'users/transaction/$id/verify/$ref',
        context: context,
        token: token);
    return result['data'];
  }

  //Add User
  Future<dynamic> addUser(String name, String dob, String image, String grade,
      String catId, String token, BuildContext context) async {
    var body = AddUser(
            name: name, dob: dob, grade: grade, image: image, category: catId)
        .toJson();

    print('body: $body');
    return await postRequest(
        body: body, url: 'parents/children', token: token, context: context);
  }

  Future<dynamic> getParamRequest(
      {String url,
      Map<String, dynamic> params,
      String token,
      BuildContext context}) async {
    print('url: ${uriConverterWithQuery(url, params)}');
    print('token: $token');

    var response = await http.get(uriConverterWithQuery(url, params),
        headers: kHeaders(token ?? null));
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(
          decoded['msg'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<dynamic> patchParamRequest(
      {String url,
      Map body,
      Map<String, dynamic> params,
      String token,
      BuildContext context}) async {
    print('url: ${uriConverterWithQuery(url, params)}');
    var response = await http.patch(uriConverterWithQuery(url, params),
        headers: kHeaders(token ?? null),
        body: body == null ? null : json.encode(body));
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(
          decoded['msg'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<dynamic> getRequest(
      {String url, String token, BuildContext context}) async {
    var response =
        await http.get(uriConverter(url), headers: kHeaders(token ?? null));
    print('response:${response.body}');

    var decoded = jsonDecode(response.body);

    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(
          decoded['msg'] ?? response.reasonPhrase ?? 'Unknown error');
    }
  }

  Future<dynamic> patchRequest(
      {Map body, String url, String token, BuildContext context}) async {
    print('body is $body');
    print('Encoded body ${json.encode(body)}');
    var response = await http.patch(uriConverter(url),
        headers: kHeaders(token ?? null),
        body: body == null ? null : json.encode(body));
    print(response.body);
    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('decode:$decoded');
      return decoded;
    } else {
      print(
          'reason is ${response.reasonPhrase} message is ${decoded['error']}');
      throw ApiFailureException(decoded['error'] ?? response.reasonPhrase);
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
      print('decode:$decoded');
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
    print('Url ${uriConverter(url)}');
    var response = await http.post(uriConverter(url),
        headers: kHeaders(token ?? null),
        body: body == null ? null : json.encode(body));
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
