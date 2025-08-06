
import 'enum.dart';

class MyStrings {
  static String get baseUrl => 'https://new-api.knik.uk/';
  static String get token => 'token';


  static String getFonts({required FontType fontType}) => switch (fontType) {
        FontType.bold => 'vazirmatn_extra_bold',
        FontType.medium => 'vazirmatn_medium',
        FontType.regular => 'vazirmatn_regular',
        FontType.semiBold => 'vazirmatn_semi_bold',
        FontType.bungeeRegular => 'bungee_regular',
      };

}
