import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';

class ClinicAPI {

  Future<List<ClinicUserResponse>> findAll() async {
    Response response = await BaseAPI.dio.get("/clinic/user");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<ClinicUserResponse>.from(parsedListJson.map<ClinicUserResponse>((dynamic i) => ClinicUserResponse.fromJson(i)));
  }

}