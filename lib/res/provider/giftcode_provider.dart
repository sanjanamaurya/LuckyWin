// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class GiftcardProvider with ChangeNotifier {

  UserViewProvider userProvider = UserViewProvider();

  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future Giftcode(context, String code) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    setRegLoading(true);
    final response = await http.get(Uri.parse("${ApiUrl.giftcardapi}userid=$token&code=$code")).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      print(response);
      print("response gift");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");
      setRegLoading(false);
      return Fluttertoast.showToast(msg: responseData['message']);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }
}