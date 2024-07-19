import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/promotion_commission_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/filter_date-formate.dart';
import 'package:http/http.dart' as http;

class CommissionDetails extends StatefulWidget {
  const CommissionDetails({super.key});

  @override
  State<CommissionDetails> createState() => _CommissionDetailsState();
}

class _CommissionDetailsState extends State<CommissionDetails> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    commissionDetailsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Commission detail',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height * 0.065,
              width: width * 0.85,
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                      text:
                          '   ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      fontSize: 18,
                      color: Colors.white),
                  FilterDateFormat(
                    onDateSelected: (DateTime selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                      });
                      commissionDetailsApi();
                      if (kDebugMode) {
                        print('Selected Date: $selectedDate');
                        print('object');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          responseStatuscode == 400
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Container(
                      width: width * 0.85,
                      height: height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Color(0xff4287ff),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 100,
                            color: AppColors.gradientFirstColor,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          textWidget(
                            text:
                                '   ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: AppColors.primaryTextColor,
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          textWidget(
                            text: 'No data Found :(',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: commissionDetailsData.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final data = commissionDetailsData[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.filledColor,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.15,
                                  width: width,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    color: AppColors.filledColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: textWidget(
                                            text: 'Settlement successful',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: AppColors.primaryTextColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: textWidget(
                                            text:
                                                data.settlementDate.toString(),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: AppColors.primaryTextColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: textWidget(
                                            text:
                                                'The commission has been automatically credited to your balance',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 12,
                                            color: AppColors.primaryTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                historyDetails(
                                  'Number of bettors',
                                  '${data.numberOfBettors} People',
                                  Colors.white,
                                ),
                                historyDetails(
                                  'Bet amount',
                                  '${data.betAmount}',
                                  Colors.white,
                                ),
                                historyDetails(
                                  'Commission payout',
                                  '${data.commissionPayout}',
                                  AppColors.gradientFirstColor,
                                ),
                                historyDetails(
                                  'Date',
                                  '${data.date}',
                                  Colors.white,
                                ),
                                SizedBox(height: height * 0.015),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }

  Widget historyDetails(String title, String subtitle, Color subColor) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            height: height * 0.05,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.FirstColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: subColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  int? responseStatuscode;
  UserViewProvider userProvider = UserViewProvider();

  List<CommissionDetailModel> commissionDetailsData = [];

  Future<void> commissionDetailsApi() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(
          '${ApiUrl.CommissionDetailApi}$token&subtypeid=23&date=$_selectedDate'),
    );
    if (kDebugMode) {
      print(ApiUrl.CommissionDetailApi + token);
      print('CommissionDetailApi');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        commissionDetailsData = responseData
            .map((item) => CommissionDetailModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        commissionDetailsData = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
