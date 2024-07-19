import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/home/lottery/WinGo/pre_rules_commonbottomsheet.dart';
import 'package:theluckywin/view/home/lottery/WinGo/win_go_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class CommonBottomSheet extends StatefulWidget {
  final List<Color>? colors;
  final String colorName;
  final String predictionType;
  final int gameid;
  const CommonBottomSheet({
    super.key,
    this.colors,
    required this.colorName,
    required this.predictionType,
    required this.gameid,
  });

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  @override
  void initState() {

    amount.text = selectedIndex.toString();
    // TODO: implement initState
    super.initState();
  }
  int value = 1;
  int selectedAmount = 1;
  bool rememberPass = true;
  void increment() {
    setState(() {
      selectedMultiplier = selectedMultiplier + 1;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (selectedMultiplier > 0) {
        selectedMultiplier = selectedMultiplier - 1;
        deductAmount();
      }
    });
  }

  void selectam(int amount) {
    setState(() {
      selectedAmount = amount;
      value = 1;
    });
    deductAmount();
  }

  List<int> multipliers = [1, 5, 10, 20, 50, 100];
  int selectedMultiplier = 1; // Default multipli

  void updateMultiplier(int multiplier) {
    setState(() {
      selectedMultiplier = multiplier;
      deductAmount();
    });
  }

  void deductAmount() {
    if (wallbal! >= selectedAmount * selectedMultiplier) {
      walletApi = wallbal;
    }
    int amountToDeduct = selectedAmount * selectedMultiplier;
    if (walletApi! >= amountToDeduct) {
      setState(() {
        amount.text = amountToDeduct.toString();
        walletApi = (walletApi! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  List<int> list = [
    1,
    10,
    100,
    1000,
  ];

  int? walletApi;
  int? wallbal;

  int selectedIndex = 1;

  TextEditingController amount = TextEditingController();

  List<Winlist> listwe = [
    Winlist(1, "Win Go", "1 Min", 60),
    Winlist(2, "Win Go", "3 Min", 180),
    Winlist(3, "Win Go", "5 Min", 300),
    Winlist(4, "Win Go", "10 Min", 600),
    Winlist(6, "Trx Win Go", "1 Min", 60),
    Winlist(7, "Trx Win Go", "3 Min", 180),
    Winlist(8, "Trx Win Go", "5 Min", 300),
    Winlist(9, "Trx Win Go", "10 Min", 600),
  ];
  String gametitle = 'Wingo';
  String subtitle = '1 Min';
  @override
  Widget build(BuildContext context) {
    final userData = context.read<ProfileProvider>();

    walletApi = (userData.totalWallet == null
            ? 0
            : double.parse(userData.totalWallet.toString()))
        .toInt();
    wallbal = (userData.totalWallet == null
            ? 0
            : double.parse(userData.totalWallet.toString()))
        .toInt();


    LinearGradient gradient = LinearGradient(
        colors: widget.colors ?? [Colors.white, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.mirror);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: height * 0.59,
          width: width,
          child: Column(
            children: [
              Container(
                height: height * 0.05,
                width: width,
                decoration:  BoxDecoration(
                  color: widget.colors == null ? Colors.white : widget.colors!.first,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.gameid == 1
                      ? 'Win Go 1 Min'
                      : widget.gameid == 2
                          ? 'Win Go 3 Min'
                          : widget.gameid == 3
                              ? 'Win Go 5 Min'
                              :widget.gameid == 4?
                                "Win Go 10 Min"
                      :widget.gameid == 6?
                  " Trx Win Go 1 Min"
                      :widget.gameid == 7?
                  " Trx Win Go 3 Min"
                      :widget.gameid == 8?
                  "Trx Win Go 5 Min":
                  "Trx Win Go 10 Min",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                      width: width,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: widget.predictionType == "1"
                            ? ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return gradient.createShader(bounds);
                                },
                                blendMode: BlendMode.srcATop,
                                child: CustomPaint(
                                  painter: _InvertedTrianglePainterSingle(),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: width,
                                    child: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return gradient.createShader(bounds);
                                      },
                                      blendMode: BlendMode.srcATop,
                                      child: CustomPaint(
                                        painter:
                                            _InvertedTrianglePainterSingle(),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 35,
                                    bottom: 65,
                                    child: Transform.rotate(
                                      angle: -0.18,
                                      child: SizedBox(
                                        height: 200,
                                        width: width,
                                        child: CustomPaint(
                                          painter:
                                              _InvertedTrianglePainterDouble(
                                                  widget.colors),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select :  ${widget.colorName}",
                        style:
                            const TextStyle(color: Colors.white,fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 0, 5),
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "Balance",
                               style: TextStyle(fontSize: 18,color: AppColors.darkcolor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: width,
                              height: 30,
                              child: Center(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (BuildContext, int index) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = list[index];
                                            });
                                            selectam(selectedIndex);
                                          },
                                          child: Container(
                                              width: width*0.2,
                                              decoration: BoxDecoration(
                                                  color: selectedIndex == list[index] ? widget.colors![0] : Color(0xFFeeeeee),
                                                  ),
                                              margin:
                                                  const EdgeInsets.only(right: 5),
                                              padding: const EdgeInsets.all(5),
                                              child: Center(
                                                child: Text(
                                                  list[index].toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color: selectedIndex == list[index] ?Colors.white:Colors.black),
                                                ),
                                              )));
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(// import 'dart:async';
// import 'package:digitalClub/utils/utils.dart';
// import 'package:digitalClub/view/account/service_center/custmor_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:digitalClub/generated/assets.dart';
// import 'package:digitalClub/main.dart';
// import 'package:digitalClub/res/aap_colors.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:digitalClub/res/components/app_bar.dart';
// import 'package:digitalClub/res/components/app_btn.dart';
// import 'package:digitalClub/res/components/text_field.dart';
// import 'package:digitalClub/res/components/text_widget.dart';
// import 'package:digitalClub/res/provider/auth_provider.dart';
// import 'package:digitalClub/utils/routes/routes_name.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   bool selectedButton = true;
//   bool hidePassword = true;
//   bool rememberPass = false;
//   // bool activeButton = true;
//   TextEditingController phoneCon = TextEditingController();
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passwordCon = TextEditingController();
//   TextEditingController passwordConn = TextEditingController();
//
//   final FocusNode _focusNodephone = FocusNode();
//   final FocusNode _focusNodepass = FocusNode();
//
//   /// Check internet
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       // ignore: avoid_print
//       print(e.toString());
//       return;
//     }
//
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//   }
//   bool change = false;
//
//   void checkInputs() {
//     setState(() {
//       change = phoneCon.text.length == 10 &&
//           passwordCon.text.isNotEmpty;
//
//
//     });
//   }
//   void checkInputsNew() {
//     setState(() {
//       change = emailCon.text.isNotEmpty &&
//           passwordConn.text.isNotEmpty;
//
//
//     });
//   }
//
//
//   @override
//   void initState() {
//     initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged
//             .listen(_updateConnectionStatus);
//     super.initState();
//     phoneCon.addListener(checkInputs);
//     passwordCon.addListener(checkInputs);
//     passwordConn.addListener(checkInputsNew);
//     emailCon.addListener(checkInputsNew);
//   }
//
//   @override
//   void dispose() {
//     _focusNodephone.dispose();
//     _focusNodepass.dispose();
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }
//
//   Future<bool> _onWillPop() async {
//     bool shouldExit = await Utils.showExitConfirmation(context) ?? false;
//     return shouldExit;
//   }
//
//   void _unfocusAll() {
//     _focusNodephone.unfocus();
//     _focusNodepass.unfocus();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<UserAuthProvider>(context);
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: GestureDetector(
//         onTap: _unfocusAll,
//         child: Scaffold(
//           backgroundColor: AppColors.scaffolddark,
//           appBar: GradientAppBar(
//             centerTitle: true,
//               title: Image.asset(
//                 Assets.imagesAppBarSecond,
//                 height: height*0.045,
//                 width: width*0.45,
//
//               ),
//              // leading: const AppBackBtn(),
//               gradient: AppColors.primaryUnselectedGradient),
//           body:
//           _connectionStatus == ConnectivityResult.none
//               ?Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Image(
//                   image: const AssetImage(Assets.imagesNoDataAvailable),
//                   height: MediaQuery.of(context).size.height / 3,
//                   width: MediaQuery.of(context).size.width / 2,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(4.0),
//                 child: Text('There is no Internet connection'),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(4.0),
//                 child:
//                 Text('Please check your Internet connection'),
//               ),
//             ],
//           ):
//
//           ScrollConfiguration(
//             behavior: const ScrollBehavior().copyWith(overscroll: false),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration:
//                       const BoxDecoration(gradient: AppColors.primaryGradient),
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 18.0),
//                         child: ListTile(
//                           title: Padding(
//                             padding: const EdgeInsets.only(bottom: 18.0),
//                             child: textWidget(
//                                 text: 'Log in',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 22,
//                                 color: AppColors.primaryTextColor),
//                           ),
//
//                           subtitle: textWidget(
//                               text: 'Please log in with your phone number or email\nIf you forget your password, please contact customer service',
//                               fontWeight: FontWeight.w600,
//                               fontSize: 10,
//                               color: AppColors.primaryTextColor),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               selectedButton = !selectedButton;
//                               // activeButton = !activeButton;
//                             });
//                           },
//                           child: Container(
//                             height: 90,
//                             width: width/ 2 , // Adjust width dynamically
//                             decoration: BoxDecoration(
//                               gradient: selectedButton
//                                   ? AppColors.loginSecondryGrad
//                                   : AppColors.primaryUnselectedGradient,
//                             ),
//                             child: Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedButton = !selectedButton;
//                                     // activeButton = !activeButton;
//                                   });
//                                 },
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     selectedButton
//                                         ? Image.asset(Assets.iconsPhoneTabColor, scale: 1.5,)
//                                         : Image.asset(Assets.iconsPhoneTab, scale: 1.5,),
//                                     textWidget(
//                                       text: 'Log in with phone',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                       color: selectedButton
//                                           ? AppColors.primaryTextColor
//                                           : AppColors.secondaryTextColor,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               selectedButton = !selectedButton;
//                               // activeButton = !activeButton;
//                             });
//                           },
//                           child: Container(
//                             height: 90,
//                             width: width/ 2 , // Adjust width dynamically
//                             decoration: BoxDecoration(
//                               gradient: !selectedButton
//                                   ? AppColors.loginSecondryGrad
//                                   : AppColors.primaryUnselectedGradient,
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 !selectedButton
//                                     ? Image.asset(Assets.iconsEmailTabColor, scale: 1.5,)
//                                     : Image.asset(Assets.iconsEmailTab, scale: 1.5,),
//                                 textWidget(
//                                   text: 'Email Login',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: !selectedButton
//                                       ? AppColors.primaryTextColor
//                                       : AppColors.secondaryTextColor,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: Row(
//                         children: [
//                           Image.asset(selectedButton
//
//                               ? Assets.iconsPhone
//                               : Assets.iconsEmailTab,scale: 1.5,),
//                           const SizedBox(width: 20),
//                           textWidget(
//                               text: selectedButton ? 'Phone Number' : 'Mail',
//                               fontWeight: FontWeight.w400,
//                               fontSize: 18,
//                               color: AppColors.primaryTextColor)
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: selectedButton
//                           ? Row(
//                         children: [
//                           const SizedBox(
//                             width: 100,
//                             child: CustomTextField(
//                               enabled: false,
//                               hintText: '+91',
//                               hintColor: Colors.white,
//                               suffixIcon: RotatedBox(
//                                   quarterTurns: 45,
//                                   child: Icon(Icons.arrow_forward_ios_outlined,
//                                       size: 20,color: Colors.white,)),
//                             ),
//                           ),
//                           const SizedBox(width: 15),
//                           Expanded(
//                               child: CustomTextField(
//                                 focusNode: _focusNodephone,
//                                 onChanged: (value) {
//                                   if (phoneCon.text.length == 10) {
//                                     // setState(() {
//                                     //   activeButton = !activeButton;
//                                     // });
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: phoneCon,
//                                 maxLength: 10,
//                                 hintText: 'Please enter the phone number',
//                               )),
//                         ],
//                       )
//                           : CustomTextField(
//                         focusNode: _focusNodephone,
//                         onChanged: (value) {
//                           if (emailCon.text.isNotEmpty) {
//                             // setState(() {
//                             //   activeButton = !activeButton;
//                             // });
//                           }
//                         },
//                         controller: emailCon,
//                         maxLines: 1,
//                         hintText: 'please input your email',
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: Row(
//                         children: [
//                           Image.asset(Assets.iconsPassword,scale: 1.5,),
//                           const SizedBox(width: 20),
//                           textWidget(
//                               text: 'Password',
//                               fontWeight: FontWeight.w400,
//                               fontSize: 18,
//                               color: AppColors.primaryTextColor)
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: CustomTextField(
//                         focusNode: _focusNodepass,
//                         obscureText: hidePassword,
//                         controller: passwordCon,
//                         maxLines: 1,
//                         hintText: 'Please enter Password',
//                         suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 hidePassword = !hidePassword;
//                               });
//                             },
//                             icon: Image.asset(hidePassword
//                                 ? Assets.iconsEyeClose
//                                 : Assets.iconsEyeOpen,scale: 1.5,)),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 rememberPass = !rememberPass;
//                               });
//                             },
//                             child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 alignment: Alignment.center,
//                                 decoration: rememberPass ?BoxDecoration(
//                                   color: AppColors.gradientFirstColor,
//                                   border: Border.all(
//                                       color: AppColors.secondaryTextColor),
//
//                                   borderRadius: BorderRadiusDirectional.circular(50),
//
//                                 )
//                                     :BoxDecoration(
//                                   border: Border.all(
//                                       color: AppColors.secondaryTextColor),
//                                   borderRadius: BorderRadiusDirectional.circular(50),
//                                 ),
//                                 child: rememberPass ?const Icon(Icons.check,color: Colors.white,):null
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           textWidget(text: 'Remember password', fontSize: 14, color: AppColors.primaryTextColor),
//                         ],
//                       ),
//                     ),
//                     change==true?
//                     Padding(
//                       padding:  const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: AppBtn(
//                           loading: authProvider.loading,
//                           title: 'Log in',
//                           fontSize: 20,
//                           onTap: () {
//                             if (selectedButton==true) {
//                               if (kDebugMode) {
//                                 print("object");
//                               }
//                               authProvider.userLogin(context, phoneCon.text, passwordCon.text);
//                             } else {
//                               authProvider.userLogin(context, emailCon.text, passwordCon.text);
//                             }
//
//                           },
//                           hideBorder: true,
//                           gradient: AppColors.btnGREENGradient
//                         // gradient: activeButton
//                         //     ? AppColors.primaryGradient
//                         //     : AppColors.inactiveGradient,
//                       ),
//                     ):
//                     Padding(
//                       padding:  const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: AppBtn(
//                           loading: authProvider.loading,
//                           title: 'Log in',
//                           fontSize: 20,
//                           onTap: () {
//                             _unfocusAll();
//                             if (selectedButton==true) {
//                               if (kDebugMode) {
//                                 print("object");
//                               }
//                               authProvider.userLogin(context, phoneCon.text, passwordCon.text);
//                             } else {
//                               authProvider.userLogin(context, emailCon.text, passwordCon.text);
//                             }
//
//                           },
//                           hideBorder: true,
//                           gradient: AppColors.buttonGradient
//                         // gradient: activeButton
//                         //     ? AppColors.primaryGradient
//                         //     : AppColors.inactiveGradient,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
//                       child: AppBtn(
//                         title: 'R e g i s t e r',
//                         fontSize: 20,
//                         titleColor: AppColors.gradientFirstColor,
//                         onTap: () {
//                           _unfocusAll();
//                           Navigator.pushNamed(context, RoutesName.registerScreen,arguments: '1');
//                         },
//                         gradient: AppColors.secondaryGradient,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               _unfocusAll();
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomerCareService()));
//                             },
//                             child: Column(
//                               children: [
//                                 Image.asset(Assets.iconsPassword, height: 50),
//                                 textWidget(
//                                     text: 'Forgot password',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                     color:AppColors.primaryTextColor)
//                               ],
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               _unfocusAll();
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomerCareService()));
//
//                             },
//                             child: Column(
//                               children: [
//                                 Image.asset(Assets.iconsCustomer, height: 50),
//                                 textWidget(
//                                     text: 'Customer Service',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16,
//                                     color: AppColors.primaryTextColor)
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   String email="techcmh@gmail.com";
//   _launchEmail() async {
//     if (await canLaunch("mailto:$email")) {
//       await launch("mailto:$email");
//     } else {
//       throw 'Could not launch';
//     }
//   }
//
//
//
// }
                        padding: const EdgeInsets.fromLTRB(25, 15, 18, 5),
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Quantity",
                              style: TextStyle(fontSize: 18,color: AppColors.darkcolor),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: decrement,
                                    child: Icon(Icons.remove_circle,color:widget.colors == null ? Colors.white :widget.colors!.first,size: 35,),
                                  ),
                                  Container(
                                      height: 35,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(4),
                                      width: 75,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),

                                      ),
                                      child:  TextField(
                                        controller: amount,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 18, color: Colors.black),
                                      )
                                  ),
                                  InkWell(
                                    onTap: increment,
                                    child: Icon(Icons.add_circle,color:widget.colors == null ? Colors.white :widget.colors!.first,size: 35,),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 35,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: multipliers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedMultiplier = multipliers[index];
                            });
                            updateMultiplier(selectedMultiplier);
                          },
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: selectedMultiplier == multipliers[index] ? widget.colors![0] : Color(0xFFeeeeee),

                            ),
                            child: Center(
                              child: Text(
                        'X${multipliers[index]}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color:  selectedMultiplier == multipliers[index] ? Colors.white:Colors.black)
                      ),
                            ),

                          ),
                        )

                        );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
               Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
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
                        decoration: rememberPass ?BoxDecoration(
                            color:widget.colors == null ? Colors.white :widget.colors!.first,
                          border: Border.all(
                              color: widget.colors == null ? Colors.white :widget.colors!.first
                          ),

                          borderRadius: BorderRadiusDirectional.circular(50),

                        )
                            :BoxDecoration(
                          border: Border.all(
                              color:widget.colors == null ? Colors.white :widget.colors!.first
                          ),
                          borderRadius: BorderRadiusDirectional.circular(50),
                        ),
                        child: rememberPass ?const Icon(Icons.check,color: Colors.white,):null
                    ),
                  ),
                  const Text(" I agree", style: TextStyle(color: Colors.black), ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (context)=>PreRules());
                    },
                    child: const Text(
                      "《Pre-sale rules》",
                      style: TextStyle( color: AppColors.gradientFirstColor),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        print('yyyybbbbbbbbbbb');
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.7),
                      width: width / 3,
                      height: 45,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                     Colorbet( amount.text,
                          widget.predictionType, widget.gameid.toString());

                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:widget.colors == null ? Colors.white :widget.colors!.first
                        ),
                        width: width / 1.5,
                        height: 45,
                        child: Text(
                          "Total amount ${amount.text}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();
  UserViewProvider userProvider = UserViewProvider();
   Colorbet( String amount, String number,String gameid) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(
      Uri.parse(ApiUrl.bettingApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String>{
        "userid":token,
        "game_id":gameid,
        "number":number,
        "amount":amount
      }),
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      context.read<ProfileProvider>().fetchProfileData();
      Navigator.pop(context);

      return Fluttertoast.showToast(msg: responseData['message']);
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }

}
class _InvertedTrianglePainterSingle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(size.width / -1.8, 0);
    path.lineTo(size.width * 1.5, 0);
    path.lineTo(size.width / 2, size.height / 2.8);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _InvertedTrianglePainterDouble extends CustomPainter {
  final List<Color>? color;

  _InvertedTrianglePainterDouble(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..color = color!.last
      ..style = PaintingStyle.fill;

    final Path path1 = Path();
    path1.moveTo(size.width / 5, -5);
    path1.lineTo(size.width * 15, 0);
    path1.lineTo(size.width / 2, size.height / 2.8);

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
