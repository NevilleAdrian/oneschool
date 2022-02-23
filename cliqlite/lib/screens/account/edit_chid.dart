import 'dart:io';

import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/capture_image.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditChildDetails extends StatefulWidget {
  @override
  _EditChildDetailsState createState() => _EditChildDetailsState();
}

//years enum
enum Years { fifth, sixth, seventh, eighth, ninth, tenth }

//class enum
enum Class { first, second, third, fourth, fifth, sixth }

class _EditChildDetailsState extends State<EditChildDetails> {
  //Global Key
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //Initialize firebase storage
  final _storage = FirebaseStorage.instance;

  //Validation
  Validations validations = new Validations();

  //Controllers
  TextEditingController _controllerName = new TextEditingController();

  //validation boolean
  bool autoValidate = false;

  //Instantiate enum
  String val = '5';

  //Instantiate enum
  String classVal = '6';

  //Age
  String age;

  //Class
  String childClassName;
  String childClassID;

  //File image
  File _croppedImageFile;

  String imageUrl;

  String profilePix;

  addUser({String imageUrl}) async {
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> children = AuthProvider.auth(context).users;
    AuthProvider auth = AuthProvider.auth(context);
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
    List<Users> users = AuthProvider.auth(context).users;

    try {
      setState(() {
        AuthProvider.auth(context).setIsLoading(true);
      });

      print('imgUrl:$imageUrl');

      var result = await AuthProvider.auth(context).updateUser(
          _controllerName.text == ''
              ? (users != null
                  ? users[childIndex?.index ?? 0].name
                  : mainChildUser.name)
              : _controllerName.text,
          int.parse(age?.replaceAll(' years', '') ?? '5'),
          imageUrl ??
              'https://images.pexels.com/photos/8264629/pexels-photo-8264629.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
          childClassID ?? AuthProvider.auth(context).grades[0].id,
          children != null
              ? children[childIndex?.index ?? 0]?.id
              : mainChildUser?.id);
      if (auth.user.role != 'user') {
        await AuthProvider.auth(context).getChildren();
      } else {
        AuthProvider.auth(context).getMainChild();
      }

      if (result != null) {
        setState(() {
          AuthProvider.auth(context).setIsLoading(false);
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppLayout(
                      index: 3,
                    )));
        showFlush(context, 'Successfully Updated User', primaryColor);
      }
    } catch (ex) {
      print('ex:$ex');
      setState(() {
        AuthProvider.auth(context).setIsLoading(false);
      });
    }
  }

