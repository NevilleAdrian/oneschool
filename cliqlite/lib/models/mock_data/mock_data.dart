import 'package:cliqlite/screens/auth/child_registration.dart';

var data = [
  {"name": "MUSIC", "image": "assets/images/pic-1.png"},
  {"name": "WRITING", "image": "assets/images/pic-2.png"},
  {"name": "SCIENCE", "image": "assets/images/pic-3.png"},
  {"name": "ENGLISH", "image": "assets/images/pic-1.png"},
  {"name": "ENGLISH", "image": "assets/images/pic-1.png"},
];

var billingData = [
  {
    "date": "31/08/21",
    "timeStamp": "01/08/2021-31/08/2021",
    "amount": "3,600",
    "card_number": "**** **** **** 8495"
  },
  {
    "date": "20/10/21",
    "timeStamp": "01/08/2021-31/08/2021",
    "amount": "3,900",
    "card_number": "**** **** **** 8495"
  },
  {
    "date": "31/02/21",
    "timeStamp": "01/08/2021-31/08/2021",
    "amount": "45,000",
    "card_number": "**** **** **** 8495"
  },
  {
    "date": "24/08/21",
    "timeStamp": "01/08/2021-31/08/2021",
    "amount": "3,300",
    "card_number": "**** **** **** 8495"
  },
];

var pillData = [
  {"name": "Lorem Ipsum Dolor sit amet"},
  {"name": "Lorem Ipsum Dolor sit amet"},
  {"name": "Lorem Ipsum Dolor sit amet"},
  {"name": "Lorem Ipsum Dolor sit amet"}
];

List<dynamic> quizTypes = [
  {
    "description":
        "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. Volutpat vitae elementum?",
    "image": "assets/images/skeleton.png",
    "option1": "Lorem ipsum dolor",
    "option2": "Lorem ipsum",
    "option3": "Lorem ipsum dolor",
    "option4": "Lorem ipsum dolor",
    "correctAnswer": "Lorem ipsum",
    "type": "optionType"
  },
  {
    "description":
        "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit. Volutpat vitae elementum?",
    "image": "assets/images/skeleton.png",
    "option1": "Lorem ipsum",
    "option2": "Lorem ipsum rigiueuee",
    "option3": "Lorem ipsum dolor",
    "option4": "Lorem ipsum dolor",
    "correctAnswer": "Lorem ipsum",
    "type": "optionType"
  },
  {
    "description": "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit",
    "image": "assets/images/elephant.png",
    "questions": [
      {
        "id": 1,
        "name": "E",
        "active": true,
      },
      {"id": 2, "name": "L", "active": false},
      {"id": 3, "name": "E", "active": false},
      {"id": 4, "name": "P", "active": true},
      {"id": 5, "name": "H", "active": false},
      {"id": 6, "name": "A", "active": true},
      {"id": 7, "name": "N", "active": true},
      {"id": 8, "name": "T", "active": false},
    ],
    "options": [
      {"name": "E"},
      {"name": "K"},
      {"name": "T"},
      {"name": "H"},
      {"name": "L"},
      {"name": "O"},
    ],
    "type": "completeType"
  },
];

var tutorData = [
  {
    "name": "Lorem Ipsum",
    "subject": "English",
    "online": true,
    "image": "assets/images/tutor-image.png"
  },
  {
    "name": "Lorem Ipsum",
    "subject": "Maths",
    "online": false,
    "image": "assets/images/tutor-image.png"
  },
  {
    "name": "Lorem Ipsum",
    "subject": "Science",
    "online": false,
    "image": "assets/images/tutor-image.png"
  },
  {
    "name": "Lorem Ipsum",
    "subject": "Geography",
    "online": true,
    "image": "assets/images/tutor-image.png"
  },
];

var liveData = [
  {'name': 'All'},
  {'name': 'Per Subject'},
  {'name': 'Ongoing'},
  {'name': 'Upcoming'},
];

