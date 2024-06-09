import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/dto/user/request/ChangeProfileRequest.dart';
import 'package:medimom/app/domain/dto/user/request/LoginRequest.dart';
import 'package:medimom/app/domain/dto/user/request/RegisterRequest.dart';
import 'package:medimom/app/domain/dto/user/response/ProfileResponse.dart';
import 'package:medimom/app/domain/dto/user/response/TokenRespons.dart';

class UserAPI {
  Future<ProfileResponse> checkProfile() async {
    try {
      Response response = await BaseAPI.dio.get("/user/profile");
      return ProfileResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<ProfileResponse> changeProfile(ChangeProfileRequest changeProfileRequest) async {
    Response response = await BaseAPI.dio.post(
      "/user/profile/change",
      data: changeProfileRequest
    );
    if (response.statusCode == 200) {
      return ProfileResponse.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Profile not found!');
    }
  }

  Future<TokenResponse> login(LoginRequest loginRequest) async {
    try {
      Response response = await BaseAPI.dio.post(
        "/auth/login",
        data: loginRequest.toJson()
      );
      
      var tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));
      await BaseAPI.userProvider.setAuthToken(tokenResponse.token);
      await BaseAPI.reloadTokenHeader(tokenResponse.token);
      return tokenResponse;

    } on DioException catch (e) {
      throw e.toString();
    }
    
    // if (response.statusCode == 200) {
    //   var tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));
    //   await BaseAPI.userProvider.setAuthToken(tokenResponse.token);
    //   await BaseAPI.reloadTokenHeader(tokenResponse.token);
    //   return tokenResponse;
    // } else {
    //   throw Exception('Wrong phone or password!');
    // }
  }

  Future<void> register(RegisterRequest registerRequest) async {
    Response response = await BaseAPI.dio.post(
        "/auth/register",
        data: registerRequest.toJson()
    );

    if (response.statusCode != 200) {
      throw Exception('Phone already registered');
    }
  }

}