  //Route to next page
  nextPage() {
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
              addUser(imageUrl: imageUrl);
            }
          } catch (ex) {
            print('ex: $ex');
          }
        });
      } else {
        List<Users> children = AuthProvider.auth(context).users;
        ChildIndex childIndex = SubjectProvider.subject(context).index;
        MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
        addUser(
            imageUrl: children != null
                ? children[childIndex?.index ?? 0].photo
                : mainChildUser.photo);
      }
    }
  }

  //Add child
  // addChild({Map<String, dynamic> child}) {
  //   ChildProvider.childProvider(context).setChild(child);
  //   if (ChildProvider.childProvider(context).children.isNotEmpty) {
  //     Navigator.pushNamed(context, AppLayout.id);
  //   }
  // }

  //Child year data
  var childYears = [
    {"name": '5', "years": Years.fifth},
    {"name": '6', "years": Years.sixth},
    {"name": '7', "years": Years.seventh},
    {"name": '8', "years": Years.eighth},
    {"name": '9', "years": Years.ninth},
    {"name": '10', "years": Years.tenth},
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
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              color: Colors.white),
                          height: 500.0,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              child: ListView.builder(
                                  itemCount: type == 'age'
                                      ? childYears.length
                                      : grades.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Radio(
                                              value: type == 'age'
                                                  ? childYears[index]['name']
                                                  : grades[index].name,
                                              groupValue: type == 'age'
                                                  ? val
                                                  : classVal,
                                              activeColor: accentColor,
                                              onChanged: (dynamic value) {
                                                setModalState(() {
                                                  setState(() {});
                                                  if (type == 'age') {
                                                    val = value;
                                                    age = childYears[index]
                                                        ['name'];
                                                    print('age:$age');
                                                    print('age:$value');
                                                  } else {
                                                    classVal = value;
                                                    childClassName =
                                                        grades[index].name;
                                                    childClassID =
                                                        grades[index].id;
                                                    print(
                                                        'class:$childClassName');
                                                    print('class:$value');
                                                  }
                                                });
                                              }),
                                          // kSmallWidth,
                                          Text(
                                            type == 'age'
                                                ? '${childYears[index]['name']} years'
                                                : toBeginningOfSentenceCase(
                                                    grades[index].name),
                                            style: smallAccentColor.copyWith(
                                                fontSize: 16),
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

  //Get image function
  getImage(ImageSource choice) async {
    File result = await onImagePickerPressed(choice, context);
    setState(() {
      _croppedImageFile = result;
    });
  }

  Widget imageDisplay(File croppedImage, String mockImage) {
    print('imgurl:$imageUrl');
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;

    if (croppedImage != null) {
      return Container(
        height: 70.0,
        width: 70.0,
        decoration: new BoxDecoration(
            //color: Theme.of(context).backgroundColor,
            image: new DecorationImage(
              image: new FileImage(File(croppedImage.path)),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle
            // borderRadius: new BorderRadius.all(
            //   const Radius.circular(10.0),
            // )
            ),
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
      return profilePicture(context, size: 80);
    }
  }

  @override
  void initState() {
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
    List<Grades> grades = AuthProvider.auth(context).grades;

    age = toBeginningOfSentenceCase(users != null
        ? users[childIndex?.index ?? 0].age.toString()
        : mainChildUser.age.toString());
    val = toBeginningOfSentenceCase(users != null
        ? users[childIndex?.index ?? 0].age.toString()
        : mainChildUser.age.toString());

    final grade = grades
        .where((element) =>
            element.id ==
            (users != null
                ? users[childIndex?.index ?? 0].grade
                : mainChildUser.grade))
        .toList();
    childClassName = grade[0].name;
    classVal = grade[0].name;

    // print('length:${AuthProvider.auth(context).grades.length}');
    setState(() {
      profilePix = users != null
          ? users[childIndex?.index ?? 0].photo
          : mainChildUser.photo;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> children = ChildProvider.childProvider(context).children;
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    AuthProvider auth = AuthProvider.auth(context);
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

    return BackgroundImage(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: defaultVHPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.chevron_left,
                          color: blackColor,
                        )),
                    Text(
                      "Edit child's details",
                      textAlign: TextAlign.center,
                      style: textStyleSmall.copyWith(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    Container()
                  ],
                ),
                kLargeHeight,
                Container(
                  height: 100,
                  child: ListView.separated(
                      separatorBuilder: (context, int) => kSmallWidth,
                      scrollDirection: Axis.horizontal,
                      itemCount: children.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await getImage(ImageSource.gallery);
                                },
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    imageDisplay(_croppedImageFile,
                                        children[index]['image_url']),
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
                ),
                kSmallHeight,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                            controllerName: _controllerName,
                            hintText: toBeginningOfSentenceCase(users != null
                                    ? users[childIndex?.index ?? 0].name
                                    : mainChildUser.name) ??
                                "Child's Name"),
                        kSmallHeight,
                        DropDown(
                            onTap: () => bottomSheet(context, 'age'),
                            text: '$age years' ??
                                ('${toBeginningOfSentenceCase(users != null ? users[childIndex?.index ?? 0].age.toString() : mainChildUser.age.toString())} Years' ??
                                    "Child's Age")),
                        kSmallHeight,
                        DropDown(
                            onTap: () => bottomSheet(context, 'class'),
                            text: toBeginningOfSentenceCase(childClassName) ??
                                "Grade 1"),
                        kLargeHeight,
                        GreenButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name: 'Save Changes',
                          loader: AuthProvider.auth(context).isLoading,
                          buttonColor: secondaryColor,
                        ),
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
