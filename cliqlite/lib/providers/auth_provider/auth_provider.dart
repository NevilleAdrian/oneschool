import 'dart:convert';
import 'dart:io';

import 'package:cliqlite/exceptions/api_failure_exception.dart';
import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/app_model/app_model.dart';
import 'package:cliqlite/models/auth_model/auth_user/auth_user.dart';
import 'package:cliqlite/models/auth_model/first_time/first_time.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/categories/categories.dart';
import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/models/subject/grade/grade.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/analytics_provider/analytics_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/providers/video_provider/video_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  static BuildContext _context;
  NetworkHelper _helper = NetworkHelper();
  HiveRepository _hiveRepository = HiveRepository();

  bool _isLoading = false;
  String _token;
  AuthUser _user;
  FirstTime _first;
  List<Grades> _grades;
  List<Categories> _categories;
  List<Users> _users;
  MainChildUser _mainChildUser;
  PageController _pageController;
  bool _firstTime = false;

  bool get isLoading => _isLoading;
  String get token => _token;
  AuthUser get user => _user;
  FirstTime get first => _first;
  List<Grades> get grades => _grades;
  List<Categories> get categories => _categories;
  List<Users> get users => _users;
  MainChildUser get mainChildUser => _mainChildUser;
  PageController get pageController => _pageController;
  bool get firstTime => _firstTime;

  setIsLoading(bool isLoading) => _isLoading = isLoading;
  setToken(String token) => _token = token;
  setUser(AuthUser user) => _user = user;
  setFirst(FirstTime first) => _first = first;
  setCategories(List<Categories> categories) => _categories = categories;
  setGrades(List<Grades> grades) => _grades = grades;
  setUsers(List<Users> users) => _users = users;
  setMainChildUser(MainChildUser mainChildUser) =>
      _mainChildUser = mainChildUser;
  setPageController(PageController controller) => _pageController = controller;
  setFirstTime(bool firstTime) => _firstTime = firstTime;

  Future<dynamic> register(emailAddress, phone, fullName, password, childName,
      dob, childClass, String catId, String url) async {
    try {
      var data = await _helper.register(
        emailAddress,
        phone,
        fullName,
        password,
        childName,
        dob,
        childClass,
        catId,
        url,
        _context,
      );
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> loginUser(
      String emailAddress, String password, String url, String role) async {
    try {
      //Login user

      var data = await _helper.loginUser(emailAddress, password, url, _context);

      //Decode token and save user
      setUser(AuthUser.fromJson(parseJwtPayLoad(data['data']['token'])));

      //Set first Time
      setFirstTime(data['data']['parentDetails'] == null
          ? data['data']['childDetails']['firstTime']
          : data['data']['parentDetails']['firstTime']);

      //Save decoded user in local storage
      _hiveRepository.add<AuthUser>(name: kUser, key: 'user', item: user);

      //Make call to get grades
      await getGrades();

      //Save token in local storage
      setToken(data['data']['token']);

      print('token:$token');
      print('user:${user.toJson()}');
      _hiveRepository.add<AppModel>(
          name: kAppDataName, key: 'appModel', item: AppModel(token: token));

      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> forgotPassword(String email, String url) async {
    try {
      //Call forget Password
      var data = await _helper.forgotPassword(email, _context, url);
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> verifyAccount(int toks, {String url}) async {
    try {
      //Call verify Account
      var data = await _helper.verifyAccount(toks, _context, url: url);

      //Decode token and save user
      setUser(AuthUser.fromJson(parseJwtPayLoad(data['data']['token'])));

      //Save decoded user in local storage
      _hiveRepository.add<AuthUser>(name: kUser, key: 'user', item: user);

      //Make call to get grades
      await getGrades();

      //Save token in local storage
      setToken(data['data']['token']);

      print('token:$token');
      print('user:${user.toJson()}');
      _hiveRepository.add<AppModel>(
          name: kAppDataName, key: 'appModel', item: AppModel(token: token));
      return data;
    } catch (ex) {
      print('dataz:$ex');
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> resetPassword(
      int token, String password, String confirmPassword) async {
    try {
      //Call reset Password
      var data = await _helper.resetPassword(
          token, password, confirmPassword, _context);
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> resendOtp(String email) async {
    try {
      //Call reset Password
      var data = await _helper.resendOTP(email, _context);
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> changePassword(
      String currentPassword, String newPassword, String url) async {
    try {
      //Call forget Password
      var data = await _helper.changePassword(
          currentPassword, newPassword, token, url, _context);
      print('forgot password data$data');
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> addUser(
      String name, String dob, String image, String catId, String grade) async {
    print('catID: $catId');
    try {
      //Add child user
      var data = await _helper.addUser(
          name, dob, image, grade, catId, token, _context);
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> updateUser(String name, String dob, File imgFile,
      String grade, String childId) async {
    print('gradeId: $grade');
    try {
      //Add child user
      var data = await _helper.updateUser(
          name, dob, imgFile, grade, childId, token, _context);
      return data;
    } catch (ex) {
      print('ex:$ex');
      throw ApiFailureException(ex);
    }
  }

  Future<List<Users>> getChildren() async {
    //Get children
    var data = await _helper.getChildren(_context, token);
    print('childrenData: $data');
    data = (data as List).map((e) => Users.fromJson(e)).toList();
    print('modifiedData: ${data[0].toJson()}');

    //Save Children users in local storage
    setUsers(data);
    notifyListeners();
    _hiveRepository.add<List<Users>>(name: kUsers, key: 'users', item: data);
    return data;
  }

  Future<MainChildUser> getMainChild() async {
    //Get children
    try {
      var data = await _helper.getChildUser(_context, token);
      print('childUser: $data');

      data = MainChildUser.fromJson(data);

      //Save Children users in local storage
      setMainChildUser(data);
      notifyListeners();
      _hiveRepository.add<MainChildUser>(
          name: kMainUser, key: 'mainUser', item: data);
      return data;
    } catch (ex) {
      print('ex:${ex.toString()}');
    }
  }

  Future<List<Categories>> getCategories() async {
    //Get categories
    var data = await _helper.getCategories(_context);
    print('categories:$data');

    data = (data as List).map((e) => Categories.fromJson(e)).toList();

    print('categoriess:$data');

    //Save categories in local storage
    setCategories(data);
    return data;
  }

  Future<List<Grades>> getGrades() async {
    //Get grades
    var data = await _helper.getGrades(_context);
    print('grades:$data');

    data = (data as List).map((e) => Grades.fromJson(e)).toList();

    //Save grades in local storage
    setGrades(data);
    notifyListeners();
    _hiveRepository.add<List<Grades>>(name: kGrades, key: 'grades', item: data);
    return data;
  }

  logout() {
    //Clear local storage
    setUser(null);
    setToken(null);
    setUsers(null);

    SubjectProvider.subject(_context).setSubject(null);
    SubjectProvider.subject(_context).setGrade(null);
    TopicProvider.topic(_context).setTopic(null);
    VideoProvider.video(_context).setVideo(null);
    AnalyticsProvider.analytics(_context).setTopic(null);
    AnalyticsProvider.analytics(_context).setSubject(null);

    _hiveRepository.clear<AuthUser>(name: kUser);
    _hiveRepository.clear<AppModel>(name: kAppDataName);
    _hiveRepository.clear<List<Users>>(name: kUsers);
    _hiveRepository.clear<List<Subject>>(name: kSubject);
    _hiveRepository.clear<Grade>(name: kSingleGrade);
    _hiveRepository.clear<List<Grades>>(name: kGrades);
    _hiveRepository.clear<List<Subject>>(name: kSubject);
    _hiveRepository.clear<List<Topic>>(name: kTopic);
    _hiveRepository.clear<List<Video>>(name: kVideo);
  }

  FirstTime myFirst(FirstTime myFirst) {
    //Save first time user
    setFirst(myFirst);
    return myFirst;
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
    //Decode token
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    print('pmp: $payloadMap');
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static AuthProvider auth(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<AuthProvider>(context, listen: listen);
  }
}
