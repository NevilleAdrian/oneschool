///alpha
const String kUrl = 'cliq-lite.herokuapp.com';
const String kAppUrl = '/api/v1';
Map<String, String> _headers(String token) {
  return {'Content-type': 'application/json', 'b-access-token': token};
}

const kHeaders = _headers;

//constants
const String kUser = 'user';
const String kFirst = 'first';
const String kGrades = 'grades';
const String kChildren = 'children';
