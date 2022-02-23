import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/subject/grade/grade.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SubjectProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  HiveRepository _hiveRepository = HiveRepository();
  static BuildContext _context;

  List<Subject> _subjects;
  Grade _grade;
  bool _spinner = false;
  ChildIndex _index;

  List<Subject> get subjects => _subjects;
  Grade get grade => _grade;
  bool get spinner => _spinner;
  ChildIndex get index => _index;

  setSubject(List<Subject> subjects) => _subjects = subjects;
  setGrade(Grade grade) => _grade = grade;
  setSpinner(bool spinner) => _spinner = spinner;
  setIndex(ChildIndex index) => _index = index;

  Future<List<Subject>> getSubjects({String id, String name, int index}) async {
    //save index in local storage
    if (index != null) {
      ChildIndex childIndex = ChildIndex.fromJson({"index": index});
      setIndex(childIndex);
      print('childIndex:${childIndex.index}');
      _hiveRepository.add<ChildIndex>(
          name: kIndex, key: 'index', item: childIndex);
    }

    // print('token:${AuthProvider.auth(_context).token}');
    //get subject
    var data = await _helper.getSubject(
        _context, grade?.grade ?? id, AuthProvider.auth(_context).token);

    print('subject: $data');

    data = (data as List).map((e) => Subject.fromJson(e)).toList();

    //Save subject in local storage
    setSubject(data);
    _hiveRepository.add<List<Subject>>(
        name: kSubject, key: 'subject', item: data);

    //Save grade in local storage
    var body = {"grade": id, "name": name};
    setGrade(Grade.fromJson(body));

    _hiveRepository.add<Grade>(
        name: kSingleGrade, key: 'singleGrade', item: Grade.fromJson(body));

    return data;
  }

  Future<List<Subject>> getSubjectsBySearch({String description}) async {
    //search for subjects
    var data = await _helper.getSubjectBySearch(
        _context, description, AuthProvider.auth(_context).token);

    data = (data as List).map((e) => Subject.fromJson(e)).toList();

    return data;
  }

  static SubjectProvider subject(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<SubjectProvider>(context, listen: listen);
  }
}
