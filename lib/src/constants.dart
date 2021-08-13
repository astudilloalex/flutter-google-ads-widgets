import 'dart:io';

class TestAdId {
  const TestAdId();

  static String get banner {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    throw 'Unsupported platform';
  }
}
