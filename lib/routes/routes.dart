import 'package:get/get.dart';
import 'package:magical_music/design/pages/backUpPage.dart';
import 'package:magical_music/design/pages/homePage.dart';
import 'package:magical_music/design/pages/settingPage.dart';

class Routes {
  static String home = "/Home";
  static String setting = "/Setting";
  static String bachup = "/backup";
  static List<GetPage> get pages => [
        GetPage(
          name: home,
          page: () => const HomePage(),
        ),
        GetPage(
          name: setting,
          page: () => SettingPage(),
        ),
        GetPage(
          name: bachup,
          page: () => BackUpPage(),
        ),
      ];
}
