class AppImage {
  static AppImage? _instance;

  factory AppImage() {
    _instance ??= AppImage._internal();
    return _instance!;
  }

  AppImage._internal();

  // Base paths
  final String baseImages = 'assets/images/';
  final String baseIcons = 'assets/icons/';
  final String baseAnimations = 'assets/animations/';

  // ===== images =====
  late final String wordMark = '${baseImages}wordmark.svg';
  late final String surgeTop = '${baseImages}surge_top.svg';
  late final String surgeRight = '${baseImages}surge_right.svg';
  late final String surgeBottom = '${baseImages}surge_bottom.svg';
  late final String surgeLeft = '${baseImages}surge_left.svg';
  late final String courseBanner = '${baseImages}course_banner.png';

  // ===== icons =====

  late final String home = '${baseIcons}home.svg';
  late final String exam = '${baseIcons}exam.svg';
  late final String book = '${baseIcons}book.svg';
  late final String more = '${baseIcons}more.svg';
  late final String users = '${baseIcons}users.svg';
  late final String blueBook = '${baseIcons}book_blue.svg';

  // ===== animations =====
  late final String splash = '${baseAnimations}splash.json';
  late final String electricBackground =
      '${baseAnimations}Ambient___Electric_background.json';
}
