import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/bettingHistory_Model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';

class TrxAllHistory extends StatefulWidget {
  const TrxAllHistory({super.key});

  @override
  State<TrxAllHistory> createState() => _TrxAllHistoryState();
}

class _TrxAllHistoryState extends State<TrxAllHistory> {

  int selectedIndex = 6;
  int limitResult = 10;
  int offsetResult = 0;
  int pageNumber = 1;
  @override
  void initState() {
    BettingHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      children:  [

        Container(
          height: height*0.07,
          color: AppColors.filledColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment:CrossAxisAlignment.center ,
              children: [
                buildInkWell(6, 'Trx 1 min'),
                buildInkWell(7, 'Trx 3 min'),
                buildInkWell(8, 'Trx 5 min'),
                buildInkWell(9, 'Trx 10 min'),
              ],
            ),
          ),
        ),
        responseStatuscode == 400
            ? const Notfounddata()
            : items.isEmpty
            ? const Center(child: CircularProgressIndicator()):
        ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: 10),
          physics:
          const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            List<Color> colors;

            if (items[index].number == 0) {
              colors = [
                AppColors.orangeColor,
                AppColors.primaryTextColor,
              ];
            } else if (items[index].number == 5) {
              colors = [
                const Color(0xFF40ad72),
                AppColors.primaryTextColor,
              ];
            } else if (items[index].number ==
                10) {
              colors = [
                const Color(0xFF40ad72),
                const Color(0xFF40ad72),
              ];
            } else if (items[index].number ==
                20) {
              colors = [
                AppColors.primaryTextColor,
                AppColors.primaryTextColor,
              ];
            } else if (items[index].number ==
                30) {
              colors = [
                AppColors.orangeColor,
                AppColors.orangeColor,
              ];
            } else if (items[index].number ==
                40) {
              colors = [
                AppColors.goldencolor,
                AppColors.goldencolor,
              ];
            } else if (items[index].number ==
                50) {
              colors = [
                const Color(0xff6eb4ff),
                const Color(0xff6eb4ff)
              ];
            } else {
              int number = int.parse(
                  items[index].number.toString());
              colors = number.isOdd
                  ? [
                const Color(0xFF40ad72),
                const Color(0xFF40ad72),
              ]
                  : [
                AppColors.orangeColor,
                AppColors.orangeColor,
              ];
            }

            return ExpansionTile(
              leading: Container(
                  height: height * 0.06,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                          10),
                      // color: Colors.grey
                      gradient: LinearGradient(
                          stops: const [0.5, 0.5],
                          colors: colors,
                          begin:
                          Alignment.topLeft,
                          end: Alignment
                              .bottomRight)),
                  child: Center(
                    child: Text(
                      items[index].number == 40
                          ? 'Big'
                          : items[index].number ==
                          50
                          ? 'Small'
                          : items[index]
                          .number ==
                          10
                          ? 'G'
                          : items[index]
                          .number ==
                          20
                          ? 'V'
                          : items[index].number ==
                          30
                          ? 'R'
                          : items[index]
                          .number
                          .toString(),
                      style: TextStyle(
                          fontSize: items[index]
                              .number ==
                              40
                              ? 10
                              : items[index]
                              .number ==
                              50
                              ? 10
                              : 20,
                          fontWeight:
                          FontWeight.w800,
                          color: Colors.black),
                    ),
                  )),
              title: Text(
                items[index].gamesno.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                  items[index]
                      .createdAt
                      .toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey)),
              trailing: Column(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 0.042,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            10),
                        border: Border.all(
                            color: items[index]
                                .status ==
                                0
                                ? AppColors
                                .primaryTextColor
                                : items[index]
                                .status ==
                                2
                                ? AppColors
                                .secondaryTextColor
                                : Colors
                                .green)),
                    child: Center(
                      child: Text(
                        items[index].status == 2
                            ? 'Failed'
                            : items[index]
                            .status ==
                            0
                            ? 'Pending'
                            : 'Succeed',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w700,
                            color: items[index]
                                .status ==
                                0
                                ? Colors.white
                                : items[index]
                                .status ==
                                2
                                ? AppColors
                                .secondaryTextColor
                                : Colors
                                .green),
                      ),
                    ),
                  ),
                  Text(
                    items[index].status == 0
                        ? '--'
                        : items[index].status == 2
                        ? '- ₹${items[index].amount.toStringAsFixed(2)}'
                        : '+ ₹${items[index].winAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w700,
                        color: items[index]
                            .status ==
                            0
                            ? Colors.white
                            : items[index]
                            .status ==
                            2
                            ? AppColors
                            .secondaryTextColor
                            : Colors.green),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                          alignment:
                          Alignment.topLeft,
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight
                                  .w900,
                            ),
                          )),
                      const SizedBox(height: 8.0),
                      Container(
                        height: height * 0.08,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(10),
                            color: AppColors
                                .FirstColor),
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .all(8.0),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              const Text(
                                'order number',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .white),
                              ),
                              const SizedBox(
                                  height: 4.0),
                              Text(
                                items[index]
                                    .orderId
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .white),
                              )
                            ],
                          ),
                        ),
                      ),
                      historyDetails(
                          'Period',
                          items[index]
                              .gamesno
                              .toString(),
                          Colors.white),
                      historyDetails(
                          'Purchase amount',
                          items[index]
                              .amount
                              .toString(),
                          Colors.white),
                      historyDetails(
                          'Amount after tax',
                          items[index]
                              .tradeAmount
                              .toString(),
                          Colors.red),
                      historyDetails(
                          'Tax',
                          items[index]
                              .commission
                              .toString(),
                          Colors.white),
                      historyWinDetails(
                          'Result',
                          items[index].winNumber == null
                              ? '--'
                              : '${items[index].winNumber}, ',
                          items[index].winNumber ==
                              5
                              ? 'Green violet,'
                              : items[index]
                              .winNumber ==
                              0
                              ? 'Red Violet,'
                              : items[index]
                              .winNumber ==
                              null
                              ? ''
                              : items[index]
                              .winNumber
                              .isOdd
                              ? 'green,'
                              : 'red,',
                          items[index].winNumber ==
                              null
                              ? ''
                              : items[index]
                              .winNumber <
                              5
                              ? 'small'
                              : 'Big',
                          Colors.white,
                          items[index].winNumber ==
                              null
                              ? Colors.orange
                              : items[index]
                              .winNumber
                              .isOdd
                              ? Colors.green
                              : Colors.orange,
                          items[index].winNumber ==
                              null
                              ? Colors.orange
                              : items[index]
                              .winNumber <
                              5
                              ? Colors.yellow
                              : Colors.blue),
                      historyDetails(
                          'Select',
                          items[index].number ==
                              50
                              ? 'small'
                              : items[index]
                              .number ==
                              40
                              ? 'big'
                              : items[index]
                              .number ==
                              10
                              ? 'Green'
                              : items[index].number ==
                              20
                              ? 'Violet'
                              : items[index].number ==
                              30
                              ? 'Red'
                              : items[index].number.toString(),
                          Colors.white),
                      historyDetails(
                          'Status',
                          items[index].status == 0
                              ? 'Unpaid'
                              : items[index]
                              .status ==
                              2
                              ? 'Failed'
                              : 'Succeed',
                          items[index].status == 0
                              ? Colors.white
                              : items[index]
                              .status ==
                              2
                              ? Colors.red
                              : Colors.green),
                      historyDetails(
                          'Win/Loss',
                          items[index].status == 0
                              ? '--'
                              : '₹${items[index].winAmount.toStringAsFixed(2)}',
                          items[index].status == 0
                              ? Colors.white
                              : items[index]
                              .status ==
                              2
                              ? Colors.red
                              : Colors.green),
                      historyDetails(
                          'Order time',
                          items[index]
                              .createdAt
                              .toString(),
                          Colors.white),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                setState(() {
                  pageNumber--;
                  limitResult =
                      limitResult -
                          10;
                  offsetResult =
                      offsetResult -
                          10;
                });
                setState(() {});
                BettingHistory();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors
                      .loginSecondryGrad,
                  borderRadius:
                  BorderRadius.circular(
                      10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber/${items.length}',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors
                  .primaryTextColor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  limitResult =
                      limitResult + 10;
                  offsetResult =
                      offsetResult + 10;
                  pageNumber++;
                });
                setState(() {});
                BettingHistory();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors
                      .loginSecondryGrad,
                  borderRadius:
                  BorderRadius.circular(
                      10),
                ),
                child: const Icon(
                    Icons.navigate_next,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }


  UserViewProvider userProvider = UserViewProvider();



  BaseApiHelper baseApiHelper = BaseApiHelper();
  int? totalBets;

  int? responseStatuscode;
  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse('${ApiUrl.betHistory}$token&game_id=$selectedIndex&limit=10&offset=$offsetResult'),
    );
    if (kDebugMode) {
      print('${ApiUrl.betHistory}$token&game_id=$selectedIndex&limit=10&offset=0');
      print('betHistory+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      final Map<String, dynamic> Data = json.decode(response.body);
      final int totalBetsCount = Data['total_bets'];

      setState(() {
        items = responseData.map((item) => BettingHistoryModel.fromJson(item)).toList();
        totalBets=totalBetsCount;
      });
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


  historyDetails(String title, String subtitle, Color subColor) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.FirstColor),
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
                      color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: subColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  historyWinDetails(String title, String subtitle, String subtitle1,
      String subtitle2, Color subColor, Color subColor1, Color subColor2) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Container(
          height: height * 0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.FirstColor),
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
                      color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: subColor),
                    ),
                    Text(
                      subtitle1,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: subColor1),
                    ),
                    Text(
                      subtitle2,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: subColor2),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  InkWell buildInkWell(int index, String text) {
    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          offsetResult = 0;

        });
        BettingHistory();
      },
      child: Column(
        children: [
          textWidget(
            text: text,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            color: Colors.white,
          ),
          const SizedBox(height: 5,),
          isSelected ?  Container(
            height: 3,
            width: 50,
            color: isSelected ? Colors.blue : AppColors.gradientFirstColor,
          ) :Container()

        ],
      ),
    );
  }
}
class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height * 0.07),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}
