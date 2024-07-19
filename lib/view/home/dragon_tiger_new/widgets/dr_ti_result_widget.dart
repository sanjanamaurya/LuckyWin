import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/result_game_history.dart';

import '../../../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class DrTiResultWidget extends StatefulWidget {
  final String gameId;
   const DrTiResultWidget({
    super.key, required this.gameId,
  });

  @override
  State<DrTiResultWidget> createState() => _DrTiResultWidgetState();
}

class _DrTiResultWidgetState extends State<DrTiResultWidget> {


  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final drTiResultViewModel = Provider.of<ResultGameHistory>(context).number;
    return SizedBox(
      height: height / 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length)
          {
            return InkWell(
              onTap: () {
                if (kDebugMode) {
                  print('history');
                }
              },
              child: Container(
                width: width * 0.1,
                decoration: BoxDecoration(
                    image:  const DecorationImage(
                        image: AssetImage(Assets.dragontigerBtnCaidan),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(3)),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.asset(
              // 60 dragon
              // 70 tiger
              // 80 tie
              items[index].number!.toString() == '60'
                  ? Assets.dragontigerIcDtD
                  : items[index].number!.toString() == '70'
                  ? Assets.dragontigerIcDtT:
                   Assets.dragontigerIcDtTie,
            ),
          );
        },
      ),
    );
  }


  List<ResultGameHistory> items = [];

  Future<void> fetchData() async {
    var gameIds = widget.gameId;
    print(gameIds);
    print('gameIds');
    final response = await http.get(Uri.parse("${ApiUrl.resultList}$gameIds&limit=10"));
    print("${ApiUrl.resultList}$gameIds&limit=10");
    print('yyyyyyyyyy');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => ResultGameHistory.fromJson(item)).toList();
      });
      // items.clear();
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
