import 'dart:io';

import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/categories/categories.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/verify_account.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/capture_image.dart';
import 'package:cliqlite/utils/have_account.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/top_bar.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ChildRegistration extends StatefulWidget {
  static String id = 'child';

  ChildRegistration(
      {this.user,
      this.fullName,
      this.email,
      this.phoneNo,
      this.password,
      this.type});
  final String user;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String type;

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
  TextEditingController _controllerAge = new TextEditingController();

  //validation boolean
  bool autoValidate = false;

  //Instantiate enum
  Years val = Years.fifth;

  //Instantiate enum
  String classVal = 'Select Class';

  //Age
  String age;

  String cat;
  String catId;

  //Class
  String childClassName;

  //Initialize firebase storage
  final _storage = FirebaseStorage.instance;

  bool _oldVisible = true;

  addUser() {
    print('hey');
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      if (_croppedImageFile != null) {
        setState(() {
          AuthProvider.auth(context).setIsLoading(true);
        });
        Reference reference =
            _storage.ref().child("updateProfile" + DateTime.now().toString());
        UploadTask uploadTask = reference.putFile(_croppedImageFile);
        uploadTask.whenComplete(() async {
          try {
            imageUrl = await reference.getDownloadURL();
            setState(() {});
            print('url: $imageUrl');
            if (imageUrl != null) {
              nextPage(imageUrl: imageUrl);
            }
          } catch (ex) {
            print('ex: $ex');
          }
        });
      } else {
        List<Users> children = AuthProvider.auth(context).users;
        ChildIndex childIndex = SubjectProvider.subject(context).index;
        MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
        nextPage(
            imageUrl: children != null
                ? children[childIndex?.index ?? 0].photo
                : mainChildUser?.photo);
      }
    }
  }

  //Route to next page
  nextPage({String imageUrl}) async {
    AuthProvider auth = AuthProvider.auth(context);
    if (catId == null) {
      showFlush(context, 'Please select a category', primaryColor);
    } else {
      if (widget.user == 'child') {
        print('yes');
        try {
          setState(() {
            AuthProvider.auth(context).setIsLoading(true);
          });

          var result = await AuthProvider.auth(context).addUser(
              _controllerName.text,
              birthDate ??
                  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
              // int.parse(age?.replaceAll(' years', '') ?? '5'),
              imageUrl ??
                  'https://images.pexels.com/photos/8264629/pexels-photo-8264629.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
              catId,
              childClassName ?? AuthProvider.auth(context).grades[0].id);
          if (result != null) {
            if (auth.user.role != 'user') {
              await AuthProvider.auth(context).getChildren();
            } else {
              AuthProvider.auth(context).getMainChild();
            }

            Navigator.of(context).pushNamedAndRemoveUntil(
                AppLayout.id, (Route<dynamic> route) => false);
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
              birthDate ??
                  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
              childClassName ?? AuthProvider.auth(context).grades[0].id,
              catId,
              widget.user == 'parent'
                  ? 'auth/user/register'
                  : 'auth/parent/register');
          if (result != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerifyAccount(
                          type: widget.type,
                          email: widget.email ?? _controllerEmail.text,
                          url: widget.user == 'parent'
                              ? 'auth/user/verify'
                              : 'auth/parent/verify',
                        )));
            showFlush(context, 'Successfully Registered', primaryColor);

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
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppLayout.id, (Route<dynamic> route) => false);
    }
  }

  //Child class data
  var childClass = [
    {"name": 'Primary 1', "class": Class.first},
    {"name": 'Primary 2', "class": Class.second},
    {"name": 'Primary 3', "class": Class.third},
    {"name": 'Primary 4', "class": Class.fourth},
    {"name": 'Primary 5', "class": Class.fifth},
    {"name": 'Primary 6', "class": Class.sixth},
  ];

  Future<List<Categories>> futureCategory;

  Future<List<Categories>> futureTask() async {
    //Initialize provider
    AuthProvider auth = AuthProvider.auth(context);

    //Make call to get videos
    try {
      var result = await auth.getCategories();
      if (widget.user == 'parent') {
        await AuthProvider.auth(context).getGrades();
      }
      setState(() {});

      print('result:$result');

      //Categories
      cat = 'Select Category';
      // catId = AuthProvider.auth(context).categories[0].id;

      print('catId: $catId');
      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  //init state
  @override
  void initState() {
    futureCategory = futureTask();

    super.initState();
  }

  File _croppedImageFile;
  String imageUrl;
  String profilePix;
  String birthDate;

  //Get image function
  getImage(ImageSource choice) async {
    File result = await onImagePickerPressed(choice, context);
    setState(() {
      _croppedImageFile = result;
    });
  }

  dateFilter(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(DateTime.now().year - 12),
        maxTime: DateTime(DateTime.now().year - 5), onChanged: (date) {
      setState(() {
        birthDate = DateFormat('yyyy-MM-dd').format(date).toString();
      });
    }, onConfirm: (date) {
      print('confirm $date');
      setState(() {
        birthDate = DateFormat('yyyy-MM-dd').format(date).toString();
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Widget imageDisplay(File croppedImage, String mockImage) {
    print('imgurl:$imageUrl');
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;

    print('cropped:$croppedImage');
    print('profilePix:$profilePix');
    if (croppedImage != null) {
      return Container(
        height: 70.0,
        width: 70.0,
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new FileImage(File(croppedImage.path)),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle),
      );
    } else if (profilePix != null) {
      return Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(profilePix),
            )),
      );
    } else {
      return profilePicture(context, 'photo', size: 80);
    }
  }

  //Modal bottom sheet
  void bottomSheet(BuildContext context, String type) {
    List<Grades> grades = AuthProvider.auth(context).grades;
    List<Categories> category = AuthProvider.auth(context).categories;

    print('catttt: ${category}');
    print('type: ${type}');
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
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            color: Colors.white),
                        height: 500.0,
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: ListView.separated(
                                separatorBuilder: (context, _) => Divider(
                                      height: 0.4,
                                    ),
                                itemCount: type == 'age'
                                    ? childYears.length
                                    : (type == 'category'
                                        ? category.length
                                        : grades.length),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    child: Row(
                                      children: [
                                        Radio(
                                            value: type == 'age'
                                                ? childYears[index]['years']
                                                : (type == 'category'
                                                    ? category[index].name
                                                    : toBeginningOfSentenceCase(
                                                        grades[index].name)),
                                            groupValue: type == 'age'
                                                ? val
                                                : (type == 'category'
                                                    ? cat
                                                    : classVal),
                                            activeColor: accentColor,
                                            onChanged: (var value) {
                                              setModalState(() {
                                                setState(() {});
                                                if (type == 'age') {
                                                  val = value;
                                                  age =
                                                      childYears[index]['name'];
                                                } else if (type == 'category') {
                                                  cat = category[index].name;
                                                  catId = category[index].id;
                                                  print('cat: $cat');
                                                } else {
                                                  classVal = value;
                                                  childClassName =
                                                      grades[index].id;
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
                                              : (type == 'category'
                                                  ? category[index].name
                                                  : toBeginningOfSentenceCase(
                                                      grades[index].name)),
                                          style: smallAccentColor.copyWith(
                                              fontSize: 16),
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
    List<dynamic> children = ChildProvider.childProvider(context).children;

    return BackgroundImage(
      child: FutureHelper(
        task: futureCategory,
        loader: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        noData: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No data available')],
        ),
        builder: (context, _) => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: defaultVHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TopBar(
                      center: true,
                      text: widget.user != 'parent'
                          ? (widget.user == "child"
                              ? "Add new child"
                              : "Fill in your child's details")
                          : "Fill in your personal details",
                      onTap: () => Navigator.pop(context)),
                  kSmallHeight,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.user == "child"
                          ? Container(
                              height: 100,
                              child: ListView.separated(
                                  separatorBuilder: (context, int) =>
                                      kSmallWidth,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: children.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await getImage(
                                                  ImageSource.gallery);
                                            },
                                            child: Stack(
                                              overflow: Overflow.visible,
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                imageDisplay(
                                                    _croppedImageFile,
                                                    children[index]
                                                        ['image_url']),
                                                Positioned(
                                                  top: 30,
                                                  right: -30,
                                                  // left: 50,
                                                  child: Container(
                                                    child: SvgPicture.asset(
                                                        'assets/images/svg/cam.svg'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : LinearPercentIndicator(
                              lineHeight: 5.0,
                              percent: 0.8,
                              progressColor: primaryColor,
                            ),
                    ],
                  ),
                  kSmallHeight,
                  // widget.user != 'parent'
                  //     ? Text(
                  //         widget.user == 'child' ? "" : '02/02',
                  //         style: textLightBlack.copyWith(
                  //             fontSize: 18, fontWeight: FontWeight.w400),
                  //       )
                  //     : Container(),
                  // kSmallHeight,
                  // widget.user != 'parent'
                  //     ? (Text(
                  //         "Fill in your ${widget.user == 'child' ? "child's" : "personal"} details",
                  //         textAlign: TextAlign.center,
                  //         style: textStyleSmall.copyWith(
                  //             fontSize: 21.0,
                  //             fontWeight: FontWeight.w700,
                  //             color: primaryColor),
                  //       ))
                  //     : Text(
                  //         "Fill in your personal details",
                  //         textAlign: TextAlign.center,
                  //         style: textStyleSmall.copyWith(
                  //             fontSize: 20.0,
                  //             fontWeight: FontWeight.w700,
                  //             color: primaryColor),
                  //       ),
                  kSmallHeight,
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
                                  hintText: 'Password',
                                  obscureText: _oldVisible,
                                  area: 1,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _oldVisible = !_oldVisible;
                                        });
                                      },
                                      child: Container(
                                        width: 20.0,
                                        padding: EdgeInsets.only(right: 15),
                                        alignment: Alignment.centerRight,
                                        child: _oldVisible
                                            ? SvgPicture.asset(
                                                'assets/images/svg/eye-off.svg')
                                            : SvgPicture.asset(
                                                'assets/images/svg/eye.svg'),
                                      )),
                                ),
                                kSmallHeight,
                              ],
                            ),
                          // DropDown(
                          //   onTap: () => bottomSheet(context, 'age'),
                          //   text: widget.user != 'parent'
                          //       ? (age ?? "5 Years")
                          //       : (age ?? "5 Years"),
                          // ),

                          Column(
                            children: [
                              MyTextForm(
                                controllerName: _controllerAge,
                                // validations:  validations.validateDate,
                                type: TextInputType.number,
                                hintText: birthDate ?? 'Date of Birth',
                                readonly: true,
                                onTap: () => dateFilter(context),
                              ),
                              kSmallHeight,
                            ],
                          ),
                          // kSmallHeight,
                          DropDown(
                            onTap: () => bottomSheet(context, 'class'),
                            text: widget.user != 'parent'
                                ? (classVal ?? "Child's Category")
                                : (classVal ?? "Category"),
                          ),
                          kSmallHeight,
                          DropDown(
                            onTap: () => bottomSheet(context, 'category'),
                            text: widget.user != 'parent'
                                ? (cat ?? "Child's Class")
                                : (cat ?? "Class"),
                          ),
                          kLargeHeight,
                          GreenButton(
                              submit: () => addUser(),
                              color: primaryColor,
                              name: widget.user == 'child'
                                  ? 'Add Child'
                                  : 'Sign Up',
                              buttonColor: secondaryColor,
                              loader: auth.isLoading),
                          kSmallHeight,
                          widget.user == 'child' ? Container() : HaveAccount()

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
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: greyColor,
              width: 0.3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: accentColor, width: 1.0),
          ),
          focusColor: primaryColor,
          suffixIcon: Icon(Icons.keyboard_arrow_down),
          fillColor: lightPrimaryColor,
          filled: true,
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
