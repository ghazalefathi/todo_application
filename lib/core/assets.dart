import 'enum.dart';

class Assets {
  static String img = 'assets/images';
  static String svg = 'assets/svgs';
  static String lottie = 'assets/lotties';
  static String sound = 'sounds';


  //! png

  static  String get bgHome  => '$img/bg_home.png';
  static  String get imgHome  => '$img/img_home.png';
  //! gif

  //! svg


  //! lottie



  //! sound


  static String bottomNavIcons(
    BottomNavEnum bottomNav,
  ) =>
      switch (bottomNav) {
       
        BottomNavEnum.home => '$svg/ic_add.svg',
        BottomNavEnum.menu => '$svg/ic_menu.svg',
        BottomNavEnum.location => '$svg/ic_location.svg',
       
      };
}
