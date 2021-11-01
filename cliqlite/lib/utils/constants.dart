///alpha
const String kUrl = 'cliq-lite.herokuapp.com';
const String kAppUrl = '/api/v1';
Map<String, String> _headers(String token) {
  return {'Content-type': 'application/json', 'Authorization': 'Bearer $token'};
}

const kHeaders = _headers;

//constants
const String kUser = 'user';
const String kFirst = 'first';
const String kGrades = 'grades';
const String kUsers = 'users';
const String kAppDataName = 'appData';
const String kSubject = 'subject';
const String kIndex = 'index';
const String kSingleGrade = 'singleGrade';
const String kTopic = 'topic';
const String kVideo = 'video';
const String kQuiz = 'quiz';
