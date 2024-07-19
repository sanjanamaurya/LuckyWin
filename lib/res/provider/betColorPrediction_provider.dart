// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';


class BetColorResultProvider with ChangeNotifier {
  ProfileProvider profile=ProfileProvider();

  UserViewProvider userProvider = UserViewProvider();
  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future Colorbet(context, String amount, String number,String gameid) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.bettingApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String>{
        "userid":token,
        "game_id":gameid,
        "number":number,
        "amount":amount
      }),
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      setRegLoading(false);
      context.read<ProfileProvider>().fetchProfileData();
      Navigator.pop(context);

      notifyListeners();
      return Fluttertoast.showToast(msg: responseData['message']);
        //ImageToast.show(imagePath: Assets.imagesBetSucessfull, context: context,heights: 200,widths: 200);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }
}