import 'package:dio/dio.dart';
import 'dart:convert';

class LoginApi {

  String _codigo = '';
  String _pass = '';

  LoginApi(String codigo, String pass) {
    _codigo = codigo;
    _pass = pass;
  }

  Future<bool> loginApi() async {

    bool authenticated = false;

    var formData = jsonEncode({
      "keyApi" : "tu3RFoE9aUKoTx@OqgzgsZeBU1k=ty",
      "codigo" : _codigo,
      "senha" : _pass,
    });

    try {

      final response = await Dio().post(
        "https://bi.eletrosom.com/api_codeReader/authentication/",
        data: formData,
        options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false
        ),
      );

      //var auth = jsonDecode(response.data);

      String jsonsDataString = response.data.toString();
      final jsonData = jsonDecode(jsonsDataString);

      try {

        if(jsonData['auth'] == false){
          authenticated = false;
        }

      } catch (e) {
          authenticated = true;
      }

    } on DioError catch (e) {
      //
    }

    return Future<bool>.value(authenticated);

  }
}