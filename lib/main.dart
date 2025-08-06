import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/app_colors.dart';
import 'core/bindings.dart';
import 'core/utils.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: AppColors.black));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: Utils.defaultTextDirection,
      supportedLocales: [Utils.getEnLocale(), Utils.getPrLocale()],
      onReady: () {
        Get.updateLocale(Utils.getEnLocale());
      },
      theme: ThemeData(scaffoldBackgroundColor: AppColors.transparent),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      getPages: Routes.page,
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 400),
      initialRoute: Routes.defaultScreen(),
    );
  }
}
