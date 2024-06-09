import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:medimom/app/domain/api/base.dart';
import 'package:medimom/app/domain/dto/doctor/response/CreateOrderRequest.dart';
import 'package:medimom/app/domain/dto/doctor/response/DoctorResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/OrderResponse.dart';
import 'package:medimom/app/domain/dto/doctor/response/document_response.dart';

class DoctorAPI {

  Future<List<DoctorResponse>> findAll() async {
    try {
      Response response = await BaseAPI.dio.get("/doctor/user");
      List<dynamic> parsedListJson = jsonDecode(response.data);
      return List<DoctorResponse>.from(parsedListJson.map<DoctorResponse>((dynamic i) => DoctorResponse.fromJson(i)));
    } on DioException catch (e) {
      throw e.response.toString();
    }
  }

  Future<dynamic> createOrder(CreateOrderRequest orderRequest) async {
    try {
      await BaseAPI.dio.post(
        "/order",
        data: orderRequest.toJson()
      );
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<List<OrderResponse>> findAllOrders() async {
    Response response = await BaseAPI.dio.get("/order");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<OrderResponse>.from(parsedListJson.map<OrderResponse>((dynamic i) => OrderResponse.fromJson(i)));
  }

  Future<List<DocumentResponse>> findAllAnalyze() async {
    Response response = await BaseAPI.dio.get("/analyze/user");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<DocumentResponse>.from(parsedListJson.map<DocumentResponse>((dynamic i) => DocumentResponse.fromJson(i)));
  }

  Future<List<DocumentResponse>> findAllReceipts() async {
    Response response = await BaseAPI.dio.get("/receipt/user");
    List<dynamic> parsedListJson = jsonDecode(response.data);
    return List<DocumentResponse>.from(parsedListJson.map<DocumentResponse>((dynamic i) => DocumentResponse.fromJson(i)));
  }

}