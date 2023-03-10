///alpha
// const String kUrl = 'oneskul.herokuapp.com';
// const String kUrl = 'api.oneschool.africa';
const String kUrl = 'staging.api.oneschool.africa';
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
const String kMainUser = 'mainUser';
const String kAppDataName = 'appData';
const String kSubject = 'subject';
const String kIndex = 'index';
const String kSingleGrade = 'singleGrade';
const String kTopic = 'topic';
const String kRecent = 'recentTopics';
const String kRecommended = 'recommendedVideo';
const String kVideo = 'video';
const String kQuiz = 'quiz';
const String kAnalyticsSubject = 'analyticsSubject';
const String kAnalyticsTopic = 'analyticsTopic';
const String kLiveStream = 'liveStream';
const String kQuizActive = 'quizActive';

class ConstantKey {
  static const String PAYSTACK_KEY =
      'pk_test_bc4e12caf8b003d22041733a8abaaf3adf2c0f6e';
}
