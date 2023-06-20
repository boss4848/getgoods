import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const defaultpadding = 12.0;

class ApiConstants {
  static String get baseUrl {
    if (Platform.isIOS) {
      return 'http://${dotenv.env['LOCAL_HOST']}:8000/api/v1';
    } else if (Platform.isAndroid) {
      return 'http://${dotenv.env['IP_ADDRESS']}:8000/api/v1';
    } else {
      return 'http://${dotenv.env['LOCAL_HOST']}:8000/api/v1';
      // throw Exception('Unsupported platform');
    }
  }

  static const String productsEndpoint = '/products';
}
