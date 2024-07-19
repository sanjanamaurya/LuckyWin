import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_field.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:http/http.dart'as http;

class NickNamePopUp extends StatefulWidget {
  const NickNamePopUp({super.key});

  @override
  State<NickNamePopUp> createState() => _NickNamePopUpState();
}



class _NickNamePopUpState extends State<NickNamePopUp> {

  TextEditingController nameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: ListView(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*0.2,),
            Container(
              height: height*0.5,
              decoration: BoxDecoration(
                  color: Color(0xff6d81ff),
                  borderRadius: BorderRadius.circular(15)
              ),
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(height: 1,width: width*0.07,color: Colors.white,),
                        const Text('Change NickName',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                        Container(height: 1,width: width*0.07,color: Colors.white,)
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    width: width*0.7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height*0.06,),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: width*0.13,
                              decoration:  const BoxDecoration(
                                  image: DecorationImage(image: AssetImage(Assets.iconsDialogNickname))
                              ),
                            ),
                            const Text("Nickname",
                                style: TextStyle(

                                    fontSize:16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        SizedBox(height: height*0.02,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: CustomTextField(
                            fillColor: Colors.grey.withOpacity(0.2),
                            controller: nameCon,
                            filled: true,
                            focusColor: Colors.white,
                            maxLines: 1,
                            hintText: context.watch<ProfileProvider>().userName.toString(),
                          ),
                        ),

                const Spacer(),
                        AppBtn(
                          height: 50,
                          title: 'Confirm',
                          fontSize: 20,
                          titleColor: Colors.white,
                          hideBorder: true,
                          onTap: () {
                            avtarChangeApi(nameCon.text);
                          },
                          gradient: AppColors.loginSecondryGrad,
                        ),
                        SizedBox(height: height*0.02,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.cancel_outlined,size: 35,color: Colors.white,),),
            )
          ],
        ),
      ),
    );
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();

  UserViewProvider userProvider = UserViewProvider();
  avtarChangeApi( String nickname) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.UpdateAvtarApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
        "username": nickname,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    if (data["status"] == 200) {
      context.read<ProfileProvider>().fetchProfileData();
      Navigator.pop(context);
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }
}