var quizzData = [
  {
    "_id": "616f255a668b55206a6f4038",
    "description": "My first quiz",
    "duration": 15,
    "topic": "616b16feb12f1c64cfaebfff",
    "createdAt": "2021-10-19T20:06:50.950Z",
    "__v": 0,
    "questions": [
      // {
      //   "_id": "6177cca920ddc7d4e7d3b48b",
      //   "resource": {
      //     "description": ["Lorem ipsumn"],
      //     "image": ["assets/images/elephant.png"],
      //     "questions": [
      //       {"id": 1, "name": "E", "active": true},
      //       {"id": 2, "name": "L", "active": false},
      //       {"id": 3, "name": "E", "active": false},
      //       {"id": 4, "name": "P", "active": true},
      //       {"id": 5, "name": "H", "active": false},
      //       {"id": 6, "name": "A", "active": true},
      //       {"id": 7, "name": "N", "active": true},
      //       {"id": 8, "name": "T", "active": false}
      //     ],
      //     "options": [
      //       {"name": "E"},
      //       {"name": "K"},
      //       {"name": "T"},
      //       {"name": "H"},
      //       {"name": "L"},
      //       {"name": "O"}
      //     ],
      //     "type": ["gaps"]
      //   },
      //   "quiz": "616f255a668b55206a688888",
      //   "createdAt": "2021-10-26T09:38:49.698Z",
      //   "__v": 0
      // },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      {
        "_id": "6177cd0620ddc7d4e7d3b48e",
        "resource": {
          "description": [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec"
          ],
          "image": ["assets/images/elephant.png"],
          "option1": ["Lorem ipsum dolor"],
          "option2": ["Lorem ipsum"],
          "option3": ["Lorem ipsum dolor"],
          "option4": ["Lorem ipsum dolor"],
          "correctAnswer": ["Lorem ipsum"],
          "explanation":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consecLorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum Lorem ipsum dolor sit amet, consec",
          "type": ["trivia"]
        },
        "quiz": "616f255a668b55206a6f4038",
        "createdAt": "2021-10-26T09:40:22.084Z",
        "__v": 0
      },
      // {
      //   "_id": "6177cca920ddc7d4e7d3765b",
      //   "resource": {
      //     "description": ["Lorem ipsum initif"],
      //     "image": ["assets/images/mona.jpg"],
      //     "questions": [
      //       {"id": 1, "name": "M", "active": true},
      //       {"id": 2, "name": "O", "active": false},
      //       {"id": 3, "name": "N", "active": false},
      //       {"id": 4, "name": "A", "active": true},
      //       {"id": 5, "name": "L", "active": false},
      //       {"id": 6, "name": "I", "active": true},
      //       {"id": 7, "name": "S", "active": true},
      //       {"id": 8, "name": "A", "active": false}
      //     ],
      //     "options": [
      //       {"name": "L"},
      //       {"name": "K"},
      //       {"name": "A"},
      //       {"name": "N"},
      //       {"name": "L"},
      //       {"name": "O"}
      //     ],
      //     "type": ["gaps"]
      //   },
      //   "quiz": "616f255ff68b58606a6f9999",
      //   "createdAt": "2021-10-26T09:38:49.698Z",
      //   "__v": 0
      // },
    ],
    "id": "616f255a668b55206a6f4038"
  }
];

var paymentType = ['one-off', 'recurring'];

//Child year data
var childYears = [
  {"name": '5 years', "years": Years.fifth},
  {"name": '6 years', "years": Years.sixth},
  {"name": '7 years', "years": Years.seventh},
  {"name": '8 years', "years": Years.eighth},
  {"name": '9 years', "years": Years.ninth},
  {"name": '10 years', "years": Years.tenth},
];

var analyticData = {
  "highestPerformingSubject": {"name": "Mathematics", "no": 0.0},
  "videosWatched": 0,
  "quizCompleted": 0,
  "graph": []
};
