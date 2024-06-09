import 'package:dio/dio.dart';
import 'package:medimom/app/domain/provider/user_provider.dart';

class BaseAPI {

  static var userProvider = UserProvider();

  static var dio = Dio(
    BaseOptions(
      baseUrl: "http://195.49.210.209:9091/api",
      responseType: ResponseType.plain,
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
      headers: {
        "Content-Type": "application/json",
      }
    )
  );

  static Future<dynamic> reloadHeader() async {
    await userProvider.getAuthToken().then((value) => {
      dio.options.headers = {
        "Content-Type": "application/json",
        if (value != null) "Authorization": value.toString()
      }
    });
  }

  static Future<dynamic> reloadTokenHeader(String token) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token
    };
  }

}