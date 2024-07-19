import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/circular_percent.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/wallet/deposit_history.dart';
import 'package:theluckywin/view/wallet/deposit_screen.dart';
import 'package:theluckywin/view/wallet/withdraw_screen.dart';
import 'package:theluckywin/view/wallet/withdrawal_history.dart';
import 'package:http/http.dart' as http;

class WalletScreenNew extends StatefulWidget {
  const WalletScreenNew({super.key});

  @override
  State<WalletScreenNew> createState() => _WalletScreenNewState();
}

class _WalletScreenNewState extends State<WalletScreenNew> {


  @override
  Widget build(BuildContext context) {
    final userData = context.watch<ProfileProvider>();



    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: const GradientAppBar(
          title: Text(
            'Wallet',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.25,
                width: width,
                decoration:
                    const BoxDecoration(gradient: AppColors.primaryGradient),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.iconsProWallet,
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.currency_rupee,
                            size: 30, color: AppColors.white),
                        textWidget(
                          text:context.watch<ProfileProvider>().totalWallet.toStringAsFixed(2),
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                    textWidget(
                        text: 'Total Balance',
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.22,bottom: 30),
                  child: Container(
                    height: height * 0.62,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            percentage(
                              //main wallet/totalbalance*0.01
                                (userData.mainWallet/(userData.totalWallet*0.01)).toStringAsFixed(2),

                           userData.mainWallet==null?0: userData.mainWallet.toStringAsFixed(2),
                                'Main wallet'),
                            percentage(
                              //thirdpartywallet/totalbalance*0.01
                                (userData.thirdPartyWallet/(userData.totalWallet*0.01)).toStringAsFixed(2),
                                userData.thirdPartyWallet==null?0: userData.thirdPartyWallet.toStringAsFixed(2),
                                '3rd party wallet'),
                          ],
                        ),
                        SizedBox(height:height*0.05 ,),
                        AppBtn(
                          height:height*0.07 ,
                            title: 'Main wallet transfer',
                            fontSize: 17,
                            onTap: () {
                              mainWalletTransfer();
                            },
                            hideBorder: true,
                            gradient: AppColors.loginSecondryGrad),
                        SizedBox(height:height*0.05 ,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            groups(Assets.iconsProDeposit,'Deposit', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositScreen()));
                            },),
                            groups(Assets.iconsProWithdraw,'Withdrawal', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawScreen()));

                            },),
                            groups(Assets.iconsRechargeHistory,'Deposit\n history', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositHistory()));
                            },),
                            groups(Assets.iconsWithdrawHistory,'Withdrawal\n     history', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawHistory()));

                            },),

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
      )
    );

  }



  BaseApiHelper baseApiHelper = BaseApiHelper();

  UserViewProvider userProvider = UserViewProvider();
  mainWalletTransfer() async {

    print("fyusfxief");
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.mainWalletTransfer),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("data");
    if (data["status"] == 200) {
      context.read<ProfileProvider>().fetchProfileData();
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  groups(String img,String title,VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
                      children: [
                        Container(
                            height:height*0.08,
                          width: width*0.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.scaffolddark,
                          ),
                          child: Center(
                            child: Image.asset( img,
                              height: 40,),
                          ),
                          //color: Colors.white,
                        ),
                        const SizedBox(height: 8,),
                        textWidget(
                            text: title,
                            color: AppColors.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
    );
  }
  Widget percentage(String percentData, String amount, String title) {
    // Ensure percentData can be parsed to a double
    double? percentage;
    try {
      percentage = double.parse(percentData) / 100;
    } catch (e) {
      percentage = 0;
    }

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1200,
          lineWidth: 10.0,
          startAngle: 8.0,
          radius: 120,
          circularStrokeCap: CircularStrokeCap.round,
          linearGradient: AppColors.loginSecondryGrad,
          percent: percentage.isNaN ? 0 : percentage,
          center: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: textWidget(
              text: percentage.isNaN ? "0.00%" : '${(percentage * 100).toStringAsFixed(2)}%',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.currency_rupee,
              size: 16,
              color: AppColors.primaryTextColor,
            ),
            textWidget(
              text: amount,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: AppColors.primaryTextColor,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        textWidget(
          text: title,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black,
        ),
      ],
    );
  }
}
