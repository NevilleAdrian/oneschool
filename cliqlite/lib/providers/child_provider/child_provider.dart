import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChildProvider extends ChangeNotifier {
  List<dynamic> _children = [
    {
      "name": " Dara",
      "image_url":
          "https://images.pexels.com/photos/8065871/pexels-photo-8065871.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
    }
  ];
  List<dynamic> get children => _children;

  setChild(Map<String, dynamic> child) {
    _children.addAll([child]);
    print('children: $_children');
    notifyListeners();
  }

  static BuildContext _context;

  static ChildProvider childProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<ChildProvider>(context, listen: listen);
  }
}
