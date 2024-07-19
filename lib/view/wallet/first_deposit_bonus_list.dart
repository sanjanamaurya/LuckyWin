import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/extradepositmodel.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/components/theam_color.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/view/wallet/deposit_screen.dart';

class FirstDepositBonusList extends StatefulWidget {
  const FirstDepositBonusList({super.key});

  @override
  State<FirstDepositBonusList> createState() => _FirstDepositBonusListState();
}

class _FirstDepositBonusListState extends State<FirstDepositBonusList> {
  @override
  void initState() {
    extraDeposit();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: myCustomTheme.scaffoldBackgroundColor,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: Text(
            'First deposit bonus',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: myCustomTheme.appBarTheme.backgroundColor),
          ),
          centerTitle: true,
          gradient: AppColors.primaryGradient),
      body: ListView(
        children: [
          depositItems.isEmpty?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.grey,),
              const SizedBox(width: 10,),
              textWidget(
                  text: 'Loading.... ',
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ],
          ):
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: depositItems.length,
              itemBuilder: (context, index) {
                final data= depositItems[index];
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(8),

                  decoration: BoxDecoration(
                      color: AppColors.FirstColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          textWidget(
                              text: 'First deposit ',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          textWidget(
                              text: data.firstDepositAmount.toString(),
                              color: AppColors.constColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                          const Spacer(),
                          textWidget(
                              text: '+₹${data.bonus}',
                              color: AppColors.gradientFirstColor,
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
                            color: Colors.white),
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
                                color: Colors.grey.withOpacity(0.5),
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
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondaryContainerTextColor,width: 2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(  height: height*0.06,),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child:instruction('Exclusive for the first recharge of the account. There is only one chance. The more you recharge, the more rewards you will receive. The highest reward is ₹10,000.00;'),

                            );
                          }),
                    ],
                  ),
                ),
                Container(
                  height: height*0.06,
                  width: width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.iconsRulehead),fit: BoxFit.fill)
                  ),
                  child: const Center(
                    child: Text(
                      'Activity rules',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: AppColors.primaryTextColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();
  List<ExtraDepositModel> depositItems = [];
  int? responseStatuscode;
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
