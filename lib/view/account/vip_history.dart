import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/model/viphistorymodel.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';

import '../wallet/deposit_history.dart';


class AllVipHistory extends StatefulWidget {
  const AllVipHistory({super.key});

  @override
  State<AllVipHistory> createState() => _AllVipHistoryState();
}

class _AllVipHistoryState extends State<AllVipHistory> {

  @override
  void initState() {
    vipHistoryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      appBar: GradientAppBar(
          title: textWidget(text: 'VIP History', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body:    responseStatusCode==400?const notFoundData():
      vipHistory.isEmpty?const Center(child: CircularProgressIndicator()) :
      Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: vipHistory.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          8, 15, 8, 0),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Experience Bonus',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.blue),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          const Text(
                            'Betting EXP',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color:
                                AppColors.dividerColor),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                vipHistory[index].createdAt.toString(),
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors
                                        .dividerColor),
                              ),
                              Spacer(),
                              Text(
                                "${vipHistory[index].exp} EXP",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          const Divider(
                            color:
                            AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  int? responseStatusCode;
  List<VipHistoryModel> vipHistory = [];
  UserViewProvider userProvider = UserViewProvider();

  Future<void> vipHistoryList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(

      Uri.parse('${ApiUrl.vipHistory}$token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        vipHistory = responseData
            .map((item) => VipHistoryModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
    } else {
      setState(() {
        vipHistory = [];
      });
      throw Exception('Failed to load transaction history');
    }
  }
}