import 'package:get/get.dart';
import 'package:todo_application/screens/auth/forget_password_screen.dart';
import 'package:todo_application/screens/auth/login_screen.dart';
import 'package:todo_application/screens/auth/onbording_screen.dart';
import 'package:todo_application/screens/auth/register_screen.dart';
import 'package:todo_application/screens/home_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static String get splash => '/splash';
  static String get login => '/login';
  static String get forgetPassword => '/forget-password';
  static String get register => '/register';
  static String get onbording => '/onbording';
  static String get home => '/home';


  //! Default Screen
  static String defaultScreen() => home;
  //! End Default Screen

  static List<GetPage> get page => [
        GetPage(name: splash, page: () => const SplashScreen()),
        GetPage(name: login, page: () => const LoginScreen()),
        GetPage(name: register, page: () => const RegisterScreen()),
        GetPage(name: forgetPassword, page: () => const ForgetPasswordScreen()),
        GetPage(name: onbording, page: () => const OnbordingScreen()),
        GetPage(name: home, page: () => const HomeScreen()),
       
      ];
}
