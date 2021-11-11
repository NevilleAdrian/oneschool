import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChildRegistration extends StatefulWidget {
  static String id = 'child';

  ChildRegistration(
      {this.user, this.fullName, this.email, this.phoneNo, this.password});
  final String user;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  @override
  _ChildRegistrationState createState() => _ChildRegistrationState();
}

//years enum
enum Years { fifth, sixth, seventh, eighth, ninth, tenth }

//class enum
enum Class { first, second, third, fourth, fifth, sixth }

class _ChildRegistrationState extends State<ChildRegistration> {
  //Global Key
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //Validation
  Validations validations = new Validations();

  //Controllers
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();

  //validation boolean
  bool autoValidate = false;

  //Instantiate enum
  Years val = Years.fifth;

  //Instantiate enum
  String classVal = 'Grade-1';

  //Age
  String age;

  //Class
  String childClassName;

  //Route to next page
  nextPage() async {
    AuthProvider auth = AuthProvider.auth(context);

    print('hey');
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      if (widget.user == 'child') {
        print('yes');
        try {
          setState(() {
            AuthProvider.auth(context).setIsLoading(true);
          });

          var result = await AuthProvider.auth(context).addUser(
              _controllerName.text,
              int.parse(age?.replaceAll(' years', '') ?? '5'),
              childClassName ?? '6155798b81cc3265b9efaa9c');
          if (result != null) {
            if (auth.user.role != 'user') {
              await AuthProvider.auth(context).getChildren();
            } else {
              AuthProvider.auth(context).getMainChild();
            }

            Navigator.pushNamed(context, AppLayout.id);
            showFlush(context, 'Child Added Successfully', primaryColor);

            setState(() {
              AuthProvider.auth(context).setIsLoading(false);
            });
          }
        } catch (ex) {
          showFlush(context, ex.toString(), primaryColor);
          setState(() {
            AuthProvider.auth(context).setIsLoading(false);
          });
        }
      } else {
        try {
          setState(() {
            AuthProvider.auth(context).setIsLoading(true);
          });

          var result = await AuthProvider.auth(context).register(
              widget.email ?? _controllerEmail.text,
              widget.phoneNo,
              widget.fullName ?? _controllerName.text,
              widget.password ?? _controllerPassword.text,
              _controllerName.text,
              age?.replaceAll(' years', '') ?? '5',
              childClassName ?? '6155798b81cc3265b9efaa9c',
              widget.user == 'parent'
                  ? 'auth/user/register'
                  : 'auth/parent/register');
          if (result != null) {
            Navigator.pushNamed(context, Login.id);
            showFlush(context, 'Registration Successful', primaryColor);

            setState(() {
              AuthProvider.auth(context).setIsLoading(false);
            });
          }
        } catch (ex) {
          showFlush(context, ex.toString(), primaryColor);
          setState(() {
            AuthProvider.auth(context).setIsLoading(false);
          });
        }
      }
    }
  }

  //Add child
  addChild({Map<String, dynamic> child}) {
    ChildProvider.childProvider(context).setChild(child);
    if (ChildProvider.childProvider(context).children.isNotEmpty) {
      Navigator.pushNamed(context, AppLayout.id);
    }
  }

  //Child year data
  var childYears = [
    {"name": '5 years', "years": Years.fifth},
    {"name": '6 years', "years": Years.sixth},
    {"name": '7 years', "years": Years.seventh},
    {"name": '8 years', "years": Years.eighth},
    {"name": '9 years', "years": Years.ninth},
    {"name": '10 years', "years": Years.tenth},
  ];

  //Child class data
  var childClass = [
    {"name": 'Primary 1', "class": Class.first},
    {"name": 'Primary 2', "class": Class.second},
    {"name": 'Primary 3', "class": Class.third},
    {"name": 'Primary 4', "class": Class.fourth},
    {"name": 'Primary 5', "class": Class.fifth},
    {"name": 'Primary 6', "class": Class.sixth},
  ];

  void getGrades() async {
    var result = await AuthProvider.auth(context).getGrades();
    print('result: $result');
  }

  //init state
  @override
  void initState() {
    if (widget.user == 'parent') {
      getGrades();
      print('grades:${AuthProvider.auth(context).grades}');
    }
    print('name:${widget.fullName}');
    print('email:${widget.email}');
    print('phoneNo:${widget.phoneNo}');
    print('password:${widget.password}');
    print('user:${widget.user}');
    super.initState();
  }

  //Modal bottom sheet
  void bottomSheet(BuildContext context, String type) {
    List<Grades> grades = AuthProvider.auth(context).grades;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              'Close',
                              style: headingWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                    kVerySmallHeight,
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0)),
                            color: lightPrimaryColor),
                        height: 500.0,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 20),
                            child: ListView.builder(
                                itemCount: type == 'age'
                                    ? childYears.length
                                    : grades.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: type == 'age'
                                                ? childYears[index]['years']
                                                : toBeginningOfSentenceCase(
                                                    grades[index].name),
                                            groupValue:
                                                type == 'age' ? val : classVal,
                                            activeColor: primaryColor,
                                            onChanged: (var value) {
                                              setModalState(() {
                                                setState(() {});
                                                if (type == 'age') {
                                                  val = value;
                                                  age =
                                                      childYears[index]['name'];
                                                } else {
                                                  classVal = value;
                                                  childClassName =
                                                      grades[index].gradeId;
                                                  print(
                                                      'classNme:$childClassName');
                                                  print('classNme:$classVal');
                                                }
                                              });
                                            }),
                                        // kSmallWidth,
                                        Text(
                                          type == 'age'
                                              ? childYears[index]['name']
                                              : toBeginningOfSentenceCase(
                                                  grades[index].name),
                                          style: textLightBlack,
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = AuthProvider.auth(context);

    return BackgroundImage(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: defaultVHPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackArrow(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                kSmallHeight,
                widget.user != 'parent'
                    ? Text(
                        widget.user == 'child' ? "" : '02/02',
                        style: textLightBlack.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      )
                    : Container(),
                kSmallHeight,
                widget.user != 'parent'
                    ? (Text(
                        "Fill in your ${widget.user == 'child' ? "child's" : "personal"} details",
                        textAlign: TextAlign.center,
                        style: textStyleSmall.copyWith(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ))
                    : Text(
                        "Fill in your personal details",
                        textAlign: TextAlign.center,
                        style: textStyleSmall.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                kLargeHeight,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                          controllerName: _controllerName,
                          validations: validations.validateName,
                          hintText: widget.user != 'parent'
                              ? "Child's Name"
                              : 'Full Name',
                        ),
                        kSmallHeight,
                        if (widget.user == 'parent')
                          Column(
                            children: [
                              MyTextForm(
                                controllerName: _controllerEmail,
                                validations: validations.validateEmail,
                                hintText: 'Email',
                              ),
                              kSmallHeight,
                            ],
                          ),
                        if (widget.user == 'parent')
                          Column(
                            children: [
                              MyTextForm(
                                  controllerName: _controllerPassword,
                                  validations: validations.validatePassword,
                                  hintText: 'Password'),
                              kSmallHeight,
                            ],
                          ),
                        DropDown(
                          onTap: () => bottomSheet(context, 'age'),
                          text: widget.user != 'parent'
                              ? (age ?? "Child's Age")
                              : (age ?? "Age"),
                        ),
                        kSmallHeight,
                        DropDown(
                          onTap: () => bottomSheet(context, 'class'),
                          text: widget.user != 'parent'
                              ? (classVal ?? "Child's Class")
                              : (classVal ?? "Class"),
                        ),
                        kLargeHeight,
                        LargeButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name:
                              widget.user == 'child' ? 'Add Child' : 'Sign Up',
                          buttonColor: secondaryColor,
                          loader: auth.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  widget.user == 'child'
                                      ? 'Add Child'
                                      : 'Sign Up',
                                  style: headingWhite.copyWith(
                                    color: secondaryColor,
                                  ),
                                ),
                        ),
                        kLargeHeight,
                        // widget.user != 'parent'
                        //     ? Container()
                        //     : Text(
                        //         'Skip for now',
                        //         style: textExtraLightBlack,
                        //       )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DropDown extends StatelessWidget {
  DropDown({this.onTap, this.text});
  Function onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          suffixIcon: Icon(Icons.keyboard_arrow_down),
          contentPadding:
              EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          hintText: text,
          // labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(
            color: greyColor,
            fontFamily: "Montserrat",
          )),
      onTap: onTap,
    );
  }
}
