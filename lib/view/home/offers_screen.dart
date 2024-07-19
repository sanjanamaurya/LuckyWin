import 'dart:convert';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/extradepositmodel.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/view/wallet/deposit_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/view/wallet/first_deposit_bonus_list.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    extraDeposit();
    // TODO: implement initState
    super.initState();
  }

  bool loading = false;

  int? responseStatuscode;
  bool readAndAgreePolicy = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: height * 0.75,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.59,
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(15)),
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text(
                    'Extra first deposit bonus',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Text(
                    'Each account can only receive rewards once',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                      height: height * 0.4,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: depositItems.length,
                          itemBuilder: (context, index) {
                            final data= depositItems[index];
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                  color: AppColors.gamecolor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      textWidget(
                                          text: 'First deposit ',
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      textWidget(
                                          text: data.firstDepositAmount.toString(),
                                          color: AppColors.constColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      const Spacer(),
                                      textWidget(
                                          text: '+₹${data.bonus}',
                                          color: Colors.deepOrange,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: textWidget(
                                        text:
                                            'Deposit ${data.firstDepositAmount} for the first time and you will\nreceive ${data.bonus} bonus',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.4)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: height * 0.03,
                                        width: width * 0.35,
                                        decoration: BoxDecoration(
                                            gradient: AppColors.boxGradient,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: textWidget(
                                              text:  data.status==0?'${data.firstDepositAmount}/${data.firstDepositAmount}':'0/${data.firstDepositAmount}',
                                              fontWeight: FontWeight.w800,
                                               color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      data.status==0?
                                      InkWell(
                                        onTap: (){
                                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositScreen()));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: height * 0.04,
                                          width: width * 0.23,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: AppColors.btnColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: textWidget(
                                              text: 'claimed',
                                              fontWeight: FontWeight.w600,
                                              color:  AppColors.btnColor,
                                              fontSize: 15),
                                        ),
                                      ):
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositScreen()));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: height * 0.04,
                                          width: width * 0.23,
                                          decoration: BoxDecoration(
                                            border:
                                            Border.all(color: AppColors.iconsColor),
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: textWidget(
                                              text: 'Deposit',
                                              fontWeight: FontWeight.w600,
                                              color:  AppColors.gradientFirstColor,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
                  Container(
                    height: height * 0.09,
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       readAndAgreePolicy = !readAndAgreePolicy;
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 25,
                          //     width: 25,
                          //     alignment: Alignment.center,
                          //     decoration: readAndAgreePolicy
                          //         ? BoxDecoration(
                          //             // image: const DecorationImage(
                          //             //     image: AssetImage(Assets.)),
                          //             border: Border.all(
                          //                 color: AppColors.secondaryTextColor),
                          //             borderRadius:
                          //                 BorderRadiusDirectional.circular(50),
                          //           )
                          //         : BoxDecoration(
                          //             border: Border.all(
                          //                 color: AppColors.secondaryTextColor),
                          //             borderRadius:
                          //                 BorderRadiusDirectional.circular(50),
                          //           ),
                          //   ),
                          // ),
                          // const SizedBox(width: 5),
                          // textWidget(
                          //     text: 'No more reminders today',
                          //     fontSize: 11,
                          //     color: Colors.white),
                          Center(
                            child: AppBtn(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirstDepositBonusList()));
                              },
                              title: 'Activity',
                              width: width * 0.25,
                              height: height * 0.04,
                                hideBorder: true,
                                gradient: AppColors.primaryGradient
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();



  List<ExtraDepositModel> depositItems = [];

  Future<void> extraDeposit() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.extraDeposit+token),
    );
    if (kDebugMode) {
      print(ApiUrl.extraDeposit+token);
      print('extraDeposit');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        depositItems = responseData
            .map((item) => ExtraDepositModel.fromJson(item))
            .toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        depositItems = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
