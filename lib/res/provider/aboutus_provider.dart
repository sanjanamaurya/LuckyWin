import 'package:flutter/material.dart';
import 'package:theluckywin/model/aboutus_model.dart';


class AboutusProvider with ChangeNotifier {
  AboutusModel? _aboutusData;

  AboutusModel? get aboutusData => _aboutusData;

  void setUser(AboutusModel userData) {
    _aboutusData = userData;
    notifyListeners();
  }
}