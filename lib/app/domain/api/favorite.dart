import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/dto/clinic/response/ClinicUserResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';

class FavoriteAPI {

  Future<List<DoctorResponse>> doctorList() async {
    Response response = await BaseAPI.dio.get("/favorite/doctor");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<DoctorResponse>.from(parsedListJson.map<DoctorResponse>((dynamic i) => DoctorResponse.fromJson(i)));
  }

  Future<List<ClinicUserResponse>> clinicsList() async {
    Response response = await BaseAPI.dio.get("/favorite/clinic");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<ClinicUserResponse>.from(parsedListJson.map<ClinicUserResponse>((dynamic i) => ClinicUserResponse.fromJson(i)));
  }

  Future<dynamic> addDoctor(int id) async {
    Response response = await BaseAPI.dio.get("/favorite/doctor/add/$id");
  }

  Future<dynamic> removeDoctor(int id) async {
    Response response = await BaseAPI.dio.delete("/favorite/doctor/remove/$id");
  }

  Future<dynamic> addClinic(int id) async {
    Response response = await BaseAPI.dio.get("/favorite/clinic/add/$id");
  }

  Future<dynamic> removeClinic(int id) async {
    Response response = await BaseAPI.dio.delete("/favorite/clinic/remove/$id");
  }
}