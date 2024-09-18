// ignore_for_file: unused_field, non_constant_identifier_names

class AppAssets {
  static AppImages images = AppImages();
  static final AppSvgs svgs = AppSvgs();
  static final AppLotties lotties = AppLotties();
}

class AppImages {
  static const String _path = 'assets/images';
}

class AppSvgs {
  static const String _path = 'assets/svgs';
  final String not_found = '$_path/not_found.svg';

  final String passbook_icon = '$_path/passbook_icon.svg';
  final String map_icon = '$_path/map_icon.svg';
  final String no_records = '$_path/no_records.svg';
}

class AppLotties {
  static const String _path = 'assets/lottie';

  final String splash_animation = '$_path/splash_animation.json';
}
