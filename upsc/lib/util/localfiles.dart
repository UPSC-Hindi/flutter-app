import 'package:path_provider/path_provider.dart';

class Localfilesfind {
  static List localfiles = [];
  static initState() async {
    localfiles.clear();
    final baseStorage = await getExternalStorageDirectory();
    print("----file*----");
    var files = baseStorage!.listSync();
    files.forEach((element) {
      localfiles.add(element.toString().split("/").last.split(".").first);
      //print(element.toString().split("/").last.split(".").first);
    });
    print(localfiles);
  }
}
