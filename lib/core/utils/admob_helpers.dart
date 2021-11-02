import 'dart:io';

class AdmobHelpers {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4602657974905060/9625387278';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4602657974905060/3686433372';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4602657974905060/5180899323';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4602657974905060/4807943356';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }
}