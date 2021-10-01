import 'package:dio/dio.dart';

class LoginApi {

  void loginApi() async {

    var formData = FormData.fromMap({
      "keyApi" : "@CAzkEsidif5KbQk3LnNx#mJYZL^G7",
      "codigo" : "01686",
      "senha" : "R"
    });

    var response = await Dio().post('/info', data: formData);

  }
}