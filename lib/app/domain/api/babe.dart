import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/dto/babe/BabeResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';

class BabeAPI {
  Future<BabeResponse> getBabe() async {
    try {
      Response response = await BaseAPI.dio.get("/babe");
      log(response.data);
      return BabeResponse.fromJson(jsonDecode(response.data));

    } on DioException catch (e) {
      throw e.response.toString();
    }
  }

  Future<DoctorResponse> getRegister() async {
    Response response = await BaseAPI.dio.get("/register/user");
    if (response.statusCode == 200) {
      return DoctorResponse.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Babe not found!');
    }
  }

  Future createBabe({
    required String age,
    required String weight,
    required String size,
    required num id,
  }) async {
    try {
      
      final Response response = await BaseAPI.dio.put(
        "/babe",
        data: jsonEncode({
          "age" : age,
          "size" : size,
          "userId" : id,
          "weight" : weight,
        })
      );
      log(response.toString());

    } on DioException catch (e) {
      throw e.response.toString();
    }
  }

}