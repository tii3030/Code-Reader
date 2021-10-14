import '../model/user.dart';
import '../model/barcode.dart';
import 'dao_home.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'dao_login.dart';

class Syncup {

  // GET LIST BARCODE AND QRCODE
  Future getBarcodeList() async {
    DaoHome daoHome = DaoHome();
    List<Barcode> foos = await daoHome.getAll();

    List<String> itemsTemp = [];

    foos.asMap().forEach((i, value) {
      itemsTemp.add(value.barcode);
      //print('index=$i, value=$value');
    });

    return itemsTemp;
  }

  // GET CODE OF USER
  Future getCode() async {
    DaoLogin daoLogin = DaoLogin();
    List<User> obj = await daoLogin.getUser();
    return obj.last.code;
  }

  Future<bool> sendData() async {

    List<String> jsonDataSend = await getBarcodeList();
    bool isSuccess = false;
    String code = await getCode();
    var formData = jsonEncode({
      "user_register" : code,
      "barcode_qrcode" : jsonDataSend,
    });

    try {

      final response = await Dio().post(
        "https://bi.eletrosom.com/api_codeReader/v1/Api_app.php",
        data: formData,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJBcHBsaWNhdGlvbiI6ImJpLmVsZXRyb3NvbS5jb20ifQ.SHqDMo0Sxg00nbL5WRehWPOggQcAJ27FSUB1DQ4o7Ng",
            "content-Type": "application/json"
          },
          followRedirects: false
        ),
      );

      String jsonsDataString = response.data.toString();
      final jsonData = jsonDecode(jsonsDataString);

      try {

        if(jsonData['success'] == 1){
          isSuccess == true;
        } else {
          isSuccess == false;
        }

      } catch (e) {
          isSuccess == false;
      }

    } on DioError catch (e) {
      isSuccess == false;
    }

    return Future<bool>.value(isSuccess);

  }


}