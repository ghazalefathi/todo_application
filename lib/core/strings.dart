import 'package:get/get.dart';

import 'enum.dart';

class MyStrings {
  static String get storageName => 'knik_storage';
  static String get lang => 'lang';
  static String get isDark => 'isDark';
  static String get baseUrl => 'https://new-api.knik.uk/';
  static String get token => 'token';
  static String get needToAuth => 'needToAuth';
  static String get uuid => 'uuid';
  static String get lastVersionUpdateList => 'lastVersionUpdateList';
  // static String get mediaUrl => 'https://api.lottery.moderndata.ir';

  static String getFonts({required FontType fontType}) => switch (fontType) {
        FontType.bold => 'vazirmatn_extra_bold',
        FontType.medium => 'vazirmatn_medium',
        FontType.regular => 'vazirmatn_regular',
        FontType.semiBold => 'vazirmatn_semi_bold',
        FontType.bungeeRegular => 'bungee_regular',
      };

  static String getBottomNavTitles({required BottomNavEnum bottomnav}) => switch (bottomnav) {
        BottomNavEnum.profile => 'profile'.tr,
        BottomNavEnum.shop => 'shop'.tr,
        BottomNavEnum.home => 'home'.tr,
        BottomNavEnum.earn => 'earn'.tr,
        BottomNavEnum.friends => 'friends'.tr
        // _ => '',
      };
}
