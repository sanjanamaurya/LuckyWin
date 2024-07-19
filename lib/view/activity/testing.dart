import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:theluckywin/res/api_urls.dart';

class AllTierData {
  final int userId;
  final String username;
  final dynamic turnover;
  final dynamic commission;

  AllTierData({
    required this.userId,
    required this.username,
    required this.turnover,
    required this.commission,
  });
}

class TestPromotion extends StatefulWidget {
  const TestPromotion({super.key});

  @override
  State<TestPromotion> createState() => _TestPromotionState();
}

class _TestPromotionState extends State<TestPromotion> {
  List<AllTierData> alldata = [];
  List<String> alllevel = [];
String type='all';
  @override
  void initState() {
    attendanceHistory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 50, top: 30),
        child: ListView(
          children: [
            for (var datas in alllevel)
              InkWell(
                  onTap: (){
                    setState(() {
                      type=datas;
                    });
                    listparsing();
                  },
                  child: Text(datas)),

            const SizedBox(height: 30,),
            for (var data in alldata)
            Text(data.username)

          ],
        ),
      ),
    );
  }

  listparsing(){
    if(type=='all') {
      alldata.clear();
      alllevel.clear();
      alllevel.add('all');
      for (var data in responseData['levelwisecommission']) {
        alllevel.add(data['name']);
        for (var alldatas in responseData["userdata"][data['name']]) {
          alldata.add(AllTierData(
              userId: alldatas['user_id'],
              username: alldatas['username'].toString().toUpperCase(),
              turnover: alldatas['turnover'],
              commission: alldatas['commission']));
        }
        setState(() {});
      }
    }else{
      alldata.clear();
      for (var alldatas in responseData["userdata"][type]) {
        alldata.add(AllTierData(
            userId: alldatas['user_id'],
            username: alldatas['username'].toString().toUpperCase(),
            turnover: alldatas['turnover'],
            commission: alldatas['commission']));
      }
      setState(() {});
    }
  }
  Map<String, dynamic> responseData = {};
  attendanceHistory() async {
    // Your implementation of attendanceHistory function goes here
    String token = '2';
    final response = await http.get(
      Uri.parse(ApiUrl.promotionScreen + token),
    );
    if (response.statusCode == 200) {
       responseData = json.decode(response.body);
      listparsing();
    }
  }
}
