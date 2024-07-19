import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/attendence_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/components/theam_color.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:http/http.dart'as http;

import '../../res/api_urls.dart';
class AttendanceRule extends StatefulWidget {
  const AttendanceRule({super.key});

  @override
  State<AttendanceRule> createState() => _AttendanceRuleState();
}

class _AttendanceRuleState extends State<AttendanceRule> {

  @override
  void initState() {
    attendenceList();
    invitationRuleApi();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: Text(
          'Game Rules',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: myCustomTheme.appBarTheme.backgroundColor),
        ),
        centerTitle: true,
        gradient: AppColors.primaryUnselectedGradient,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: AppColors.primaryUnselectedGradient,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff388eff),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                      ),
                      height:height*0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildContainer('Continuous Attendance'),
                          buildContainer('Accumulated\n    Amount'),
                          buildContainer('Attendance\n    Bonus'),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: attendenceItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data= attendenceItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildContainer('${data.id} '),
                                    buildContainer('₹${data.accumulatedAmount}'),
                                    buildContainer('₹${data.attendanceBonus}'),
                                  ],
                                ),
                                const Divider(color: AppColors.gradientFirstColor,thickness: 1,)
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.secondaryContainerTextColor,width: 2),
                        //  gradient: AppColors.primaryUnselectedGradient,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        SizedBox(  height: height*0.06,),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: invitationRuleList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return instruction(invitationRuleList[index]);
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
                        'Rules',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  instruction(String title) {
    return ListTile(
      leading: Transform.rotate(
        angle: 45 * 3.1415927 / 180,
        child: Container(
          height: 10,
          width: 10,
          color: AppColors.gradientFirstColor,
        ),
      ),
      title: textWidget(
          text: title,
          fontSize: 14,
          color: AppColors.primaryTextColor
      ),
    );
  }
  buildContainer(String text) {
    return SizedBox(
      width: width*0.28,
      //  color: Colors.black,
      child: Center(
        child: Text(text,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white),
        ),
      ),
    );
  }

  int?responseStatuscode;
  UserViewProvider userProvider = UserViewProvider();

  List<AttendanceModel> attendenceItems = [];

  Future<void> attendenceList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(ApiUrl.attendanceList+token),
    );
    if (kDebugMode) {
      print(ApiUrl.attendanceList+token);
      print('attendanceList');
    }
    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        attendenceItems =
            responseData.map((item) => AttendanceModel.fromJson(item)).toList();

      });

      print(responseData);
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        attendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }


  List<String> invitationRuleList = [];
  Future<void> invitationRuleApi() async {

    final response = await http.get(Uri.parse('${ApiUrl.allRules}4'),);
    if (kDebugMode) {
      print('${ApiUrl.allRules}4');
      print('allRules');
    }


    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        invitationRuleList = json.decode(responseData[0]['list']).cast<String>();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        invitationRuleList = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
