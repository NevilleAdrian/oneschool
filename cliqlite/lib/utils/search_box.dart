import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBox extends StatelessWidget {
  const SearchBox(
      {this.type,
      this.widget,
      this.size,
      this.nameController,
      this.placeholder,
      this.padding,
      this.width});

  final String type;
  final Widget widget;
  final double size;
  final TextEditingController nameController;
  final String placeholder;
  final EdgeInsets padding;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      color: Colors.transparent,
      padding: padding ?? defaultPadding,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        shadowColor: Colors.black,
        child: Container(
          padding:
              defaultVHPadding.copyWith(top: size ?? 15, bottom: size ?? 15),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/search.svg',
              ),
              SizedBox(
                width: 10,
              ),
              type == 'route'
                  ? Text(
                      placeholder ?? 'Search for Subject',
                      style: headingSmallGreyColor.copyWith(fontSize: 15),
                    )
                  : Expanded(
                      child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        hintText: 'Search ',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
