import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/auth_provider.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/account/service_center/custmor_service.dart';
import 'package:theluckywin/view/auth/forget_password_otp.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  bool selectedButton = true;
  bool hidePassword = true;
  bool rememberPass = false;
  // bool activeButton = true;
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController passwordConn = TextEditingController();

  final FocusNode _focusNodephone = FocusNode();
  final FocusNode _focusNodepass = FocusNode();

  /// Check internet
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _focusNodephone.dispose();
    _focusNodepass.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    bool shouldExit = await Utils.showExitConfirmation(context) ?? false;
    return shouldExit;
  }

  void _unfocusAll() {
    _focusNodephone.unfocus();
    _focusNodepass.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: _unfocusAll,
        child: Scaffold(
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
          body:
          _connectionStatus == ConnectivityResult.none
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: const AssetImage(Assets.imagesNoDataAvailable),
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('There is no Internet connection'),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child:
                Text('Please check your Internet connection'),
              ),
            ],
          )
              : ScrollConfiguration(
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
                                text: 'Log in',
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: AppColors.scaffolddark),
                          ),
                          subtitle: textWidget(
                              text: 'Please log in with your phone number or email\nIf you forget your password, please contact customer service',
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: AppColors.scaffolddark),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = !selectedButton;
                              // activeButton = !activeButton;
                            });
                          },
                          child: Container(
                            height: 90,
                            width: width / 2 , // Adjust width dynamically
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedButton = !selectedButton;
                                    // activeButton = !activeButton;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    selectedButton
                                        ? Image.asset(Assets.iconsPhoneTabColor, scale: 1.5,color: Color(0xff4287ff),)
                                        : Image.asset(Assets.iconsPhoneTab, scale: 1.5,color: Colors.grey,),
                                    textWidget(
                                      text: 'Log in with phone',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: selectedButton
                                          ? Color(0xff4287ff)
                                          : Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = !selectedButton;
                              // activeButton = !activeButton;
                            });
                          },
                          child: Container(
                            height: 90,
                            width: width / 2 , // Adjust width dynamically
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !selectedButton
                                    ? Image.asset(Assets.iconsEmailTabColor, scale: 1.5,color: Color(0xff4287ff),)
                                    : Image.asset(Assets.iconsEmailTab, scale: 1.5,color: Colors.grey),
                                textWidget(
                                  text: 'Email Login',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: !selectedButton
                                      ? Color(0xff4287ff)
                                      : Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        children: [
                          Image.asset(selectedButton
                              ? Assets.iconsPhone
                              : Assets.iconsEmailTab, scale: 1.5,),
                          const SizedBox(width: 20),
                          textWidget(
                              text: selectedButton ? 'Phone Number' : 'Mail',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.primaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: selectedButton
                          ? Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: CustomTextField(
                              enabled: false,
                              hintText: '+91',
                              hintColor: Colors.black,
                              suffixIcon: RotatedBox(
                                  quarterTurns: 45,
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                    size: 20, color: Colors.white,)),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: CustomTextField(
                                focusNode: _focusNodephone,
                                onChanged: (value) {
                                  if (phoneCon.text.length == 10) {
                                    // setState(() {
                                    //   activeButton = !activeButton;
                                    // });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: phoneCon,
                                maxLength: 10,
                                hintText: 'Please enter the phone number',
                              )),
                        ],
                      )
                          : CustomTextField(
                        focusNode: _focusNodephone,
                        onChanged: (value) {
                          if (emailCon.text.isNotEmpty) {
                            // setState(() {
                            //   activeButton = !activeButton;
                            // });
                          }
                        },
                        controller: emailCon,
                        maxLines: 1,
                        hintText: 'please input your email',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        children: [
                          Image.asset(Assets.iconsPassword, scale: 1.5,),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.primaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: CustomTextField(
                        focusNode: _focusNodepass,
                        obscureText: hidePassword,
                        controller: passwordCon,
                        maxLines: 1,
                        hintText: 'Please enter Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Image.asset(hidePassword
                                ? Assets.iconsEyeClose
                                : Assets.iconsEyeOpen, scale: 1.5,)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                rememberPass = !rememberPass;
                              });
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                decoration: rememberPass ? BoxDecoration(
                                  color: AppColors.gradientFirstColor,
                                  border: Border.all(
                                      color: AppColors.secondaryTextColor),
                                  borderRadius: BorderRadiusDirectional.circular(50),
                                )
                                    : BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.secondaryTextColor),
                                  borderRadius: BorderRadiusDirectional.circular(50),
                                ),
                                child: rememberPass ? const Icon(Icons.check, color: Colors.white,) : null
                            ),
                          ),
                          const SizedBox(width: 20),
                          textWidget(text: 'Remember password', fontSize: 14, color: AppColors.primaryTextColor),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: AppBtn(
                          loading: authProvider.loading,
                          title: 'Log in',
                          fontSize: 20,
                          onTap: () {
                            _unfocusAll();
                            if (selectedButton == true) {
                              if (kDebugMode) {
                                print("object");
                              }
                              authProvider.userLogin(context, phoneCon.text, passwordCon.text);
                            } else {
                              authProvider.userLogin(context, emailCon.text, passwordCon.text);
                            }
                          },
                          hideBorder: true,
                          gradient: AppColors.primaryGradient
                        // gradient: activeButton
                        //     ? AppColors.primaryGradient
                        //     : AppColors.inactiveGradient,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: AppBtn(
                        title: 'R e g i s t e r',
                        fontSize: 20,
                        titleColor: Color(0xff4287ff),
                        border: Border.all(color: Color(0xff4287ff)),
                        hideBorder: false,
                        onTap: () {
                          _unfocusAll();
                          Navigator.pushNamed(context, RoutesName.registerScreenOtp, arguments: '1');
                        },
                        gradient: AppColors.whitegradient,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _unfocusAll();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
                            },
                            child: Column(
                              children: [
                                Image.asset(Assets.iconsPassword, height: 50),
                                textWidget(
                                    text: 'Forgot password',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.primaryTextColor)
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _unfocusAll();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerCareService()));
                            },
                            child: Column(
                              children: [
                                Image.asset(Assets.iconsCustomer, height: 50),
                                textWidget(
                                    text: 'Customer Service',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.primaryTextColor)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
