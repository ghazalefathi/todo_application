import 'package:get/get.dart';
import '../screens/splash_screen.dart';

class Routes {
  static String get splash => '/splash';


  //! Default Screen
  static String defaultScreen() => splash;
  //! End Default Screen

  static List<GetPage> get page => [
        GetPage(name: splash, page: () => const SplashScreen()),
       
      ];
}
