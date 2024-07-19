// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/utils/utils.dart';

class UserAuthProvider with ChangeNotifier {
  //setter and getter for loading
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserModel? _loginResponse;

  UserModel? get loginResponse => _loginResponse;
  userLogin(context, String phoneNumber, String password) async {
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.login
         // 'http`s://theluckywin.earlycarehealth.in/api/login'
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "identity": phoneNumber,
        "password": password,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == '200') {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
      setRegLoading(false);
      final userPref = Provider.of<UserViewProvider>(context, listen: false);
      userPref.saveUser(UserModel(id: data['id'].toString()));
      Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == "401") {
      setRegLoading(false);
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      setRegLoading(false);
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  bool _regLoading = false;
  bool get regLoading => _regLoading;
  setRegLoading(bool value) {
    _regLoading = value;
    notifyListeners();
  }
  UserViewProvider userProvider = UserViewProvider();

  // String otp = "";
  userRegister(context, String identity, String password, String confirmpass, String referralCode, String email, String id,String otp) async {
    // UserModel user = await userProvider.getUser();
    // String userid = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // "mobile": identity,
        // "password": password,
        // "email": email,
        // "confirm_password": confirmpass,
        // "referral_code": referralCode


        "mobile":identity,
        "otp":otp,
        "password":password,
        "password_confirmation":confirmpass,
        "userid":id,
        "email":email,
        "referral_code": referralCode
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      setRegLoading(false);
      // otp=jsonDecode(response.body)["otp"];
      final userPref = Provider.of<UserViewProvider>(context, listen: false);
      userPref.saveUser(UserModel(id: data['id'].toString()));
      print(userPref.saveUser);
      print('eeeeeeeeeee');
      Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
      Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }
}
