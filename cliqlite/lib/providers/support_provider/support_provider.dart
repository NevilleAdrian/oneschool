import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/support_model/support_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SupportProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;

  List<SupportModel> _supportList;

  List<SupportModel> get supportList => _supportList;

  setSupport(List<SupportModel> supportList) => _supportList = supportList;

  Future<List<SupportModel>> getSupport() async {
    //Get Support
    var data =
        await _helper.getSupport(_context, AuthProvider.auth(_context).token);

    print('supportt:$data');

    data = (data as List).map((e) => SupportModel.fromJson(e)).toList();

    //Save Topics in local storage
    setSupport(data);

    return data;
  }

  static SupportProvider support(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<SupportProvider>(context, listen: listen);
  }
}
