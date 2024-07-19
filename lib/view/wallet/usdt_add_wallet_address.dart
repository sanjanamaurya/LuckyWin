import 'dart:convert';

import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

class AddUsdtBankAccount extends StatefulWidget {
  const AddUsdtBankAccount({super.key});

  @override
  State<AddUsdtBankAccount> createState() => _AddUsdtBankAccountState();
}

class _AddUsdtBankAccountState extends State<AddUsdtBankAccount> {
  TextEditingController usdtWalletAdd=TextEditingController();
  TextEditingController nameCon=TextEditingController();



  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Add USDT wallet address',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white),
          gradient: AppColors.primaryUnselectedGradient),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  height: height*0.08,
                  padding: const EdgeInsets.only(left: 5, right: 5,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                      gradient: AppColors.primaryUnselectedGradient,
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: Row(
                    children: [
                      Image.asset(Assets.iconsAttention,color: Colors.white,height: height*0.05,),
                      textWidget(
                          text: 'Need to add beneficiary information to be able to \nwithdraw money',
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ],
                  )

              ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsPeople,"Full recipient's name"),
              const SizedBox(height: 15),
              CustomTextField(
                  controller: nameCon,
                  cursorColor: AppColors.secondaryTextColor,
                  hintText: "Please enter the recipient's name",
                  style: const TextStyle(color: AppColors.primaryTextColor),
                  hintColor: AppColors.primaryTextColor
              ),


              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber,'USDT wallet address'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: usdtWalletAdd,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your wallet address.',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor,
              ),



              const SizedBox(height: 15),
              AppBtn(
                onTap: () async {
                  usdtAccountView( nameCon.text, usdtWalletAdd.text,);
                },
                title: 'S a v e',
                fontSize: 22,
                hideBorder: true,
                fontWeight: FontWeight.w900,
                gradient: AppColors.primaryGradient,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();
  Widget titleWidget(String image,String title){
    return Row(
      children: [
        Image.asset(image ,height: 30,),
        const SizedBox(width: 10),
        textWidget(
            text:
            title,
            fontSize: 18,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w600),
      ],
    );
  }
  usdtAccountView(String name, String walletAddress) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.addUSDTAccount),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {
            "user_id": token,
            "name":name,
            "usdt_wallet_address":walletAddress,
          }),
    );
    if (response.statusCode == 200) {
      print(response);
      print("rrrrrrrrrr");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("nnnnnnnnn");


      Navigator.pushReplacementNamed(context,  RoutesName.withdrawScreen);
      return Fluttertoast.showToast(msg: responseData['message']);
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }

}
