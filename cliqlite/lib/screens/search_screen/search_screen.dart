import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/subject_screen/subject_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/x_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _nameController = TextEditingController();
  List<dynamic> filteredSearch = [];

  onSearch() {
    print('text is ${_nameController.text}');
    setState(() {
      filteredSearch = onFilter(_nameController.text);
    });
  }

  List<dynamic> onFilter(String term) {
    return data
        .where((element) =>
            element['name'].toLowerCase().contains(term.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    filteredSearch = data;
    _nameController.addListener(onSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return BackgroundImage(
        child: SafeArea(
      child: Padding(
        padding: defaultVHPadding,
        child: Column(
          children: [
            XButton(
              onTap: () => Navigator.pushNamed(context, AppLayout.id),
              color: theme.status ? whiteColor : greyColor,
            ),
            SizedBox(height: 15),
            SearchBox(
              type: 'search',
              size: 5.0,
              nameController: _nameController,
            ),
            kLargeHeight,
            Expanded(
              child: Padding(
                padding: defaultPadding.copyWith(left: 65),
                child: ListView.separated(
                    separatorBuilder: (context, int) => SizedBox(
                          height: 35,
                        ),
                    scrollDirection: Axis.vertical,
                    itemCount: filteredSearch.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectScreen(
                                      text: filteredSearch[index]['name'],
                                    ))),
                        child: Text(
                          toBeginningOfSentenceCase(
                              filteredSearch[index]['name']),
                          style: textExtraLightBlack.copyWith(
                              fontWeight: FontWeight.w500,
                              color: theme.status ? whiteColor : blackColor),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
