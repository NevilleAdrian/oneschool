import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';

class ChildRegistration extends StatefulWidget {
  static String id = 'child';

  ChildRegistration({this.user});
  final String user;

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

  //validation boolean
  bool autoValidate = false;

  //Instantiate enum
  Years val = Years.fifth;

  //Instantiate enum
  Class classVal = Class.first;

  //Age
  String age;

  //Class
  String childClassName;

  //Route to next page
  nextPage() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      Navigator.pushNamed(context, ChildRegistration.id);
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

  //Modal bottom sheet
  void bottomSheet(BuildContext context, String type) {
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
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0)),
                              color: lightPrimaryColor),
                          height: 500.0,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              child: ListView.builder(
                                  itemCount: type == 'age'
                                      ? childYears.length
                                      : childClass.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Radio(
                                              value: type == 'age'
                                                  ? childYears[index]['years']
                                                  : childClass[index]['class'],
                                              groupValue: type == 'age'
                                                  ? val
                                                  : classVal,
                                              activeColor: primaryColor,
                                              onChanged: (var value) {
                                                setModalState(() {
                                                  setState(() {});
                                                  if (type == 'age') {
                                                    val = value;
                                                    age = childYears[index]
                                                        ['name'];
                                                  } else {
                                                    classVal = value;
                                                    childClassName =
                                                        childClass[index]
                                                            ['name'];
                                                  }
                                                });
                                              }),
                                          // kSmallWidth,
                                          Text(
                                            type == 'age'
                                                ? childYears[index]['name']
                                                : childClass[index]['name'],
                                            style: textLightBlack,
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                        ),
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
                              ? (childClassName ?? "Child's Class")
                              : (childClassName ?? "Class"),
                        ),
                        kLargeHeight,
                        LargeButton(
                          submit: () => widget.user == 'child'
                              ? addChild(child: {
                                  "name": _controllerName.text,
                                  "image_url": "assets/images/picture.png",
                                })
                              : nextPage(),
                          color: primaryColor,
                          name:
                              widget.user == 'child' ? 'Add Child' : 'Sign Up',
                          buttonColor: secondaryColor,
                        ),
                        kLargeHeight,
                        widget.user != 'parent'
                            ? Container()
                            : Text(
                                'Skip for now',
                                style: textExtraLightBlack,
                              )
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
