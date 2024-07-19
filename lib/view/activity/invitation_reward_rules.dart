import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/invitation_bonus_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/components/theam_color.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:http/http.dart'as http;

import '../../res/api_urls.dart';
class InvitationRewardRules extends StatefulWidget {
  const InvitationRewardRules({super.key});

  @override
  State<InvitationRewardRules> createState() => _InvitationRewardRulesState();
}

class _InvitationRewardRulesState extends State<InvitationRewardRules> {

  @override
  void initState() {
    invationbonusList();
    invitationRuleApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: Text(
          'Invitation reward rules',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: myCustomTheme.appBarTheme.backgroundColor),
        ),
        centerTitle: true,
        gradient: AppColors.primaryUnselectedGradient,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            const Text(
              'Invite friends and recharge to get additional platform rewards!',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.primaryTextColor),
            ),
            SizedBox(height: height*0.01,),
            const Text(
              'After being claimed, the rewards will be directly distributed to the wallet balance within 10 minutes.',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.primaryTextColor),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
               decoration: BoxDecoration(
                 gradient: AppColors.primaryUnselectedGradient,
                 borderRadius: BorderRadius.circular(10)
               ),
                child: Column(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            gradient: AppColors.buttonGradient,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                        ),
                      height:height*0.08,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           buildContainer('Invite Account'),
                           buildContainer('Deposit Amount'),
                           buildContainer('Bonus'),
                         ],
                       ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: invationbonus.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data= invationbonus[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildContainer('${data.noOfUser} People'),
                                    buildContainer('₹${data.amount}'),
                                    buildContainer('₹${data.claimAmount}'),
                                  ],
                                ),
                                const Divider(color: AppColors.gradientFirstColor,thickness: 1,)
                              ],
                            ),
                          );
                        }),

                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondaryContainerTextColor,width: 2),
                      //  gradient: AppColors.primaryUnselectedGradient,
                        borderRadius: BorderRadius.circular(10)
                  ),
                    child: Column(
                      children: [
                        SizedBox(  height: height*0.06,),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: invitationRuleList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child:instruction(invitationRuleList[index]),

                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: height*0.06,
                    width: width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Assets.iconsRulehead),fit: BoxFit.fill)
                    ),
                    child: const Center(
                      child: Text(
                        'Rules',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: AppColors.primaryTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  instruction(String title) {
    return ListTile(
      leading: Transform.rotate(
        angle: 45 * 3.1415927 / 180,
        child: Container(
          height: 10,
          width: 10,
          color: AppColors.gradientFirstColor,
        ),
      ),
      title: textWidget(
          text: title,
          fontSize: 14,
          color: AppColors.primaryTextColor
      ),
    );
  }
   buildContainer(String text) {
    return SizedBox(
                           width: width*0.28,
                         //  color: Colors.black,
                           child: Center(
                             child: Text(text,
                               style: const TextStyle(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 13,
                                   color: AppColors.primaryTextColor),
                             ),
                           ),
                         );
  }

  int?responseStatuscode;
  UserViewProvider userProvider = UserViewProvider();

  List<InvitationBonusModel> invationbonus = [];

  Future<void> invationbonusList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.invitationBonusList+token),);
    if (kDebugMode) {
      print(ApiUrl.invitationBonusList+token);
      print('invitationBonusList');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        invationbonus = responseData.map((item) => InvitationBonusModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        invationbonus = [];
      });
      throw Exception('Failed to load data');
    }
  }


  List<String> invitationRuleList = [];


  Future<void> invitationRuleApi() async {
    final response = await http.get(Uri.parse('${ApiUrl.allRules}1'),);
    if (kDebugMode) {
      print('${ApiUrl.allRules}1');
      print('allRules');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        invitationRuleList = json.decode(responseData[0]['list']).cast<String>();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        invitationRuleList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
