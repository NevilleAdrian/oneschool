import 'dart:convert';

import 'package:cliqlite/exceptions/api_failure_exception.dart';
import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/auth_model/auth_user/auth_user.dart';
import 'package:cliqlite/models/auth_model/first_time/first_time.dart';
import 'package:cliqlite/models/children_model/children.dart';
import 'package:cliqlite/models/grades/grades.dart';
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
  AuthUser _user;
  FirstTime _first;
  List<Grades> _grades;
  List<Children> _children;

  bool get isLoading => _isLoading;
  AuthUser get user => _user;
  FirstTime get first => _first;
  List<Grades> get grades => _grades;
  List<Children> get children => _children;

  setIsLoading(bool isLoading) => _isLoading = isLoading;
  setUser(AuthUser user) => _user = user;
  setFirst(FirstTime first) => _first = first;
  setGrades(List<Grades> grades) => _grades = grades;
  setChildren(List<Children> children) => _children = children;

  Future<dynamic> registerParent(emailAddress, phone, fullName, password,
      childName, childAge, childClass) async {
    try {
      var data = await _helper.registerParent(
        emailAddress,
        phone,
        fullName,
        password,
        childName,
        childAge,
        childClass,
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
      var data = await _helper.loginUser(emailAddress, password, url, _context);

      setUser(AuthUser.fromJson(parseJwtPayLoad(data['token'])));

      _hiveRepository.add<AuthUser>(name: kUser, key: 'user', item: user);

      if (role == 'parent') {
        setChildren(
            (data['data'] as List).map((e) => Children.fromJson(e)).toList());
        _hiveRepository.add<List<Children>>(
            name: kChildren, key: 'children', item: children);
      }
      return data;
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      var data = await _helper.forgotPassword(email, _context);
      print('forgot password data$data');
    } catch (ex) {
      throw ApiFailureException(ex);
    }
  }

  Future<List<Grades>> getGrades() async {
    var data = await _helper.getGrades(_context);
    data = (data as List).map((e) => Grades.fromJson(e)).toList();
    setGrades(data);
    _hiveRepository.add<List<Grades>>(name: kGrades, key: 'grades', item: data);
    return data;
  }

  logout() {
    setUser(null);

    _hiveRepository.clear<AuthUser>(name: kUser);
  }

  FirstTime myFirst(FirstTime myFirst) {
    setFirst(myFirst);
    return myFirst;
  }

  Map<String, dynamic> parseJwtPayLoad(String token) {
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
