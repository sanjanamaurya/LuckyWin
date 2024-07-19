// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:convert';
import 'package:theluckywin/main.dart';
import 'package:flutter/foundation.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/model/bettingHistory_Model.dart';
import 'package:theluckywin/model/bettinghistoryTRX.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/clipboard.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/view/account/History/aviator_bet_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class BetHistory extends StatefulWidget {
  const BetHistory({super.key});

  @override
  State<BetHistory> createState() => _BetHistoryState();
}

class _BetHistoryState extends State<BetHistory> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    BettingHistory();
    BettingHistoryTRX();
    super.initState();
    selectedCatIndex = 0;
  }

  int ?responseStatuscode;



  List<BetIconModel> betIconList = [
    BetIconModel(title: 'Lottery', image: Assets.imagesLotteryIcon),
    BetIconModel(title: 'Mini games', image: Assets.imagesCasinoIcon),
    BetIconModel(title: 'TRX', image: Assets.imagesLotteryIcon),
    // BetIconModel(title: 'Original', image: Assets.imagesOriginalIcon),
    // BetIconModel(title: 'Slots', image: Assets.imagesSlotsIcon),
  ];
  late int selectedCatIndex;



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Bet History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 70,
              width: width * 0.93,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: betIconList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCatIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 35,
                        width: 115,
                        decoration: BoxDecoration(
                          gradient: selectedCatIndex == index
                              ? AppColors.goldenGradientDir
                              : AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.2,
                              blurRadius: 2,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('${betIconList[index].image}'),
                              height: 25,
                              color: selectedCatIndex == index
                                  ? AppColors.browntextprimary
                                  : AppColors.goldencolorthree,
                            ),
                            textWidget(
                              text: betIconList[index].title,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedCatIndex == index
                                  ? AppColors.browntextprimary
                                  : AppColors.goldencolorthree,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 5,),
            selectedCatIndex==0?
            responseStatuscode== 400 ?
            const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index){
                    final int initialAmount = int.parse(items[index].amount.toString());
                    const double percentage = 2.0;
                    double finalAmount = initialAmount - (initialAmount * (percentage / 100));


                    List<Color> colors;

                    if (items[index].number == '0') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFb659fe),
                      ];
                    } else if (items[index].number == '5') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (items[index].number == '10') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (items[index].number == '20') {
                      colors = [

                        const Color(0xFFb659fe),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (items[index].number == '30') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }  else if (items[index].number == '40') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (items[index].number == '50') {
                      colors = [
                        //blue
                        const Color(0xFF6da7f4),
                        const Color(0xFF6da7f4)
                      ];
                    } else {
                      int number = int.parse(items[index].number.toString());
                      colors = number.isOdd
                          ? [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),
                      ]
                          : [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: AppColors.secondaryappbar,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: width * 0.40,
                                        decoration:  BoxDecoration(
                                            gradient: AppColors.goldenGradientDir,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: textWidget(
                                            text: 'Bet',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.browntextprimary),
                                      ),
                                    ),
                                    textWidget(text:  items[index].status=="0"?"Pending":items[index].status=="1"?"Win":"Loss",
                                        fontSize: width*0.05,
                                        fontWeight: FontWeight.w600,
                                        color: items[index].status=="0"?Colors.orange:items[index].status=="1"?Colors.green:Colors.red

                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Balance",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    ),
                                    textWidget(
                                        text: "₹$finalAmount",
                                        //  text: "₹${(double.parse(items[index].amount.toString())-0.02).toStringAsFixed(0)}",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Bet Type",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    int.parse(items[index].number.toString())<=9?
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: width*0.20,
                                      child: GradientTextview(
                                        items[index].number.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                        gradient: LinearGradient(
                                            colors: colors,
                                            stops: const [
                                              0.5,
                                              0.5,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.mirror),
                                      ),
                                    ):GradientTextview(
                                      items[index].number.toString()=='10'?'Green':items[index].number.toString()=='20'?'Voilet':items[index].number.toString()=='30'?'Red':items[index].number.toString()=='40'?'Big':items[index].number.toString()=='50'?'Small':'',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      gradient: LinearGradient(
                                          colors: colors,
                                          stops: const [
                                            0.5,
                                            0.5,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.mirror),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Type",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: items[index].gameId=="1"?"1 min":items[index].gameId=="2"?"3 min":items[index].gameId=="4"?"5 min":"10 min",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Win Amount",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: items[index].winNumber==null?'₹ 0.0':'₹ ${items[index].winNumber}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Time",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(items[index].createdAt.toString())),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Order number",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    Row(
                                      children: [
                                        textWidget(text: items[index].gamesno.toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryTextColor
                                        ),
                                        SizedBox(width: width*0.01,),
                                        InkWell(
                                            onTap: (){
                                              copyToClipboard(items[index].gamesno.toString(),context);
                                            },
                                            child: Image.asset(Assets.iconsCopy,color: Colors.grey,height: height*0.027,)),

                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );

                  }),
            ):
            selectedCatIndex==1?
            const AvaitorBetHistory():
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: itemsTRX.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index){
                    List<Color> colors;

                    if (itemsTRX[index].number == '0') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFb659fe),
                      ];
                    } else if (itemsTRX[index].number == '5') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (itemsTRX[index].number == '10') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (itemsTRX[index].number == '20') {
                      colors = [

                        const Color(0xFFb659fe),
                        const Color(0xFFb659fe),
                      ];
                    }  else if (itemsTRX[index].number == '30') {
                      colors = [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }  else if (itemsTRX[index].number == '40') {
                      colors = [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),

                      ];
                    }  else if (itemsTRX[index].number == '50') {
                      colors = [
                        //blue
                        const Color(0xFF6da7f4),
                        const Color(0xFF6da7f4)
                      ];
                    } else {
                      int number = int.parse(itemsTRX[index].number.toString());
                      colors = number.isOdd
                          ? [
                        const Color(0xFF40ad72),
                        const Color(0xFF40ad72),
                      ]
                          : [
                        const Color(0xFFfd565c),
                        const Color(0xFFfd565c),
                      ];
                    }

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(gradient: AppColors.secondaryappbar,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: width * 0.40,
                                        decoration:  BoxDecoration(
                                            gradient: AppColors.goldenGradientDir,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: textWidget(
                                            text: 'Bet',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.browntextprimary),
                                      ),
                                    ),
                                    textWidget(text:  itemsTRX[index].status=="0"?"Pending":itemsTRX[index].status=="1"?"Win":"Loss",
                                        fontSize: width*0.05,
                                        fontWeight: FontWeight.w600,
                                        color: itemsTRX[index].status=="1"?Colors.green:Colors.red

                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Balance",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    ),
                                    textWidget(text: "₹${itemsTRX[index].amount}",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Bet Type",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    int.parse(itemsTRX[index].number.toString())<=9?
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: width*0.20,
                                      child: GradientTextview(
                                        itemsTRX[index].number.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                        gradient: LinearGradient(
                                            colors: colors,
                                            stops: const [
                                              0.5,
                                              0.5,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.mirror),
                                      ),
                                    ):GradientTextview(
                                      itemsTRX[index].number.toString()=='10'?'Green':itemsTRX[index].number.toString()=='20'?'Voilet':itemsTRX[index].number.toString()=='30'?'Red':itemsTRX[index].number.toString()=='40'?'Big':itemsTRX[index].number.toString()=='50'?'Small':'',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      gradient: LinearGradient(
                                          colors: colors,
                                          stops: const [
                                            0.5,
                                            0.5,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.mirror),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Type",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: itemsTRX[index].gameid=="1"?"1 min":itemsTRX[index].gameid=="2"?"3 min":itemsTRX[index].gameid=="4"?"5 min":"10 min",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Win Amount",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(text: itemsTRX[index].win==null?'₹ 0.0':'₹ ${itemsTRX[index].win}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Time",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                            DateTime.parse(itemsTRX[index].datetime.toString())),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor

                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: "Order number",
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    Row(
                                      children: [
                                        textWidget(text: itemsTRX[index].gamesno.toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryTextColor
                                        ),
                                        SizedBox(width: width*0.01,),
                                        InkWell(
                                            onTap: (){
                                              copyToClipboard(itemsTRX[index].gamesno.toString(),context);
                                            },
                                            child: Image.asset(Assets.iconsCopy,color: Colors.grey,height: height*0.027,)),

                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }


  UserViewProvider userProvider = UserViewProvider();
  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.betHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.betHistory+token);
      print('betHistory+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => BettingHistoryModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<BettingHistoryModelTRX> itemsTRX = [];
  Future<void> BettingHistoryTRX() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(Uri.parse(ApiUrl.profile),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userid":token
      }),
    );
    if (kDebugMode) {
      print(ApiUrl.profile);
      print('betHistoryTRX');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        itemsTRX = responseData.map((item) => BettingHistoryModelTRX.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        itemsTRX = [];
      });
      throw Exception('Failed to load data');
    }
  }
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height*0.07),
        const Text("Data not found",)
      ],
    );
  }

}
class GradientTextview extends StatelessWidget {
  const GradientTextview(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}


class BetIconModel {
  final String title;
  final String? image;
  BetIconModel({required this.title, this.image});
}

class History{
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method,this.balance,this.type,this.orderno);
}