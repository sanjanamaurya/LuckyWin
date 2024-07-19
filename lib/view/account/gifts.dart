import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/gift_history_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/giftcode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';

import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class GiftsPage extends StatefulWidget {
  const GiftsPage({super.key});

  @override
  GiftsPageState createState() => GiftsPageState();
}

class GiftsPageState extends State<GiftsPage> {
  TextEditingController giftcode = TextEditingController();

  String number = "";

  @override
  void initState() {
    giftHistoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final giftProvider = Provider.of<GiftcardProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'Gift',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.white,
          ),
          gradient: AppColors.primaryGradient),
      body: ListView(
        children: [
          Container(
            height: height / 3.5,
            width: width,
            decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                image: DecorationImage(
                  image: AssetImage(Assets.imagesGift),
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              // ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white),
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              // height: height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: '   Hi',
                        fontSize: 14,
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    textWidget(
                        text: '   We have a gift for you',
                        fontSize: 14,
                        color: AppColors.primaryTextColor),
                    const SizedBox(
                      height: 25,
                    ),
                    textWidget(
                        text: '   Please enter the gift code below',
                        fontSize: 14,
                        color: AppColors.primaryTextColor),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextField(
                      controller: giftcode,
                      hintText: 'Please enter gift code',
                      fieldRadius: BorderRadius.circular(50),
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    ),
                    AppBtn(
                      title: 'Receive',
                      titleColor: Colors.white,
                      gradient: AppColors.primaryGradient,
                      onTap: () {
                        giftProvider.Giftcode(context, giftcode.text);
                      },
                    )
                  ],
                ),
              )),
          Container(
            height: height*0.4,
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.iconsTeamport))),
                    ),
                    textWidget(
                        text: '   History',
                        fontSize: 18,
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w700),
                  ],
                ),
                const SizedBox(height: 15,),
                Expanded(
                  child: ListView.builder(
                      itemCount: giftHistory.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context , index){
                        final Gift=giftHistory[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWidget(
                                        text: 'Successfully received',
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500),
                                    const SizedBox(height: 5,),
                                    textWidget(
                                        text:Gift.dateTime.toString(),
                                        fontSize: 14,
                                        color: AppColors.primaryTextColor,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  height: height*0.03,
                                  width: width*0.24,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColors.gradientFirstColor,
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(Assets.iconsDepoWallet),
                                        textWidget(
                                            text:Gift.amount.toString(),
                                            fontSize: 14,
                                            color: AppColors.primaryTextColor,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1,color: Colors.grey,),


                          ],
                        );

                      }),
                ),
                textWidget(
                    text: 'No More',
                    fontSize: 18,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.w700),

              ],
            ),
          )
        ],
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  List<GiftHistoryModel> giftHistory = [];

  Future<void> giftHistoryApi() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.giftHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.giftHistory+token);
      print('getwayList+token');

    }


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        giftHistory = responseData.map((item) => GiftHistoryModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        giftHistory = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
