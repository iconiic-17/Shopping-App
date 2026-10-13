import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/auth/data/model/register_request_dto.dart';

class AuthApi {
  
  Future<ResultApi<String>> register(
    RegisterRequestDto request,
  ) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.register);
      var response = await http.post(url, body: request.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var resBody =response.body;
        var json = jsonDecode(resBody);
       return Success( json['message'].toString());
       
      }else {
        return Error( 'Failed to register');
      }
      
    } on SocketException {
      return Error( 'No Internet connection');
    } catch (e) {
      return Error( 'error from catch $e');
    }
  } 

  
}
