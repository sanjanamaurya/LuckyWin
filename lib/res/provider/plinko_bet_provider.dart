import 'package:theluckywin/model/plinko_result.dart';
import 'package:flutter/material.dart';


class PlinkoBetHistoryProvider with ChangeNotifier {
  List<PlinkoBetHistory> _plinkoList = [];

  List<PlinkoBetHistory> get plinkolist => _plinkoList;

  void setplinkolist(List<PlinkoBetHistory> plinkobet) {
    _plinkoList = plinkobet;
    notifyListeners();
  }
}

