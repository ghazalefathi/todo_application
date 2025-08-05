import 'enum.dart';

class Assets {
  static String img = 'assets/images';
  static String svg = 'assets/svgs';
  static String lottie = 'assets/lotties';
  static String sound = 'sounds';



  //! gif

  //! svg


  //! lottie



  //! sound


  static String bottomNavIcons(
    BottomNavEnum bottomNav,
  ) =>
      switch (bottomNav) {
        BottomNavEnum.profile => '$svg/ic_profile.svg',
        BottomNavEnum.shop => '$svg/ic_store.svg',
        BottomNavEnum.home => '',
        BottomNavEnum.earn => '$svg/ic_earn.svg',
        BottomNavEnum.friends => '$svg/ic_friends.svg'
      };
}
