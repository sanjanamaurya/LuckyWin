// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:theluckywin/res/app_constant.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/clipboard.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/view/account/service_center/custmor_service.dart';
import 'package:theluckywin/view/promotion/invitation_rules.dart';
import 'package:theluckywin/view/promotion/new_subordinate.dart';
import 'package:theluckywin/view/promotion/subordinate_data.dart';


class PromotionScreenNew extends StatefulWidget {
  const PromotionScreenNew({super.key});

  @override
  State<PromotionScreenNew> createState() => _PromotionScreenNewState();
}

class _PromotionScreenNewState extends State<PromotionScreenNew> {


  @override
  void initState() {
    promotionData();
    versionCheck();
    super.initState();
  }
  bool verssionview = false;

  @override
  Widget build(BuildContext context) {




    final List<Map<String, dynamic>> items = [
      {
        'text': 'Copy Invitation Code',
        'icon': Assets.iconsCopycode,
        'Subtext': invitationCode.toString(),
        'onTap': () {
          copyToClipboard(invitationCode.toString(),context);
        },
      },
      {
        'text': 'Subordinate data', 'icon': Assets.iconsTeamport, 'Subtext': '',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SubOrdinateDataScreen()));
        },},
      // {
      //   'text': 'Commission detail',
      //   'icon': Assets.iconsCommission,
      //   'Subtext': '',
      //   'onTap': () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const CommissionDetails( )));
      //   },
      // },
      {
        'text': 'Invitation rules',
        'icon': Assets.iconsInvitereg,
        'Subtext': '',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const InvitationRules( )));
        },
      },
      {
        'text': 'Agent line customer service',
        'icon': Assets.iconsCustomer,
        'Subtext': '',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomerCareService( )));
        },
      },
      //  {'text': 'Rebate ratio', 'icon': Assets.iconsRebateRatio, 'Subtext': '',  'onTap': () {},},
    ];


    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
      children: [
      CircleAvatar(
      radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage:  AssetImage(
          Assets.imagesSplashImage,
        ),
      ),
      textWidget(
          text: " Lucky Win",
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: width * 0.065),
      ],
    ),
          actions: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NewSubordinate()));
              },
              child: Center(
                child: Image.asset(
                  Assets.iconsFilternew,
                  height: 30,

                ),
              ),
            ),
          ],
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.48,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        // const Text(
                        //   'Promotion',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white),
                        // ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          yesterdayTotalCommission.toString(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white),
                        ),
                        Container(
                          height: height * 0.06,
                          width: width * 0.8,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "Yesterday's total commission",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Upgrade the level to increase level income",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.18,
                  ),
                  kIsWeb==true?
                  // AppBtn(
                  //   gradient: AppColors.primaryGradient,
                  //   hideBorder: true,
                  //   title: 'INVITATION LINK',
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.w900,
                  //   onTap: () async {
                  //     String referralUrl = '${ApiUrl.baseUrl}?id=$invitationCode';
                  //     Share.share('Its my referral Code : *$invitationCode* link to join: $referralUrl  ,'
                  //         'Download Now : ${context.read<ProfileProvider>().apkLink}',
                  //         subject: 'Join Now !!');
                  //
                  //   },
                  // )
                  AppBtn(
                    gradient: AppColors.primaryGradient,
                    hideBorder: true,
                    title: 'INVITATION LINK',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    onTap: () async {
                      Share.share(context.read<ProfileProvider>().referralCodeUrl,);

                    },
                  ):
                  AppBtn(
                    titleColor: AppColors.white,
                    gradient: AppColors.loginSecondryGrad,
                    hideBorder: true,
                    title: 'INVITATION LINK',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    onTap: () async {
                      await FlutterShare.share(
                          title: 'Referral Code :',
                          text:"Join our gaming platform to win exciting prizes. Here is my Referral Code : $invitationCode",
                          // 'Join Now & Get ₹50 and Exiting Prizes. here is my Referral Code : ${userData.referralCode}',
                          // linkUrl: "${ApiUrl.baseUrl}?id=$invitationCode",
                          linkUrl: context.read<ProfileProvider>().referralCodeUrl,
                          chooserTitle: 'Referral Code : ');

                    },
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              items[index]['onTap']();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  height: height * 0.10,
                                  width: width * 0.9,
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Image(
                                            image: AssetImage(
                                              items[index]['icon'].toString(),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        items[index]['text'].toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        items[index]['Subtext'].toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                           ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: width*0.02,)
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      height: height * 0.475,
                      width: width * 0.925,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.iconsMoneyicon,
                                  scale: 1.5,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                const Text(
                                  'promotion data',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                     ),
                                ),
                              ],
                            ),
                            addSecondTextColumn(
                                totalCommission==null?"0":totalCommission.toStringAsFixed(2), 'Total Commission', '', Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                addSecondTextColumn(
                                    totalSubordinate.toString(), 'Direct Subordinate', '', Colors.black),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.white,
                                ),
                                addSecondTextColumn(totalSubordinateInTeam.toString(), 'Total number of',
                                    'Subordinates in the team', Colors.black),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                addSecondTextColumn(
                                total_salary==null?"0":total_salary.toString(), 'Total Salary', '', Colors.black),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.white,
                                ),
                                addSecondTextColumn(
                                    total_withdraw==null?"0":total_withdraw.toString(), 'Total Withdrawal', '', Colors.black),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                addSecondTextColumn(
                                    today_salary==null?"0":today_salary.toString(), 'Today Salary', '', Colors.black),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.white,
                                ),
                                addSecondTextColumn(
                                    today_withdraw==null?"0":today_withdraw.toString(), 'Today Withdrawal', '', Colors.black),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.25),
                  child: Container(
                    height: height * 0.38,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.08,
                          width: width * 0.9,
                          decoration: const BoxDecoration(
                              color: Color(0xfff6f6f6),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.iconsAgFirst,
                                scale: 2,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Direct Subordinate",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                     ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: height * 0.08,
                                width: 2,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.iconsAgSecond,
                                scale: 2,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                "Team  Subordinate",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                addTextColumn(
                                    numberOfRegister.toString(), 'Number of Register', Colors.black),
                                addTextColumn(
                                    depositNumber.toString(), 'Deposit Number', Colors.green),
                                addTextColumn(
                                    depositAmount.toString(), 'Deposit amount', Colors.deepOrange),
                                addTextColumn(
                                    numberOfFirstDeposit.toString(),
                                    'Number of People making\n            first deposit',
                                    Colors.black),
                              ],
                            ),
                            Column(
                              children: [
                                addTextColumn(
                                    subNumberOfRegister.toString(), 'Number of Register', Colors.black),
                                addTextColumn(
                                    subDepositNumber.toString(), 'Deposit Number', Colors.green),
                                addTextColumn(
                                    subDepositAmount.toString(), 'Deposit amount', Colors.deepOrange),
                                addTextColumn(
                                    subNumberOfFirstDeposit.toString(),
                                    'Number of People making\n            first deposit',
                                    Colors.black),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  addTextColumn(String number, String subtext, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
          ),
          Text(
            subtext,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.dividerColor),
          ),
        ],
      ),
    );
  }

  addSecondTextColumn(
      String number, String subtext, String subtextOne, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: textColor),
          ),
          Text(
            subtext,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.dividerColor),
          ),
          Text(
            subtextOne,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.dividerColor),
          ),
        ],
      ),
    );
  }
  dynamic invitationCode;
  dynamic  numberOfRegister;
  dynamic depositNumber;
  dynamic depositAmount;
  dynamic numberOfFirstDeposit;
  dynamic subNumberOfRegister;
  dynamic subDepositNumber;
  dynamic subDepositAmount;
  dynamic subNumberOfFirstDeposit;
  dynamic totalCommission;
  dynamic yesterdayTotalCommission;
  dynamic totalSubordinate;
  dynamic totalSubordinateInTeam;
  dynamic responseStatuscode;
  dynamic today_withdraw;
  dynamic total_withdraw;
  dynamic today_salary;
  dynamic total_salary;



  // "yesterday_total_commission": 12.04,
  // "register": 0,
  // "deposit_number": 0,
  // "deposit_amount": 0,
  // "first_deposit": 0,
  // "subordinates_register": 0,
  // "subordinates_deposit_number": 0,
  // "subordinates_deposit_amount": 0,
  // "subordinates_first_deposit": 0,
  // "direct_subordinate": 14,
  // "total_commission": 49,
  // "team_subordinate": 3550,
  // "referral_code": "KW5227"

  UserViewProvider userProvider = UserViewProvider();

  promotionData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.promotionScreen+token));
    if (kDebugMode) {
      print(ApiUrl.promotionScreen+token);
      print('promotionData');
    }
    setState(() {
      responseStatuscode = response.statusCode;
    });

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {

      setState(() {
        numberOfRegister = responseData['register'].toString();
        depositNumber = responseData['deposit_number'].toString();
        depositAmount = responseData['deposit_amount'].toString();
        numberOfFirstDeposit = responseData['first_deposit'].toString();
        subNumberOfRegister = responseData['subordinates_register'].toString();
        subDepositNumber = responseData['subordinates_deposit_number'].toString();
        subDepositAmount = responseData['subordinates_deposit_amount'].toString();
        subNumberOfFirstDeposit = responseData['subordinates_first_deposit'].toString();
        totalCommission = responseData['total_commission'];
        invitationCode = responseData['referral_code'].toString();
        yesterdayTotalCommission = responseData['yesterday_total_commission'].toString();
        totalSubordinate = responseData['direct_subordinate'].toString();
        totalSubordinateInTeam = responseData['team_subordinate'].toString();
        today_withdraw = responseData['today_withdraw'];
        total_withdraw = responseData['total_withdraw'];
        today_salary = responseData['today_salary'];
        total_salary = responseData['total_salary'];

      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        // attendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

  dynamic map;
  dynamic versionlink;

  Future<void> versionCheck() async {

    context.read<ProfileProvider>().fetchProfileData();
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print('rrrrrrrr');

      }
      if (responseData['version'] != AppConstants.appVersion) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview=true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }


}
class AllTierData {
  final int userId;
  final String username;
  final dynamic turnover;
  final dynamic commission;
  final dynamic uid;
  final dynamic depositAmount;
  final String type;

  AllTierData({
    required this.userId,
    required this.username,
    required this.turnover,
    required this.commission,
    required this.uid,
    required this.depositAmount,
    required this.type,
  });
}