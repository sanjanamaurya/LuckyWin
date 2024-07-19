import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/plinko/test.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/addacount_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  TextEditingController accNumberCon=TextEditingController();
  TextEditingController nameCon=TextEditingController();
  TextEditingController ifscCon=TextEditingController();
  TextEditingController banknameCon=TextEditingController();
  TextEditingController branchnameCon=TextEditingController();

  @override


  Widget build(BuildContext context) {

    final authProvider = Provider.of<AddacountProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Add a bank account number',
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
                      Image.asset(Assets.iconsAttention,color:Colors.white,height: height*0.05,),
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
              titleWidget(Assets.iconsBank,'Bank name'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: banknameCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your bank name ',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor

              ),

              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber,'Bank account number'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: accNumberCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your bank account no.',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor,
              ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber,'Bank branch'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: branchnameCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your branch name ',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor
              ),

              const SizedBox(height: 15),
              titleWidget(Assets.iconsIfscCode,'IFSC code'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: ifscCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter IFSC code',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor
              ),
              const SizedBox(height: 15),
              AppBtn(
                onTap: () async {
                  authProvider.Addacount(context, nameCon.text,banknameCon.text, accNumberCon.text, branchnameCon.text, ifscCon.text);
                },
                title: 'S a v e',
                fontSize: 22,
                hideBorder: true,
                fontWeight: FontWeight.w900,
                gradient: AppColors.buttonGradient2,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
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

}
