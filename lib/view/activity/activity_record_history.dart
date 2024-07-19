import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/acitvity_collection_bonus_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/theam_color.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import '../../res/api_urls.dart';
import 'package:http/http.dart'as http;

class ActivityRecordHistory extends StatefulWidget {
  const ActivityRecordHistory({super.key});

  @override
  State<ActivityRecordHistory> createState() => _ActivityRecordHistoryState();
}

class _ActivityRecordHistoryState extends State<ActivityRecordHistory> {

  @override
  void initState() {
    activityRecordsHistoryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: Text(
          'Receive history ',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: myCustomTheme.appBarTheme.backgroundColor),
        ),
        centerTitle: true,
        gradient: AppColors.primaryUnselectedGradient,
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.1,
            width: width,
            color: AppColors.bottomNavColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildInkWell(21,'Daily'),
                buildInkWell(22,'Weekly'),
              ],
            ),
          ),
          responseStatuscode==400?const Notfounddata():
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:activityRecordsHistory.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final data=activityRecordsHistory[index];
                return Center(
                  child: InkWell(
                    onTap: () {
                      // Call the onTap function associated with the item
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Container(
                      //  height: height*0.2,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: AppColors.primaryUnselectedGradient
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8,15,8,15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedIndex==21?
                                'Daily Mission Reward':'Weekly Mission Reward',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: AppColors.primaryTextColor),
                              ),
                              SizedBox(height: height*0.02,),
                              Row(
                                children: [
                                  Text(     selectedIndex==21?
                                    'Daily betting bonus': 'weekly betting bonus',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.primaryTextColor),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                    '${data.description}/${data.description}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.gradientFirstColor),
                                  ),
                                ],
                              ),
                              SizedBox(height: height*0.02,),
                              Row(
                                children: [
                                  Text(
                                    data.updatedAt.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.dividerColor),
                                  ),
                                 const Spacer(),
                                  Container(
                                      height:30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(image: AssetImage(Assets.iconsDepoWallet,))),
                                    ),
                                  Text(
                                    '₹${data.amount}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: AppColors.gradientFirstColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  int selectedIndex = 21; // Index of the selected container

   buildInkWell(int index,String title) {
    return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  print(selectedIndex);
                  activityRecordsHistoryList();
                },
                child: Center(
                  child: Container(
                    height: height * 0.08,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient:index == selectedIndex ? AppColors.loginSecondryGrad:AppColors.timeGradient),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: AppColors.primaryTextColor),
                      ),
                    ),
                  ),
                ),
              );
  }


  int ?responseStatuscode;


  UserViewProvider userProvider = UserViewProvider();

  List<ActivityCollectionBonusModel> activityRecordsHistory = [];

  Future<void> activityRecordsHistoryList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse('${ApiUrl.activityRewardsHistory}$token&subtypeid=$selectedIndex'),);
    if (kDebugMode) {
      print(ApiUrl.activityRewardsHistory+token);
      print('activityRewards');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        activityRecordsHistory = responseData.map((item) => ActivityCollectionBonusModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        activityRecordsHistory = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}