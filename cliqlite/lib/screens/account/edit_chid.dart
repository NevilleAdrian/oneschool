import 'dart:io';

import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/capture_image.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
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
      Navigator.pushNamed(context, AppLayout.id);
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

  //File image
  File _croppedImageFile;
  String _networkImage, profilePix;

  //Get image function
  getImage(ImageSource choice) async {
    var result = await onImagePickerPressed(choice, context);
    setState(() {
      _croppedImageFile = result;
    });
  }

  Widget imageDisplay(File croppedImage, String imageUrl) {
    if (croppedImage != null) {
      return new Container(
        height: 150.0,
        width: 150.0,
        decoration: new BoxDecoration(
            //color: Theme.of(context).backgroundColor,
            image: new DecorationImage(
                image: new FileImage(File(croppedImage.path)),
                fit: BoxFit.cover),
            borderRadius: new BorderRadius.all(
              const Radius.circular(75.0),
            )),
      );
    } else if (imageUrl != null) {
      return Expanded(
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return new Container(
        height: 150.0,
        width: 150.0,
        decoration: new BoxDecoration(
            //color: Theme.of(context).primaryColor,
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2.0),
            borderRadius: new BorderRadius.all(
              const Radius.circular(75.0),
            )),
        child: CircleAvatar(
          radius: 75.0,
          // backgroundColor: Theme.of(context).backgroundColor,
          child: new Icon(
            Icons.person,
            size: 70.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> children = ChildProvider.childProvider(context).children;

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
                  // width: MediaQuery.of(context).size.width,
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
                              // Expanded(
                              //   child: Image.asset(
                              //     children[index]['image_url'],
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                toBeginningOfSentenceCase(
                                    children[index]['name']),
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
                    Navigator.pop(context);
                    await getImage(ImageSource.camera);
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
                            hintText: "Child's Name"),
                        kSmallHeight,
                        DropDown(
                            onTap: () => bottomSheet(context, 'age'),
                            text: age ?? "Child's Age"),
                        kSmallHeight,
                        DropDown(
                            onTap: () => bottomSheet(context, 'class'),
                            text: childClassName ?? "Child's Class"),
                        kLargeHeight,
                        LargeButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name: 'Save Changes',
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
