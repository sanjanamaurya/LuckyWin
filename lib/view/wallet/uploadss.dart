import 'dart:convert';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/clipboard.dart';
import 'package:theluckywin/res/components/image_picker.dart';
import 'package:theluckywin/view/wallet/deposit_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
//"usdt_value": 91
class UploadScreenshots extends StatefulWidget {
  String amount;
  String cont;
  String type;
  UploadScreenshots({super.key, required this.amount, required this.cont,required this.type});

  @override
  State<UploadScreenshots> createState() => _UploadScreenshotsState();
}

class _UploadScreenshotsState extends State<UploadScreenshots> {
  @override
  void initState() {
    getImage();
    super.initState();
  }

  double minWithdraw = 10;
  String imagePath = "";
  String usdtAddress = "";

  final TextEditingController amount = TextEditingController();

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    print(widget.type.toString());
    print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                  )),
            ),
            centerTitle: true,
            title: textWidget(
              text: 'USDT Deposit',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.white,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DepositHistory()));
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textWidget(
                      text: 'Deposit history',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
            gradient: AppColors.primaryUnselectedGradient),
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: height * 0.02),
            Center(
              child: Container(
                height: height * 0.4,
                width: width * 0.8,
                decoration: BoxDecoration(

                  borderRadius: BorderRadiusDirectional.circular(15),
                ),
                child: imagePath == ""
                    ? const SizedBox()
                    : Image.network(imagePath,fit: BoxFit.fill,),
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Copy code:",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadiusDirectional.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        child: Text(
                          usdtAddress.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          copyToClipboard(
                              usdtAddress.toString(), context);
                        },
                        icon: Image.asset(
                          Assets.iconsCopyIcon,
                          height: 25,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 10, 25, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.imagesUsdtIcon,
                        height: 20,
                      ),
                      const SizedBox(width: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: textWidget(
                            text: 'USDT Amount ${widget.cont},',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.primaryTextColor),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(75, 0, 25, 10),
                  child: Row(
                    children: [
                      textWidget(
                          text: 'converted in INR ',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.primaryTextColor),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: AppColors.gradientSecondColor,
                    borderRadius: BorderRadiusDirectional.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height * 0.06,
                        width: width * 0.6,
                        child: Center(
                          child: Text(
                            '₹  ${widget.amount}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            myData == '0'
                ? InkWell(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 15, 35, 0),
                child: Container(
                  width: width * 0.8,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset(
                        Assets.iconsAddBank,
                        height: 60,
                      ),
                      const SizedBox(width: 15),
                      textWidget(
                          text: 'Upload Screenshot',
                          color: AppColors.primaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ],
                  ),
                ),
              ),
            )
                : Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 15, 35, 0),
                child: InkWell(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  child: Container(
                    height: height * 0.15,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(myData)),
                        fit: BoxFit
                            .fill, // You can adjust the BoxFit according to your needs
                      ),
                    ),
                  ),
                ),
              ),
            ),


            SizedBox(
              height: height * 0.02,
            ),
            loader == false
                ? Center(
              child: AppBtn(
                onTap: () {
                  usdtPay(widget.cont);
                },
                width: width * 0.8,
                title: "Confirm",
                gradient: AppColors.loginSecondryGrad,
                hideBorder: true,
              ),
            )
                : const Center(child: CircularProgressIndicator()),
            SizedBox(
              height: height * 0.03,
            )
          ],
        ),
      ),
    );
  }

  String myData = '0';
  void _updateImage(ImageSource imageSource) async {
    String? imageData =
    await ChooseImage.chooseImageAndConvertToString(imageSource);
    if (imageData != null) {
      setState(() {
        myData = imageData;
      });
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: height / 7,
            child: Padding(
              padding:
              EdgeInsets.fromLTRB(width / 12, 0, width / 12, height / 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _updateImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 20,
                      width: width / 2.7,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                            "Camera",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _updateImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 20,
                      width: width / 2.7,
                      decoration: BoxDecoration(
                          gradient: AppColors.primaryappbargrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                            "Gallery",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  UserViewProvider userProvider = UserViewProvider();

  Future<void> usdtPay(String amount) async {
    try {
      if (kDebugMode) {
        print("Initiating payment process...");
      }
      setState(() {
        loader = true;
      });
      UserModel user = await userProvider.getUser();
      String token = user.id.toString();

      if (kDebugMode) {
        print("User Token: $token");
      }

      final response = await http.post(
        Uri.parse(ApiUrl.usdtPayIn),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "user_id": token,
          "cash": amount,
          "screenshot": myData,
          "type":widget.type,

        }),
      );

      if (kDebugMode) {
        print("API URL: ${ApiUrl.usdtPayIn}");
        print("Response Status Code: ${response.statusCode}");
        print(token);
        print("user_id");
        print(amount);
        print("cash");
        print(myData);
        print("screenshot");
        print(widget.type);
        print("type");
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Response Data: $data");
        }
        setState(() {
          loader = true;
        });
        Navigator.pop(context);
        Utils.flushBarSuccessMessage(data["message"], context, Colors.white);
      } else {
        setState(() {
          loader = false;
        });
        Utils.flushBarErrorMessage(data["message"], context, Colors.white);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error occurred,ln9ibhionjiugv: $e");
      }
      setState(() {
        loader = false;
      });
      Utils.flushBarErrorMessage("An error occurred. Please try again.", context, Colors.white);
    }
  }

  // getImage() async {
  //   var res = await http.get(Uri.parse(ApiUrl.usdtViewQR));
  //   print(res.body);
  //   var data = jsonDecode(res.body)["data"][0];
  //   var dataOne = jsonDecode(res.body)["data"][1];
  //   print(data);
  //   setState(() {
  //     imagePath = widget.type==2?data["qr_code"]:dataOne["qr_code"];
  //     usdtAddress = widget.type==3?data["wallet_address"]:dataOne["wallet_address"];
  //   });
  //   print(imagePath);
  // }
  getImage() async {
    var res = await http.get(Uri.parse("${ApiUrl.usdtViewQR}type=${widget.type}"));
    print(res.body);
    var data = jsonDecode(res.body)["data"][0];
    print(data);
    setState(() {
      imagePath = data["qr_code"];
      usdtAddress = data["wallet_address"];
    });
    print(imagePath);
  }
}
