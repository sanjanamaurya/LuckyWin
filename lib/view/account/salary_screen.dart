import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/salary_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';


import '../wallet/deposit_history.dart';

class ScreenData extends StatefulWidget {
  const ScreenData({Key? key}) : super(key: key);

  @override
  State<ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<ScreenData> {
  int selectedId = 0;
  String typeName = 'All';
  DateTime? _selectedDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSalryData();
    // allScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: textWidget(
          text: 'Salary',
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: AppColors.white,
        ),
        centerTitle: true,
        gradient: AppColors.primaryGradient,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         showModalBottomSheet(
            //           shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.only(
            //               topRight: Radius.circular(10),
            //               topLeft: Radius.circular(10),
            //             ),
            //           ),
            //           context: context,
            //           builder: (BuildContext context) {
            //             return allTransctionType(context);
            //           },
            //         );
            //       },
            //       child: Container(
            //         height: height * 0.08,
            //         width: width * 0.45,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           color: AppColors.white,
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               SizedBox(
            //                 width: width*0.3,
            //                 child: textWidget(
            //                   text: typeName,
            //                   fontWeight: FontWeight.w900,
            //                   fontSize: 15,
            //                   color: AppColors.primaryTextColor,
            //                 ),
            //               ),
            //               const Icon(
            //                 Icons.keyboard_arrow_down,
            //                 color: AppColors.dividerColor,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: height * 0.08,
            //       width: width * 0.45,
            //       decoration: BoxDecoration(
            //           color: AppColors.white,
            //           borderRadius: BorderRadius.circular(5)),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           textWidget(
            //               text:   _selectedDate==null?'Select date':
            //               '   ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
            //               fontSize: 18,
            //               color: AppColors.primaryTextColor),
            //           FilterDateFormat(
            //             onDateSelected: (DateTime selectedDate) {
            //
            //
            //               setState(() {
            //                 _selectedDate = selectedDate;
            //               });
            //               allScreenData();
            //               if (kDebugMode) {
            //                 print('Selected Date: $selectedDate');
            //                 print('object');
            //               }
            //             },
            //           )
            //         ],
            //       ),
            //     ),
            //
            //   ],
            // ),
            responseStatusCode==400?Center(child: const notFoundData()):
            transctionTypes.isEmpty?const Center(child: CircularProgressIndicator()) :
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: transctionTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transaction = transctionTypes[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: AppColors.boxGradient,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.06,
                              width: width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                gradient: AppColors.boxGradient,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: textWidget(
                                    text: transaction.description=="1"?"Daily Salary":transaction.description =="2"?"Weekly Salary":"Monthly Salary",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            historyDetails(
                              'Time',
                              transaction.createdAt.toString(),
                              Colors.black,
                            ),

                            historyDetails(
                              'balance',
                              '₹${transaction.amount!.toStringAsFixed(2)}',
                              Colors.red,
                            ),
                            SizedBox(height: height * 0.015),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget allTransctionType(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(10),
  //         topLeft: Radius.circular(10),
  //       ),
  //       color: AppColors.filledColor,
  //     ),
  //     height: MediaQuery.of(context).size.height * 0.6,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(12.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: textWidget(
  //                   text: 'Cancel',
  //                   fontWeight: FontWeight.w900,
  //                   fontSize: 16,
  //                   color: selectedId == 0
  //                       ? Colors.blue
  //                       : AppColors.dividerColor,
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     allScreenData();
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: textWidget(
  //                   text: 'Confirm',
  //                   fontWeight: FontWeight.w900,
  //                   fontSize: 16,
  //                   color: AppColors.gradientFirstColor,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: isLoading
  //               ? const Center(child: CircularProgressIndicator())
  //               : ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: transctionTypes.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               final transactionType = transctionTypes[index];
  //               return InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedId = transactionType.id;
  //                     typeName=transactionType.name;
  //                   });
  //                   if (kDebugMode) {
  //                     print(selectedId);
  //                   }
  //                 },
  //                 child: Column(
  //                   children: [
  //                     Center(
  //                       child: textWidget(
  //                         text: transactionType.name,
  //                         fontWeight: FontWeight.w900,
  //                         fontSize: 16,
  //                         color: selectedId == index.toString()
  //                             ? Colors.blue
  //                             : AppColors.primaryTextColor,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height:
  //                       MediaQuery.of(context).size.height * 0.02,
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
              gradient: AppColors.gameGradient,
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
                      color: Colors.black,
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
  UserViewProvider userProvider = UserViewProvider();
  List<SalaryModel> transctionTypes = [];

  Future<void> fetchSalryData() async {

    setState(() {
      isLoading = true;
    });
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    try {
      final response = await http.get(Uri.parse(ApiUrl.salaryApi+token));
      print(ApiUrl.salaryApi+token);
      print("ApiUrl.salaryApi+token");

      setState(() {
        responseStatusCode = response.statusCode;
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          transctionTypes = responseData
              .map((item) => SalaryModel.fromJson(item))
              .toList();
        });

      } else if (response.statusCode == 401) {
      } else {
        throw Exception('Failed to load transaction types');
      }
    } catch (e) {
      print('Error fetching transaction types: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int? responseStatusCode;
  // Future<void> allScreenData() async {
  //   UserModel user = await userProvider.getUser();
  //   String token = user.id.toString();
  //
  //   final response = await http.get(
  //
  //     Uri.parse(_selectedDate==null?'${ApiUrl.allTranscation}$token&subtypeid=$selectedId':'${ApiUrl.allTranscation}$token&subtypeid=$selectedId&created_at=$_selectedDate'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   setState(() {
  //     responseStatusCode = response.statusCode;
  //   });
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = json.decode(response.body)['data'];
  //     setState(() {
  //       allTransactions = responseData
  //           .map((item) => AllTransactionModel.fromJson(item))
  //           .toList();
  //     });
  //   } else if (response.statusCode == 400) {
  //   } else {
  //     setState(() {
  //       allTransactions = [];
  //     });
  //     throw Exception('Failed to load transaction history');
  //   }
  // }
}


