import 'dart:async';

import 'package:flutter/material.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/media_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/res/aap_colors.dart';
import '../../utils/routes/routes_name.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _loginState();
}

class _loginState extends State<splash> {
  @override
  void initState() {
    super.initState();
    harsh();
  }

  harsh() async{
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("token")??'0';

    Timer(const Duration(seconds: 3),
            ()=>userid !='0'? Navigator.pushNamed(context, RoutesName.bottomNavBar)
            : Navigator.pushNamed(context, RoutesName.loginScreen)
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            body:Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height*0.2,
                    ),
                    Container(
                      height: height * 0.45,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesSplashImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text('Lucky Win',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 25),)

                  ],
                ),
              ),
            ),
        ));
  }
}

