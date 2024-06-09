import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/dto/user/request/ConfirmRequest.dart';
import 'package:medimom/app/domain/dto/user/response/TokenRespons.dart';

class ConfirmationAPI {

  Future<TokenResponse> confirmRegister(ConfirmRequest confirmRequest) async {
    Response response = await BaseAPI.dio.post(
        "/auth/register/confirm",
        data: confirmRequest.toJson()
    );
    if (response.statusCode == 200) {
      var tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));
      await BaseAPI.userProvider.setAuthToken(tokenResponse.token);
      await BaseAPI.reloadTokenHeader(tokenResponse.token);
      return tokenResponse;
    } else {
      throw Exception('Wrong phone or password!');
    }
  }

}