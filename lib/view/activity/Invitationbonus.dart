import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/invitation_bonus_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/theam_color.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/view/activity/invitation_bonus_history.dart';
import 'package:theluckywin/view/activity/invitation_reward_rules.dart';
import 'package:http/http.dart'as http;

class InvitationBonus extends StatefulWidget {
  const InvitationBonus({super.key});

  @override
  State<InvitationBonus> createState() => _InvitationBonusState();
}

class _InvitationBonusState extends State<InvitationBonus> {

  @override
  void initState() {
    invationbonusList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomTheme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: Text(
            'Invitation bonus',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: myCustomTheme.appBarTheme.backgroundColor),
          ),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.35,
                width: width,
                decoration:
                const BoxDecoration(gradient: AppColors.primaryGradient),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.2,
                        width: width * 0.3,
                        child: Image.asset(Assets.iconsInvitationGift),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invite friends and deposit ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Both parties can receive rewards ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Invite friends to register and recharge\nto receive rewards',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Activity date ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '2024-02-28-2099-02-27',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 14, right: 14, top: height * 0.25),
            child: Column(
              children: [
                Container(
                  height: height * 0.18,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: AppColors.whitegradient,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const InvitationRewardRules()));
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: height * 0.1,
                                width: width * 0.2,
                                child: Image.asset(Assets.iconsInviterule),
                              ),
                              const Text('Invitation reward rules ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      ))
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const InvitationBonsHistory()));
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: height * 0.1,
                                width: width * 0.2,
                                child: Image.asset(Assets.iconsInviterecord),
                              ),
                              const Text('Invitation record ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                     ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding:  const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: invationbonus.length,
                      itemBuilder: (context, index) {
                        final data= invationbonus[index];
                        return Container(
                          height: height * 0.45,
                          width: width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.iconsInvitionlist),
                                  fit: BoxFit.fill)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.037,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: height * 0.062,
                                      width: width * 0.4,
                                      decoration:  BoxDecoration(
                                          color:data.status==0? Colors.grey:Colors.green,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15))),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Text('Bonus ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17,
                                                    color: Colors.white)),
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.white,
                                              child: Text(data.bonusId.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w900,
                                                      fontSize: 17,
                                                      color: Colors.black)),
                                            ),
                                            const CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.close,
                                                  size: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text('₹${data.claimAmount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: Colors.orange))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.037,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Number of invitees ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white)),
                                    SizedBox(width: width*0.3,),
                                    Text(data.noOfUser.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            )),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Recharge per people ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white)),
                                    SizedBox(width: width*0.27,),
                                    Text(data.amount.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            color: Colors.blue)),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.07,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text('${data.noOfInvitees<data.noOfUser?data.noOfInvitees:data.noOfUser} / ${data.noOfUser}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22,
                                              color: AppColors.gradientFirstColor)),
                                      const Text('Number of invitees',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('${data.referInvitees<data.noOfUser?data.referInvitees:data.noOfUser} / ${data.noOfUser}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22,
                                              color: AppColors.gradientFirstColor)),
                                      const Text('Deposit Numbers',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              AppBtn(
                                  height: height*0.065,
                                  title: data.status==0?'Unfinished':data.status==1?'Receive':data.status==2?'Received':'Expired',
                                  fontSize: 20,
                                  onTap: () {},
                                  hideBorder: true,
                                  gradient: AppColors.buttonGradient
                              ),

                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
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

}
class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*0.05,),
        Image.asset(Assets.imagesNoDataAvailable,height: height*0.21,),
        // Image(
        //   image: const AssetImage(Assets.imagesNoDataAvailable),
        //   height: heights / 3,
        //   width: widths / 2,
        // ),
        const Text("No data (:",style: TextStyle(color: Colors.white),)
      ],
    );
  }

}
