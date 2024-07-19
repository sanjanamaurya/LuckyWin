// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/auth/login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool selectedButton = true;
  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  bool rememberPass = false;

  // bool activeButton = true;
  TextEditingController phoneCon = TextEditingController();
  TextEditingController newPasswordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  bool isOtpVerified = false;
  bool isOtpSend = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          centerTitle: true,
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
          // leading: const AppBackBtn(),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration:
                  const BoxDecoration(gradient: AppColors.primaryGradient),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: textWidget(
                            text: 'Forget Password',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: AppColors.white),
                      ),

                      subtitle: textWidget(
                          text: 'Please retrieve/change your password through your mobile phone number or email',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                !isOtpVerified
                    ? sendOtp(forgetUpdateUser)
                    : createNewPassword(forgetUpdateUser),
              ],
            ),
          ),
        ),
      ),
    );
  }

  otpSent(String mobile) async {
    final response = await http.get(
        // Uri.parse('${ApiUrl.sendotp}mobile=$mobile')
      Uri.parse('https://otp.hopegamings.in/send_otp.php?mode=live&digit=4&mobile=$mobile'),
    );
    if (response.statusCode == 200) {
      setState(() {
        isOtpSend = true;
      });
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  Widget sendOtp(apiName) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Row(
            children: [
              Image.asset(Assets.iconsPhone,scale: 1.5),
              const SizedBox(width: 20),
              textWidget(
                  text: 'Phone Number',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.primaryTextColor)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: CustomTextField(
            onChanged: (value) {
              if (phoneCon.text.length == 10) {}
            },
            keyboardType: TextInputType.number,
            controller: phoneCon,
            maxLength: 10,
            hintText: 'Enter Mobile number',
          ),
        ),
        if (isOtpSend) Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: CustomTextField(
            controller: verifyCode,
            prefixIcon: const Icon(
              Icons.verified_user,
              color: Colors.red,
            ),
            maxLines: 1,
            hintText: 'Verification code',
            onChanged: (v) async {
              if(v.length==4){
                final response = await http.get(
                    // Uri.parse('${ApiUrl.verifyotp}mobile=${phoneCon.text}&otp=${verifyCode.text}')
                    Uri.parse('https://otp.hopegamings.in/verifyotp.php?mobile=${phoneCon.text}&otp=${verifyCode.text}')

                );
                var data = jsonDecode(response.body);
                if(data["status"]=="200"){
                  Utils.flushBarSuccessMessage(data["message"], context, Colors.white);
                } else if (data["status"]=="400") {
                  Utils.flushBarSuccessMessage("Wrong Otp", context, Colors.red);
                }
                else {
                  setState(() {
                    isOtpVerified=true;
                  });
                  forgetUpdateUser( context,phoneCon.text, newPasswordCon.text,confirmPasswordCon.text);
                }
              }else{
                if (kDebugMode) {
                  print("not done");
                }
              }
            },
          ),
        ) else const SizedBox(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: AppBtn(
            onTap: () {
              if (phoneCon.text.isEmpty || phoneCon.text.length != 10) {
                 Utils.flushBarErrorMessage("Enter phone number", context, Colors.white);
              } else if (phoneCon.text.isNotEmpty && phoneCon.text.length == 10){
                  otpSent(phoneCon.text);
              }
              },
            title: "Send Otp",
          ),
        ),
        const SizedBox(height: 5,),
      ],

    );
  }

  Widget createNewPassword(apiName) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                color: Colors.red,
              ),
              const SizedBox(width: 20),
              textWidget(
                  text: 'Phone Number',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.primaryTextColor)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: CustomTextField(
            controller: phoneCon,
            maxLines: 1,
            hintText: 'Phone number',

          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                color: Colors.red,
              ),
              const SizedBox(width: 20),
              textWidget(
                  text: 'New Password',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.primaryTextColor)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: CustomTextField(
            obscureText: hideSetPassword,
            controller: newPasswordCon,
            maxLines: 1,
            hintText: 'New password',
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hideSetPassword = !hideSetPassword;
                  });
                },
                icon: Image.asset(hideSetPassword
                    ? Assets.iconsEyeClose
                    : Assets.iconsEyeOpen)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                color: Colors.red,
              ),
              const SizedBox(width: 20),
              textWidget(
                  text: 'Confirm New Password',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.primaryTextColor)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: CustomTextField(
            obscureText: hideConfirmPassword,
            controller: confirmPasswordCon,
            maxLines: 1,
            hintText: 'Confirm New Password',

            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hideConfirmPassword = !hideConfirmPassword;
                  });
                },
                icon: Image.asset(hideConfirmPassword
                    ? Assets.iconsEyeClose
                    : Assets.iconsEyeOpen)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: AppBtn(
              title: 'Reset',
              fontSize: 20,
              onTap: () async {

                if (phoneCon.text.isEmpty || phoneCon.text.length != 10) {
                  Utils.flushBarSuccessMessage("Enter phone number", context, Colors.red);
                } else if (newPasswordCon.text.isEmpty) {
                  Utils.flushBarSuccessMessage("Set your password", context, Colors.red);
                } else if (confirmPasswordCon.text.isEmpty) {
                  Utils.flushBarSuccessMessage("Confirm your password", context, Colors.red);
                } else {
                  forgetUpdateUser( context,phoneCon.text, newPasswordCon.text,confirmPasswordCon.text);
                  if (kDebugMode) {
                    print(phoneCon.text);
                    print(confirmPasswordCon.text);
                    print(newPasswordCon.text);
                  }
                }
              },
              hideBorder: true,
              gradient: AppColors.primaryGradient),
        ),
      ],
    );
  }

  forgetUpdateUser(context,String mobile, String password, String newPassword) async {
    if (kDebugMode) {
      print("guycyg");
    }
    final response = await http.post(Uri.parse(ApiUrl.forgetPasswordUrl),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic >{
          "mobile":mobile,
          "password":password,
          "confirm_password":newPassword
        })
    );
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
      print("👍👍👍👍updatee");
    }
    if(data["status"]==200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      Utils.flushBarSuccessMessage(data["message"], context, Colors.white);
    }
    else {
      Utils.flushBarErrorMessage(data["message"], context, Colors.white);
    }
  }
}