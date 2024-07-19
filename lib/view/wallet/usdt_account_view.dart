import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/usdt_account_view_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/view/wallet/usdt_add_wallet_address.dart';

class UsdtAccountView extends StatefulWidget {

  final UsdtAccountViewModel data;
   const UsdtAccountView({super.key,required this.data});
  @override
  State<UsdtAccountView> createState() => _UsdtAccountViewState();
}

class _UsdtAccountViewState extends State<UsdtAccountView> {
  @override
  Widget build(BuildContext context) {
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
              text: 'Bank account',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.primaryTextColor,),

            gradient: AppColors.primaryUnselectedGradient),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: height*0.01,),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: AppColors.primaryUnselectedGradient,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: height*0.06,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                          gradient: AppColors.loginSecondryGrad,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                        child: Container(
                          height: height*0.07,
                          color: AppColors.filledColor,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width*0.45,
                                child:  textWidget(text: "   Name",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                              ),
                              Container(
                                child:  textWidget(text: widget.data.name.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                              ),
                            ],
                          ),),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                        child: Container(
                          height: height*0.07,
                          color: AppColors.filledColor,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width*0.40,
                                child:  textWidget(text: "   Wallet Address",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                              ),
                              Container(
                                width: width*0.45,
                                child:  textWidget(text: widget.data.usdtWalletAddress.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                              ),
                            ],
                          ),),
                      ),
                      SizedBox(height: height*0.02,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.01,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddUsdtBankAccount()));
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    decoration: BoxDecoration(gradient: AppColors.primaryUnselectedGradient, borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Column(
                      children: [
                        const SizedBox(width: 15),
                        Image.asset(Assets.iconsAddBank,height: 60,),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Add USDT Wallet Address',
                            color: AppColors.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
