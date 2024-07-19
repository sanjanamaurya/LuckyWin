import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/view/account/service_center/custmor_service.dart';

class BindMailBoxScreen extends StatefulWidget {
  const BindMailBoxScreen({super.key});

  @override
  State<BindMailBoxScreen> createState() => _BindMailBoxScreenState();
}

class _BindMailBoxScreenState extends State<BindMailBoxScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailCon = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  bool showRow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        centerTitle: true,
          title: textWidget(text:'Bind mailBox',fontSize: 25,color: Colors.white),
          leading: const AppBackBtn(),
          gradient: AppColors.primaryUnselectedGradient ),
//iconsVerifySetting
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: height*0.08,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Row(
                  children: [
                    Image.asset(
                        Assets.iconsEmailTab,
                        height: height * 0.04),
                    const SizedBox(width: 20),
                    textWidget(
                        text:  'Mail',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: AppColors.primaryTextColor)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: CustomTextField(
                  controller: emailCon,
                  maxLines: 1,
                  hintText: 'please input your email',
                ),
              ),
              SizedBox(height: height*0.03,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.iconsMailveryfy,
                      height: height * 0.04,
                    ),
                    const SizedBox(width: 20),
                    textWidget(
                        text: 'Verification Code',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: AppColors.primaryTextColor)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: CustomTextField(
                  controller: verifyCode,
                  maxLines: 1,
                  hintText: 'Please Enter confirmation code',
                  suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        showRow = !showRow;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.03,
                        width: width * 0.23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: AppColors.btnBlueGradient,

                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.03,),
              if (showRow) // Conditionally show the Row based on the value of showRow
                Row(
                  children: [
                    SizedBox(width: width * 0.06),
                    const Icon(Icons.info_outline, color: AppColors.dividerColor),
                    const Text(
                      ' Do not receive verification\ncode?',
                      style: TextStyle(
                        color: AppColors.dividerColor,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: width * 0.15),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomerCareService()));
                      },
                      child: const Text(
                        'Contact customer\nservice',
                        style: TextStyle(
                          color: AppColors.gradientFirstColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: AppBtn(
                  height: height * 0.08,
                  width: width * 0.9,
                  title: 'Bind',
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  onTap: () {},

                  hideBorder: true,
                  gradient: AppColors.loginSecondryGrad,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}