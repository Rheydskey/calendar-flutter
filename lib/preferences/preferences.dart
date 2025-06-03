import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences prefs;
  Preferences(this.prefs);

  static Future<Preferences> getInstance() async {
    var a = await SharedPreferences.getInstance();

    return Preferences(a);
  }

  String? url() => prefs.getString("url");
  String? auth() => prefs.getString("auth");
}
