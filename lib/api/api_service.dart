import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<LoginApiResponse> apiVerifyOtp(Map<String, dynamic> param) async {
    var url = Uri.parse(
        'https://zzzmart.com/admin/ecommerce_api/customer_login.php?apicall=get_otp_verify');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    return LoginApiResponse(
        status: data["status"], msg: data["msg"], data: data["data"]);
  }

  Future<LoginApiResponse> apiLogin(Map<String, dynamic> param) async {
    var url = Uri.parse(
        'https://zzzmart.com/admin/ecommerce_api/customer_login.php?apicall=login');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    return LoginApiResponse(
        status: data["status"], msg: data["msg"], data: data["data"]);
  }

  Future<LoginApiResponse> apiReg(Map<String, dynamic> param) async {
    var url = Uri.parse(
        'https://zzzmart.com/admin/ecommerce_api/customer_login.php?apicall=new_register');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    return LoginApiResponse(
        status: data["status"], msg: data["msg"], data: data["data"]);
  }
}

class LoginApiResponse {
  final String? status;
  final String? msg;
  final String? data;
  //"status": 1,
  //"msg": "OTP Verified.",
  //"data": []

  LoginApiResponse({this.status, this.msg, this.data});
}
