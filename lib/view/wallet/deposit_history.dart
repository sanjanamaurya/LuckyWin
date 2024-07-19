
import 'dart:convert';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/deposit_model_new.dart';
import 'package:theluckywin/model/transction_type_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/clipboard.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/utils/filter_date-formate.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:theluckywin/view/wallet/deposit_bottom.dart';
import '../../model/deposit_model.dart';

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory> with  SingleTickerProviderStateMixin {

  @override
  void initState() {
    depositHistory();
    getwaySelect();
    fetchTransactionTypes();
    super.initState();
    selectedCatIndex = 1;

  }
  bool isLoading = false;


  int ?responseStatuscode;


  int? selectedCatIndex;
  int selectedId = 0;
  String typeName = 'All';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: textWidget(
          text: 'Deposit history',
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: Colors.white,
        ),
        centerTitle: true,
        gradient: AppColors.primaryUnselectedGradient,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              height: 70,
              width: width * 0.93,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCatIndex = items[index].id;
                        });
                        print(selectedCatIndex);
                        depositHistory();
                        print('qwqwqwqw');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 40,
                        width: 95,
                        decoration: BoxDecoration(

                          gradient: selectedCatIndex == items[index].id
                              ? AppColors.boxGradient
                              : AppColors.whitegradient,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.1),

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: NetworkImage('${items[index].image}'),
                              height: 25,

                            ),
                            textWidget(
                              text: items[index].name,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedCatIndex == items[index].id
                                  ? Colors.black
                                  : AppColors.iconsColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return allTransctionType(context);
                        },
                      );
                      // _selectLocation();

                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width*0.3,
                              child: textWidget(
                                // text: nametype==null?"ALL":nametype.toString(),
                                text: typeName,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: height * 0.08,
                  //   width: width * 0.45,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: Colors.white,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         textWidget(
                  //           text: 'Choose the date',
                  //           fontWeight: FontWeight.w900,
                  //           fontSize: 12,
                  //
                  //         ),
                  //         const Icon(
                  //           Icons.keyboard_arrow_down,
                  //           color: Colors.black,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Center(
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
                              text:   _selectedDate==null?'Select date':
                              '   ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                              fontSize: 18,
                              color: AppColors.primaryTextColor),
                          FilterDateFormat(
                            onDateSelected: (DateTime selectedDate) {
                              setState(() {
                                _selectedDate = selectedDate;
                              });
                              depositHistory();
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
            ),


            responseStatuscode== 400 ?
            const notFoundData(): depositItems.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: depositItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: AppColors.boxGradient,
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: AppColors.boxGradient,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: 'Deposit'  ,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      ),
                                      textWidget(text: depositItems[index].status==1?"Processing":depositItems[index].status==2?"Complete":"Rejected",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: depositItems[index].status==1?Colors.white:depositItems[index].status==2?Colors.green.shade900:Colors.red
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),


                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: height*0.055,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: "Balance",
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryTextColor),
                                      textWidget(
                                          text: "₹${depositItems[index].cash}",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.gradientFirstColor),
                                    ],
                                  ),
                                ),
                              ),
                              selectedCatIndex==2? Padding(
                                padding: const EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: height*0.055,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: "USDT Amount",
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryTextColor),
                                      textWidget(
                                          text: "${depositItems[index].usdtAmount}",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.btnColor),
                                    ],
                                  ),
                                ),
                              ):Container(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: height*0.055,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Type",
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryTextColor),
                                      Image.asset(depositItems[index].type==2?Assets.imagesUsdtIcon:Assets.imagesFastpayImage, height: height*0.05,)
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 5),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: height*0.055,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Time",
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryTextColor),
                                      textWidget(
                                          text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(depositItems[index].createdAt.toString())),                                        fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryTextColor

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 12),
                                child: Container(
                                  height: height*0.055,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Order number",
                                          fontSize: width * 0.035,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryTextColor),
                                      Row(
                                        children: [
                                          textWidget(
                                              text: depositItems[index].orderId.toString(),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color:
                                              AppColors.primaryTextColor),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          InkWell(
                                              onTap: (){
                                                copyToClipboard(depositItems[index].orderId.toString(), context);
                                              },
                                              child: Image.asset(Assets.iconsCopy, color: Colors.grey,height: height * 0.03))                                      ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })

            )



          ],
        ),
      ),

    );
  }

  UserViewProvider userProvider = UserViewProvider();

  // List<DepositModel> depositItems = [];
  //
  // Future<void> depositHistory() async {
  //   UserModel user = await userProvider.getUser();
  //   String token = user.id.toString();
  //
  //   final response = await http.get(Uri.parse('${ApiUrl.depositHistory}$token&status=$selectedId&type=$selectedCatIndex'),);
  //   if (kDebugMode) {
  //     print('${ApiUrl.depositHistory}$token&status=$selectedId&type=$selectedCatIndex');
  //     print('depositHistory');
  //   }
  //
  //   setState(() {
  //     responseStatuscode = response.statusCode;
  //   });
  //
  //   if (response.statusCode==200) {
  //     final List<dynamic> responseData = json.decode(response.body)['data'];
  //     setState(() {
  //
  //       depositItems = responseData.map((item) => DepositModel.fromJson(item)).toList();
  //       // selectedIndex = items.isNotEmpty ? 0:-1; //
  //     });
  //
  //   }
  //   else if(response.statusCode==400){
  //     if (kDebugMode) {
  //       print('Data not found');
  //     }
  //   }
  //   else {
  //     setState(() {
  //       depositItems = [];
  //     });
  //     throw Exception('Failed to load data');
  //   }
  // }


  List<DepositModel> depositItems = [];

  Future<void> depositHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(    _selectedDate==null?
    '${ApiUrl.depositHistory}$token&type=$selectedCatIndex&status=$selectedId':
    '${ApiUrl.depositHistory}$token&type=$selectedCatIndex&status=$selectedId&created_at=$_selectedDate'),);
    if (kDebugMode) {
      print('${ApiUrl.depositHistory}$token&type=$selectedCatIndex&status=$selectedId&created_at=$_selectedDate');
      print('depositHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        depositItems = responseData.map((item) => DepositModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        depositItems = [];
      });
      throw Exception('Failed to load data');
    }
  }






  Widget allTransctionType(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Cancel',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color:
                    AppColors.dividerColor,
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              itemCount: transctionTypes.length,
              itemBuilder: (BuildContext context, int index) {
                final type = transctionTypes[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedId = index;
                      typeName = type.name.toString();
                      fetchTransactionTypes();
                      depositHistory();
                    });
                    if (kDebugMode) {
                      print(selectedId);
                    }
                    Navigator.pop(context);

                  },
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          type.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: selectedId == index
                                ? Colors.blue
                                : AppColors.primaryTextColor, // Assuming AppColors.primaryTextColor is black
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  List<TransctionTypeModel> transctionTypes = [];
  Future<void> fetchTransactionTypes() async {
    print("dsfgdtw65wuhaysgbfr");
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(ApiUrl.depositWithdrawlStatusList));
      print(ApiUrl.depositWithdrawlStatusList);
      print("responsefydu");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        print(responseData);
        print("responseDataf7d7");
        setState(() {
          transctionTypes = responseData
              .map((item) => TransctionTypeModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 401) {
        Navigator.pushNamed(context, RoutesName.loginScreen);
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

  ///gateway select api
  List<GetwayModel> items = [];

  Future<void> getwaySelect() async {
    UserModel user = await userProvider.getUser();

    String token = user.id.toString();

    final response = await http.get(
      Uri.parse(ApiUrl.getwayList+token),
    );
    if (kDebugMode) {
      print(ApiUrl.getwayList+token);
      print('getwayList+token');
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        items = responseData.map((item) => GetwayModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });
      print(items);

      print('wwwwwwwwwwwwwwwwww');
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }


  // var nametype;
  // void _selectLocation() async {
  //   final selectedLocation = await showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(10),
  //         topLeft: Radius.circular(10),
  //       ),
  //     ),
  //     context: context,
  //     builder: (context) => DepositBottom(
  //       id: selectedId,
  //       name: typeName,
  //     ),
  //   );
  //
  //   print("sseee");
  //   print(selectedLocation);
  //
  //   if (selectedLocation is Map<String, dynamic>) {
  //     print("aaaaaaa");
  //     setState(() {
  //       nametype = selectedLocation['name'];
  //     });
  //   }
  // }


}


class notFoundData extends StatelessWidget {
  const notFoundData({super.key});

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*0.05,),
        Image.asset(Assets.imagesNoDataAvailable,height: height*0.21,),

        const Text("No data (:")
      ],
    );
  }

}



