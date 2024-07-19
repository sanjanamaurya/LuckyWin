import 'dart:convert';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/attendence_model.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/activity/attendance_rule.dart';
import 'package:theluckywin/view/activity/attendence_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendenceBonus extends StatefulWidget {
  const AttendenceBonus({super.key});

  @override
  State<AttendenceBonus> createState() => _AttendenceBonusState();
}

class _AttendenceBonusState extends State<AttendenceBonus> {
  @override
  void initState() {
    attendenceList();
    // TODO: implement initState
    super.initState();
  }

  int? responseStatuscode;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
            centerTitle: true,
            title: textWidget(
                text: 'Attendance', fontSize: 25, color: Colors.white),
            leading: const AppBackBtn(),
            gradient: AppColors.primaryUnselectedGradient),
        body:attendenceItems.isEmpty?const Center(child: CircularProgressIndicator()):
        ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: AppColors.primaryUnselectedGradient,
                  image: DecorationImage(
                      image: AssetImage(Assets.imagesBggifts),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: "Attendance Bonus",
                        fontSize: width * 0.047,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            text:
                                "Get your rewards based on consecutive \n login days.",
                            fontSize: width * 0.034,
                            color: Colors.white),

                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Container(
                      height: height * 0.10,
                      width: width * 0.45,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.imagesBookmark),
                              fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          textWidget(
                              text: "Attended consecutively",
                              fontSize: width * 0.035,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          textWidget(
                              text:  "$attendancesConsecutively Days",
                              fontSize: width * 0.045,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    textWidget(
                        text: "Accumulated",
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    Row(
                      children: [
                        textWidget(
                          text: accumulated.toString(),
                          fontSize: width * 0.05,
                          color: Colors.white,
                        ),
                        InkWell(
                            onTap: () {
                              attendenceList();
                             // attendenceDays();
                            },
                            child: Image.asset(
                              Assets.iconsTotalBal,
                              height: height * 0.03,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppBtn(
                            height: height * 0.045,
                            width: width * 0.40,
                            title: 'Game rule',
                            fontSize: 12,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const AttendanceRule()));
                            },
                           // hideBorder: true,
                            gradient: AppColors.oranfegradient
                          // gradient: activeButton
                          //     ? AppColors.primaryGradient
                          //     : AppColors.inactiveGradient,
                        ),
                        AppBtn(
                            height: height * 0.045,
                            width: width * 0.40,
                            title: 'Attendance History',
                            fontSize: 12,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const AttendenceHistory()));
                            },
                            // hideBorder: true,
                            gradient: AppColors.oranfegradient
                          // gradient: activeButton
                          //     ? AppColors.primaryGradient
                          //     : AppColors.inactiveGradient,
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.2
                ),
                shrinkWrap: true,
                itemCount: attendenceItems.length-1,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (BuildContext context, int index) {
                  final data= attendenceItems[index];
                  return Container(
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                    gradient:data.status=='0'?AppColors.primaryappbargrey :AppColors.primaryUnselectedGradient
                  ),
                    child:  Column(
                      children: [
                        Container(
                          height: height*0.05,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.imagesUnsignInTop),
                                  fit: BoxFit.fill) ),
                          child:  Center(
                            child: textWidget(
                                text: "₹${data.attendanceBonus}",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox( height: height*0.02,),
                        Container(
                          height: width*0.14,
                          width: width*0.14,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.imagesCoingifts),
                                  fit: BoxFit.fill) ),
                        ),
                        SizedBox( height: height*0.01,),
                        textWidget(
                            text: "${data.id} Day",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ],
                    ),
                  );
                },
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attendenceItems.length, // Use the original length
              itemBuilder: (context, index) {
                final datas = attendenceItems[index];
                if (index == attendenceItems.length - 1) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: height * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(Assets.imagesGiftsbelow),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width * 0.45),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20, // Adjust width as needed
                                    height: 1, // Adjust height as needed
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [
                                          Color(0xFFC0C4DC),
                                          Color(0x00C0C4DC), // Use 0x00 for transparent color
                                        ],
                                      ),
                                    ),
                                  ),
                                  textWidget(
                                    text: "  ₹${datas.attendanceBonus}  ",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 20, // Adjust width as needed
                                    height: 1, // Adjust height as needed
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFC0C4DC),
                                          Color(0x00C0C4DC), // Use 0x00 for transparent color
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              textWidget(
                                text: "${datas.id} Day",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(); // Return an empty container for other items
                }
              },
            ),


            SizedBox(
              height: height * 0.04,
            ),
            AppBtn(
                // height: height * 0.045,
                // width: width * 0.40,
                title: 'Attendance ',
                fontSize: 20,
                onTap: () {
                  attendanceClem();
                },
                 hideBorder: true,
                gradient: AppColors.loginSecondryGrad
            ),
            SizedBox(
              height: height * 0.08,
            ),
          ],
        ));
  }
   String? accumulated;
   String? attendancesConsecutively;

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
      accumulated= json.decode(response.body)['accumulated'].toString();
      attendancesConsecutively= json.decode(response.body)['attendances_consecutively'].toString();
      setState(() {
        attendenceItems =
            responseData.map((item) => AttendanceModel.fromJson(item)).toList();
        accumulated;attendancesConsecutively;

      });
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

  attendanceClem() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.attendanceClaim),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      attendenceList();
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      attendenceList();
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
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
