import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/plinko_result.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';

class PlinkobetHistoryPage extends StatefulWidget {
  final String gameid;
  const PlinkobetHistoryPage({super.key, required this.gameid});

  @override
  State<PlinkobetHistoryPage> createState() => _PlinkobetHistoryPageState();
}

class _PlinkobetHistoryPageState extends State<PlinkobetHistoryPage> {
  @override
  void initState() {
    fetchPlinkoBethistoryTwo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        responseStatuscode == 400
            ? const Notfounddata()
            : fetchPlinkoBetTwo.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fetchPlinkoBetTwo.length,
                    itemBuilder: (context, index) {
                      List<Color> colors;

                      if (fetchPlinkoBetTwo[index].type == 1) {
                        colors = [
                          const Color(0xff337a04),
                          const Color(0xff52960c),
                          // Colors.green,
                        ];
                      } else if (fetchPlinkoBetTwo[index].type == 2) {
                        colors = [
                          const Color(0xFFc56f00),
                          const Color(0xFFca8605),
                          //      Color(0xFFc56f00),
                        ];
                      } else {
                        colors = [
                          const Color(0xFFb80118),
                          const Color(0xFFdd0016),
                          //  Color(0xFFb80118),
                        ];
                      }

                      return ExpansionTile(
                        leading: Container(
                            height: height * 0.06,
                            width: width * 0.12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.grey
                                gradient: LinearGradient(
                                    stops: const [0.5, 0.5],
                                    colors: colors,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(fetchPlinkoBetTwo[index].type == 1
                                    ? 'G'
                                    : fetchPlinkoBetTwo[index].type == 2
                                        ? 'Y'
                                        : 'R',style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),
                              ),
                            )),
                        title: Text(
                          '${fetchPlinkoBetTwo[index].multipler}X',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                             ),
                        ),
                        subtitle: Text(
                            fetchPlinkoBetTwo[index].datetime.toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: height * 0.042,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                        ? Colors.green
                                        : Colors.white,)),
                              child: Center(
                                child: Text(
                                   int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                      ? 'Success'
                                      : 'Lose',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    color: int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                        ? Colors.green
                                        : Colors.white,),
                                ),
                              ),
                            ),
                            Text(
                              fetchPlinkoBetTwo[index].status == 0
                                  ? '--'
                                  : fetchPlinkoBetTwo[index].status == 2
                                      ? '- ₹${fetchPlinkoBetTwo[index].amount.toStringAsFixed(2)}'
                                      : '+ ₹${fetchPlinkoBetTwo[index].win_amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                color: int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                    ? Colors.green
                                    : Colors.white,),
                            ),
                          ],
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
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
                                          fetchPlinkoBetTwo[index].orderid.toString(),
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
                                    'Purchase amount',
                                    '₹${fetchPlinkoBetTwo[index].amount}.00',
                                    Colors.white),
                                historyDetails(
                                    'Tax',
                                    fetchPlinkoBetTwo[index].tax.toString(),
                                    Colors.red),
                                historyDetails(
                                    'Amount after tax',
                                    fetchPlinkoBetTwo[index].after_tax.toString(),
                                    Colors.white),


                                historyDetails(
                                    'Select',
                                    fetchPlinkoBetTwo[index].type == 1
                                        ? 'Green'
                                        : fetchPlinkoBetTwo[index].type == 2
                                            ? 'Yellow'
                                            : "Red",
                                    Colors.white),
                                historyDetails(
                                    'Status',
                                   int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                      ? 'Success'
                                      : 'Failed',
                                   int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                      ? Colors.green
                                      : Colors.white,),
                                historyDetails('Multiplier',
                                    '${fetchPlinkoBetTwo[index].multipler}X', Colors.white),
                                historyDetails(
                                    'CashOut',
                                    fetchPlinkoBetTwo[index].status == 0
                                        ? '--'
                                        : '₹${fetchPlinkoBetTwo[index].win_amount.toStringAsFixed(2)}',
                                   int.parse(fetchPlinkoBetTwo[index].win_amount.toString()) >int.parse(fetchPlinkoBetTwo[index].amount.toString())
                                      ? Colors.green
                                      : Colors.white,),
                                historyDetails(
                                    'Order time',
                                    fetchPlinkoBetTwo[index]
                                        .datetime
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                setState(() {
                  pageNumber--;
                  limitResult = limitResult - 10;
                  offsetResult = offsetResult - 10;
                });
                setState(() {});
                fetchPlinkoBethistoryTwo();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.loginSecondryGrad,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber/${fetchPlinkoBetTwo.length}',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                setState(() {
                  limitResult = limitResult + 10;
                  offsetResult = offsetResult + 10;
                  pageNumber++;
                });
                setState(() {});
                fetchPlinkoBethistoryTwo();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.loginSecondryGrad,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  int limitResult = 0;
  int pageNumber = 1;
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
      Color subColor, Color subColor1) {
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
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  int? responseStatuscode;
  UserViewProvider userProvider = UserViewProvider();

  int offsetResult = 0;
  List<PlinkoBetHistory> fetchPlinkoBetTwo = [];
  Future<void> fetchPlinkoBethistoryTwo() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse("${ApiUrl.plinkoBetHistory}userid=$token&offset=$offsetResult&limit=10"),
    );
    print("${ApiUrl.plinkoBetHistory}userid=$token");

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        fetchPlinkoBetTwo = responseData
            .map((item) => PlinkoBetHistory.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        fetchPlinkoBetTwo = [];
      });
      throw Exception('Failed to load data');
    }
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
