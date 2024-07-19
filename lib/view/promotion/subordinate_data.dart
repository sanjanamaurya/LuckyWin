import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/subordinateDataModel.dart';
import 'package:theluckywin/model/tier_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/clipboard.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/filter_date-formate.dart';

class SubOrdinateDataScreen extends StatefulWidget {
  const SubOrdinateDataScreen( {super.key});

  @override
  State<SubOrdinateDataScreen> createState() => _SubOrdinateDataScreenState();
}

class _SubOrdinateDataScreenState extends State<SubOrdinateDataScreen> {
  TextEditingController searchCon = TextEditingController();

  @override
  void initState() {
    tierData();
    subData();
    // TODO: implement initState
    super.initState();
  }

  int?responseStatuscode;
  DateTime? _selectedDate;

  // int limitResult = 0;
  // int offsetResult = 0;
  // int pageNumber = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Subordinate Data', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.2),
            child: ListView(
              children: [
                Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                addTextColumn(
                                    depositnumber==null?"0":depositnumber.toString(),
                                    'Deposit Number',
                                    Colors.white),
                                addTextColumn(
                                    numberofbettor==null?"0":numberofbettor.toString(),
                                    'Number of bettor',
                                    Colors.white),
                                addTextColumn(
                                    noofirstdeposit==null?"0":noofirstdeposit.toString(),
                                    'Number of People making\n            first deposit',
                                    Colors.white),
                              ],
                            ),
                            Column(
                              children: [
                                addTextColumn(
                                    depositAmount==null?"0":depositAmount.toString(),
                                    'Deposit Amount',
                                    Colors.white),
                                addTextColumn(
                                    totalbet==null?"0":totalbet.toStringAsFixed(2),
                                    'Total bet',
                                    Colors.white),
                                addTextColumn(
                                    firstdepositamount==null?"0":firstdepositamount.toString(),
                                    'first deposit amount',
                                    Colors.white),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        )
                      ]),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: sundataitem.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: height * 0.25,
                          width: width * 0.93,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  textWidget(
                                      text: '  UID:${sundataitem[index].u_id}',
                                      fontSize: 18,
                                      color: AppColors.primaryTextColor),
                                  IconButton(
                                      onPressed: () {
                                        copyToClipboard(sundataitem[index].u_id.toString(),context);
                                      },
                                      icon: const Icon(
                                        Icons.copy,
                                        size: 20,
                                        color: AppColors.primaryTextColor,
                                      )),
                                ],
                              ),
                              Container(
                                width: width * 0.9,
                                height: 0.5,
                                color: AppColors.gradientFirstColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: 'Level',
                                        fontSize: 16,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text:selectedTierIndex==-1? '  All':'Tier ${selectedTierIndex+1}',
                                        fontSize: 16,
                                        color: AppColors.primaryTextColor),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: 'Deposit amount',
                                        fontSize: 16,
                                        ),
                                    textWidget(
                                        text: "₹${sundataitem[index].total_cash}",
                                        fontSize: 16,
                                        ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: 'Bet amount',
                                        fontSize: 18,
                                       ),
                                    textWidget(
                                        text: "₹${sundataitem[index].bet_amount}",
                                        fontSize: 18,
                                        ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: 'Commission',
                                        fontSize: 18,
                                        ),
                                    textWidget(
                                        text:sundataitem[index].commission.toStringAsFixed(3),
                                        fontSize: 18,
                                        ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: 'Date',
                                        fontSize: 18,
                                        ),
                                    textWidget(
                                        // text:sundataitem[index].yesterday_date.toString(),
                                      text:DateFormat("yyyy-MMM-dd").format(DateTime.parse(sundataitem[index].yesterday_date.toString(),)),
                                        fontSize: 18,
                                        ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: limitResult == 0
                //           ? () {}
                //           : () {
                //         setState(() {
                //           pageNumber--;
                //           limitResult = limitResult - 10;
                //           offsetResult = offsetResult - 10;
                //         });
                //         setState(() {});
                //         gameHistoryResult();
                //       },
                //       child: Container(
                //         height: height * 0.06,
                //         width: width * 0.10,
                //         decoration: BoxDecoration(
                //           gradient: AppColors.goldenGradientDir,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: const Icon(
                //           Icons.navigate_before,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 16),
                //     textWidget(
                //       text: '$pageNumber',
                //       fontSize: 13,
                //       fontWeight: FontWeight.w600,
                //       color: AppColors.secondaryTextColor,
                //       maxLines: 1,
                //     ),
                //     const SizedBox(width: 16),
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           limitResult = limitResult + 10;
                //           offsetResult = offsetResult + 10;
                //           pageNumber++;
                //         });
                //         setState(() {});
                //         gameHistoryResult();
                //       },
                //       child: Container(
                //         height: height * 0.06,
                //         width: width * 0.10,
                //         decoration: BoxDecoration(
                //           gradient: AppColors.goldenGradientDir,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: const Icon(Icons.navigate_next, color: Colors.white),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: CustomTextField(
                    fieldRadius: BorderRadius.circular(10),
                    fillColor: Colors.white.withOpacity(0.01),
                    controller: searchCon,
                    onChanged: (val){

                    },
                    maxLines: 1,
                    hintText: 'Search subordinate UID',
                    suffixIcon: InkWell(
                      onTap: () {
                        // search(searchCon.text);
                        searchData(searchCon.text);

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.03,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: AppColors.loginSecondryGrad,
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.08,
                      width: width*0.45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 20,),
                          Center(
                            child: textWidget(
                                text:selectedTierIndex==-1? '  All':'Tier ${selectedTierIndex+1}',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          IconButton(
                              onPressed: () {
                                showSubordinateFilterBottomSheet(context);

                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.primaryTextColor)),
                        ],
                      ),
                    ),
                    Center(
                      // back button,
                      // height km krni hai
                      child: Container(
                        height: height*0.08,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textWidget(
                                text:   _selectedDate==null?'  Select date':
                                '   ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                                fontSize: 18,
                                color: AppColors.primaryTextColor),
                            FilterDateFormat(
                              onDateSelected: (DateTime selectedDate) {
                                setState(() {
                                  _selectedDate = selectedDate;
                                });
                                subData();
                                tierData();
                                // commissionDetailsApi();
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int selectedTierIndex = 0;


  String type='all';

  showSubordinateFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor:const Color(0xff4287ff),
      shape: const RoundedRectangleBorder(
          borderRadius:   BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: textWidget(
                        text: 'Cancel', fontSize: 16, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {

                      Navigator.pop(context,selectedTierIndex);
                      tierData();
                      subData();
                    },
                    child: textWidget(
                        text: 'Confirm', fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                    selectionOverlay:
                    const CupertinoPickerDefaultSelectionOverlay(
                      background: CupertinoDynamicColor.withBrightness(
                        color: Colors.transparent,
                        darkColor: Colors.transparent,
                      ),
                    ),
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedTierIndex,
                    ),
                    itemExtent: 50,
                    onSelectedItemChanged: (tierIndex) {
                      setState(() {
                        selectedTierIndex = tierIndex; // Update selected index
                        type=tierIndex==0?'all':'Tier $tierIndex';
                        if (kDebugMode) {
                          print(tierIndex);
                          print("tierIndex");
                        }
                      });

                    },
                    children: [
                      for (var datas in tieritem)
                        Text(datas.name,style: const TextStyle(color: Colors.white),)
                    ]
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {

        if (kDebugMode) {
          print('Selected Tier: $value');
        }
      }
    });
  }

  addTextColumn(String number, String subtext, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
          ),
          Text(
            subtext,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ],
      ),
    );
  }



  List<TierModel> tieritem = [];
  Future<void> tierData() async {
    final response = await http.get(Uri.parse(ApiUrl.TierApi),);
    if (kDebugMode) {
      print(ApiUrl.TierApi);
      print('TierApi');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      if (kDebugMode) {
        print(responseData);
        print("ewnrofbeortg");
      }


      setState(() {
        tieritem = responseData.map((item) => TierModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        tieritem = [];
      });
      throw Exception('Failed to load data');
    }
  }


  UserViewProvider userProvider = UserViewProvider();

  dynamic depositnumber;
  dynamic depositAmount;
  dynamic numberofbettor;
  dynamic totalbet;
  dynamic noofirstdeposit;
  dynamic firstdepositamount;

  List<SubordinateModel> sundataitem = [];
  Future<void> subData() async {

    if (kDebugMode) {
      print("dwesbgfig");
    }
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
      Uri.parse(
          _selectedDate==null?
      '${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}':
      '${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&created_at=$_selectedDate'),
      );
    if (kDebugMode) {
      print("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}");
      print("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&created_at=$_selectedDate");
      // print("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&created_at=$_selectedDate&limit=10&offset=$offsetResult");
      print('subdadxxutswfdu');
      print('$_selectedDate');
      print('vud');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['subordinates_data'];
      setState(() {
        sundataitem = responseData.map((item) => SubordinateModel.fromJson(item)).toList();
        noofirstdeposit = json.decode(response.body)['first_deposit'];
        depositnumber = json.decode(response.body)['number_of_deposit'];
        depositAmount = json.decode(response.body)['payin_amount'];
        numberofbettor = json.decode(response.body)['number_of_bettor'];
        totalbet = json.decode(response.body)['bet_amount'];
        firstdepositamount = json.decode(response.body)['first_deposit_amount'];

      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        sundataitem = [];
      });
      throw Exception('Failed to load data');
    }
  }


  Future<void> searchData(String search) async {
    try {
      UserModel user = await userProvider.getUser();
      String token = user.id.toString();

      final response = await http.get(
        Uri.parse("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&u_id=$search"),
      );

      if (kDebugMode) {
        print("${ApiUrl.SubdataApi}$token&tier=${selectedTierIndex+1}&u_id=$search");
        print("HTTP GET request sent");
      }

      setState(() {
        responseStatuscode = response.statusCode;
      });

      if (response.statusCode == 200) {
        List<SubordinateModel> searchResult = sundataitem.where((data) => data.u_id.toString().contains(search)).toList();

        setState(() {
          sundataitem = searchResult;
          if (kDebugMode) {
            print(sundataitem);
          }
        });
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print("Data not found");
        }
      } else {
        setState(() {
          sundataitem = [];
        });
        throw Exception("Failed to load data");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error in searchData function: $error");
      }
      throw Exception("Error in searchData function: $error");
    }
  }
}


