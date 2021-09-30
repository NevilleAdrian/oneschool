import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChildProvider extends ChangeNotifier {
  List<dynamic> _children = [
    {"name": " Dara", "image_url": "assets/images/picture.png"}
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
