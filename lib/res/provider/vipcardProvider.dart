import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/model/vip_bet_card_/model.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';

class VipCardProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  VipBetCardModel? _vipBetCardData;

  VipBetCardModel? get vipBetCardData => _vipBetCardData;
  void setVipUser(VipBetCardModel vipBetCardData) {
    _vipBetCardData = vipBetCardData;
    notifyListeners();
  }
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  UserViewProvider userViewProvider = UserViewProvider();

  Future<List<VipBetCardModel>> vipBetCardsData(context) async {

    UserModel user = await userViewProvider.getUser();
    String token = user.id.toString();
    try {
      final response = await http.get(Uri.parse('${ApiUrl.vipLevel}$token'));
      print(('${ApiUrl.vipLevel}$token'));
      print(('https'));
      if (response.statusCode == 200) {

        final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
        final items = jsonResponse.map((item) {
          return VipBetCardModel.fromJson(item);
        }).toList();
        return items;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      rethrow;
    }
  }
}