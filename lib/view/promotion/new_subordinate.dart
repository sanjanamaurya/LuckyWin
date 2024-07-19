import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/new_subordinate_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:http/http.dart'as http;

class NewSubordinate extends StatefulWidget {
  const NewSubordinate({super.key});

  @override
  State<NewSubordinate> createState() => _NewSubordinateState();
}

class _NewSubordinateState extends State<NewSubordinate> {


  @override
  void initState() {
    newSubordinate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'New Subordinate', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.primaryUnselectedGradient),
      body: ListView(
        shrinkWrap: true,

        children: [
          Container(
            height: height * 0.07,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryUnselectedGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildInkWell(1, 'Today'),
                  buildInkWell(2, 'Yesterday'),
                  buildInkWell(3, 'This Month'),
                ],
              ),
            ),
          ),
          responseStatuscode == 400
              ? const Notfounddata()
              : itemsSubordinate.isEmpty
              ? const Center(child: CircularProgressIndicator()):
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:  const BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(10)) ,
                    gradient: AppColors.whitegradient,
                  ),
                  child: Column(
                  //  shrinkWrap: true,
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: itemsSubordinate.length,
                        itemBuilder: (context, index) {
                          final data=itemsSubordinate[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                      text: obscureCenterDigits( data.mobile.toString()),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: AppColors.primaryTextColor,
                                    ),
                                    textWidget(
                                      text: 'UID: ${data.userName}',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: AppColors.primaryTextColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                      text: 'Direct Subordinate',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.primaryTextColor,
                                    ),
                                    textWidget(
                                      text: data.datetime.toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppColors.btnColor,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: AppColors.secondaryTextColor,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Center(
                        child: textWidget(
                          text: 'No more',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.btnColor,
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  ///condition for obscure text
  String obscureCenterDigits(String input) {
    if (input.length < 4) {
      return input;
    }

    int length = input.length;

    int startIndex = (length ~/ 2) - 1;

    int endIndex = (length ~/ 2) + 1;

    List<String> chars = input.split('');

    for (int i = startIndex; i <= endIndex; i++) {
      chars[i] = '*';
    }

    return chars.join('');
  }

  int selectedIndex = 1;

  InkWell buildInkWell(int index, String text) {
    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        newSubordinate();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Center(
              child: textWidget(
                text: text,
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          isSelected
              ? Container(
                  height: 3,
                  width: width * 0.3,
                  color:
                      isSelected ? Colors.indigo.shade900 : AppColors.gradientFirstColor,
                )
              : Container()
        ],
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();



  BaseApiHelper baseApiHelper = BaseApiHelper();
  int? responseStatuscode;
  List<NewSubordinateModel> itemsSubordinate = [];
  Future<void> newSubordinate() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse('${ApiUrl.newSubordinateTabApi}$token&type=$selectedIndex'),
    );
    if (kDebugMode) {
      print('${ApiUrl.newSubordinateTabApi}$token&type=$selectedIndex');
      print('newSubordinateApi+token');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];



      setState(() {
        itemsSubordinate = responseData.map((item) => NewSubordinateModel.fromJson(item)).toList();

      });

    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        itemsSubordinate = [];
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