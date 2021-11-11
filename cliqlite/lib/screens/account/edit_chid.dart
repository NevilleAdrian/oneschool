import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
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
import 'package:flutter/material.dart';
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
  Years val = Years.fifth;

  //Instantiate enum
  Class classVal = Class.first;

  //Age
  String age;

  //Class
  String childClassName;

  //File image
  File _croppedImageFile;

  String imageUrl;

  String profilePix;

  addUser({String imageUrl}) async {
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> children = AuthProvider.auth(context).users;
    AuthProvider auth = AuthProvider.auth(context);
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

    try {
      setState(() {
        AuthProvider.auth(context).setIsLoading(true);
      });
      var result = await AuthProvider.auth(context).updateUser(
          _controllerName.text,
          int.parse(age?.replaceAll(' years', '') ?? '5'),
          imageUrl,
          childClassName ?? '6155798b81cc3265b9efaa9c',
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
                      index: 4,
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
        Reference reference =
            _storage.ref().child("updateProfile" + DateTime.now().toString());
        UploadTask uploadTask = reference.putFile(_croppedImageFile);

        uploadTask.whenComplete(() async {
          try {
            imageUrl = await reference.getDownloadURL();
            addUser(imageUrl: imageUrl);
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
                : mainChildUser.id);
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

  //Get image function
  getImage(ImageSource choice) async {
    File result = await onImagePickerPressed(choice, context);
    setState(() {
      _croppedImageFile = result;
    });
    Reference reference =
        _storage.ref().child("updateProfile" + DateTime.now().toString());
    UploadTask uploadTask = reference.putFile(result);
    uploadTask.whenComplete(() async {
      try {
        imageUrl = await reference.getDownloadURL();
        setState(() {});
        print('url: $imageUrl');
      } catch (ex) {
        print('ex: $ex');
      }
    });
  }

  Widget imageDisplay(File croppedImage, String mockImage) {
    print('imgurl:$imageUrl');
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;

    if (croppedImage != null) {
      return Container(
        height: 60.0,
        width: 60.0,
        decoration: new BoxDecoration(
            //color: Theme.of(context).backgroundColor,
            image: new DecorationImage(
                image: new FileImage(File(croppedImage.path)),
                fit: BoxFit.cover),
            borderRadius: new BorderRadius.all(
              const Radius.circular(10.0),
            )),
      );
    } else if (profilePix != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          //color: Theme.of(context).backgroundColor,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: profilePix,
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
            )),
      );
    } else {
      return Expanded(
        child: Image.asset(
          mockImage,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  void initState() {
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

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
                      "Edit Child's details",
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
                  height: 90,
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
                              imageDisplay(_croppedImageFile,
                                  children[index]['image_url']),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                toBeginningOfSentenceCase(users != null
                                    ? users[childIndex?.index ?? 0].name
                                    : mainChildUser.name),
                                style: textLightBlack.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                kSmallHeight,
                InkWell(
                  onTap: () async {
                    await getImage(ImageSource.gallery);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Change Picture',
                        style: textExtraLightBlack.copyWith(
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
                kLargeHeight,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                            controllerName: _controllerName,
                            validations: validations.validateName,
                            hintText: toBeginningOfSentenceCase(users != null
                                    ? users[childIndex?.index ?? 0].name
                                    : mainChildUser.name) ??
                                "Child's Name"),
                        kSmallHeight,
                        DropDown(
                            onTap: () => bottomSheet(context, 'age'),
                            text: age ??
                                ('${toBeginningOfSentenceCase(users != null ? users[childIndex?.index ?? 0].age.toString() : mainChildUser.age.toString())} Years' ??
                                    "Child's Age")),
                        kSmallHeight,
                        DropDown(
                            onTap: () => bottomSheet(context, 'class'),
                            text: childClassName ?? "Child's Class"),
                        kLargeHeight,
                        LargeButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name: 'Save Changes',
                          loader: auth.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Save Changes',
                                  style: headingWhite.copyWith(
                                    color: secondaryColor,
                                  ),
                                ),
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
