import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/activity_record_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:http/http.dart'as http;
import 'package:theluckywin/view/activity/activity_record_history.dart';

import '../../res/api_urls.dart';

class ActivityAward extends StatefulWidget {
  const ActivityAward({Key? key}) : super(key: key);

  @override
  State<ActivityAward> createState() => _ActivityAwardState();
}

class _ActivityAwardState extends State<ActivityAward> {
  @override
  void initState() {
    activityRecordsList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ActivityRecordHistory()));
              },
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      Assets.iconsAwardRecord,
                      scale: 1.8,
                    ),
                  ),
                  textWidget(
                    text: 'Collection record',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
        centerTitle: true,
        gradient: AppColors.primaryGradient,
      ),
      body: Column(
        //    shrinkWrap: true,
        children: [
          Container(
            height: height * 0.2,
            width: width,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Row(
              children: [
                Container(
                  height: height * 0.18,
                  width: width * 0.35,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.iconsActivitygift),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: height * 0.18,
                  width: width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: 'Activity record',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textWidget(
                        text:
                        'Complete weekly/daily tasks to receive rich rewards',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      textWidget(
                        text:
                        'Weekly rewards cannot be accumulated to the next week, and daily rewards cannot be accumulated to the next day.',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          activityRecords.isEmpty?const Center(child: CircularProgressIndicator()):
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: activityRecords.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final data=activityRecords[index];
                return Center(
                  child: InkWell(
                    onTap: () {
                      // Call the onTap function associated with the item
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Container(
                        height: height * 0.33,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: AppColors.whitegradient,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height*0.05,
                                  width: width*0.36,
                                  decoration:  BoxDecoration(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10) ),
                                      gradient: data.name == 'daily mission'
                                          ? AppColors.ssbutton:AppColors.primaryGradient // Use your gradient variable here


                                  ),
                                  child: Center(
                                    child: textWidget(
                                      text: data.name.toString(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                textWidget(
                                  text:data.status==1? 'finished   ':'Unfinished   ',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: data.status==1?Colors.green:Colors.grey,
                                ),

                              ],
                            ),
                            Container(
                              height: 1,
                              width: width,color: AppColors.gradientFirstColor,),
                            const SizedBox(height: 20,),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 7,),
                                Container(
                                  height: height*0.05,
                                  width: width*0.09,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage(Assets.iconsActivityball),fit:BoxFit.fill ),
                                  ),

                                ),
                                const SizedBox(width: 7,),
                                textWidget(
                                  text: 'Lottery Betting Task',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,

                                ),
                                const SizedBox(width: 7,),
                                textWidget(
                                  text: '${data.betAmount<data.rangeAmount?data.betAmount:data.rangeAmount}/${data.rangeAmount}',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.gradientFirstColor,
                                ),


                              ],
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: height*0.04,
                              width: width*0.84,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                    text: 'Award Amount',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: height*0.05,
                                        width: width*0.08,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(image: AssetImage(Assets.iconsDepoWallet),fit:BoxFit.fill ),
                                        ),

                                      ),
                                      const SizedBox(width: 7,),
                                      textWidget(
                                        text: '₹${data.amount}',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.deepOrange

                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: GestureDetector(
                                onTap: () {

                                },
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadiusDirectional.circular(30),
                                      border: Border.all(
                                          width: 0.5, color: AppColors.gradientFirstColor)),
                                  child: Center(
                                    child: textWidget(
                                        text: data.status==0?'to complete':' completed',
                                        fontSize: 14,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
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
  int ?responseStatuscode;
  UserViewProvider userProvider = UserViewProvider();



  List<ActivityRecordModel> activityRecords = [];

  Future<void> activityRecordsList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse('${ApiUrl.activityRewards}$token'),);
    if (kDebugMode) {
      print(ApiUrl.activityRewards+token);
      print('activityRewards');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        activityRecords = responseData.map((item) => ActivityRecordModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        activityRecords = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

