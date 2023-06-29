import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const defaultpadding = 12.0;

class ApiConstants {
  static String get baseUrl {
    if (isWebPlatform()) {
      return 'http://127.0.0.1:8000/api/v1';
    } else {
      return getPlatformBaseUrl();
    }
  }

  static String getPlatformBaseUrl() {
    if (!isWebPlatform() && Platform.isIOS) {
      return 'http://${dotenv.env['LOCAL_HOST']}:8000/api/v1';
    } else if (!isWebPlatform() && Platform.isAndroid) {
      return 'http://${dotenv.env['IP_ADDRESS']}:8000/api/v1';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static String get socketUrl {
    if (isWebPlatform()) {
      return 'http://127.0.0.1:8000';
    } else {
      return getPlatformSocketUrl();
    }

  }

  static String getPlatformSocketUrl() {
    if (!isWebPlatform() && Platform.isIOS) {
      return 'http://${dotenv.env['LOCAL_HOST']}:8000';
    } else if (!isWebPlatform() && Platform.isAndroid) {
      return 'http://${dotenv.env['IP_ADDRESS']}:8000';
    } else {
      throw Exception('Unsupported platform');
    }
  }

  static bool isWebPlatform() {
    return identical(0, 0.0);
  }

  static const String productsEndpoint = '/products';
}
