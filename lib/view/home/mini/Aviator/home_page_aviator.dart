// ignore_for_file: curly_braces_in_flow_control_structures, depend_on_referenced_packages, use_build_context_synchronously, non_constant_identifier_names
import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/marquee/marquee.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/app_constant.dart';
import 'package:theluckywin/res/components/audio.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/home/mini/Aviator/aviator_constant/aviator_assets.dart';
import 'package:theluckywin/view/home/mini/Aviator/aviator_model/result_history_model.dart';
import 'package:theluckywin/view/home/mini/Aviator/my_bet.dart';
import 'package:theluckywin/view/home/mini/Aviator/widget/small_toggel_switch.dart';
import 'package:theluckywin/view/home/mini/Aviator/widget/switch.dart';
import 'package:theluckywin/view/home/mini/Aviator/widget/toggel_switch.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameAviator extends StatefulWidget {
  const GameAviator({super.key});

  @override
  State<GameAviator> createState() => _GameAviatorState();
}

class AllBets {
  String? image;
  String? username;
  String? bet;
  String? win;
  AllBets(this.image, this.username, this.bet, this.win);
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _GameAviatorState extends State<GameAviator>
    with TickerProviderStateMixin {
  late final AnimationController _controllers =
      AnimationController(vsync: this, duration: const Duration(seconds: 1500))
        ..repeat();
  late final AnimationController _controllerFan = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 100))
    ..repeat();


  @override
  void initState() {
    super.initState();
    _isMounted = true;
    connectToServer();
    animationControl();
    planFlew();
    demoBet();
    resultHistory();
    Future.delayed(const Duration(seconds: 5), () {
      firstCome = true;
    });
  }

  SampleItem? selectedMenu;
  animation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
    animation();
  }

  late AnimationController _controllerFlew;
  late Animation<Offset> _animationFlew;
  // String betData1={"period":"1000000","bet":"10"};
  Map<String, dynamic> betData1 = {"period": "", "bet": ''};
  Map<String, dynamic> betData2 = {"period": "", "bet": ''};

  planFlew() {
    _controllerFlew = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationFlew = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(1.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controllerFlew,
      curve: Curves.easeInOut,
    ));
    Audio.aviatorplanmusic();
    _controllerFlew.forward();

  }

  animationControl() async {
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Set the animation duration
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: height * 0.3).animate(_controller);
    _animation.addListener(() {
      setState(() {});
      Future.delayed(const Duration(seconds: 5));
      _animation = Tween<double>(begin: height * 0.25, end: height * 0.30)
          .animate(_controller);
      animation();
      setState(() {
        first = false;
        widths = _animation.value;
      });
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    List dummyBets = dummyBet.reversed.toList();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: firstCome == false
          ? Scaffold(
              backgroundColor: AppColors.scaffolddark,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.aviatorAviatorwait,
                    height: height * 0.40,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffea0b3e)),
                        ),
                        child: const LinearProgressIndicator(
                          value: 1,
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
                        ),
                      ),
                      const Text('100%'),
                      // Text(' ${_linearProgressAnimation.value.toStringAsFixed(2)}%',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AviatorAssets.aviatorText,
                          height: height * 0.035),
                      Text(
                        " is a verifiably 100% ${AppConstants.appName}",
                        style: TextStyle(
                            fontSize: width * 0.04),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "If you find that the game has modified the game result and submit evidence to "
                      "customer service you can receive a maximum compensation of 100000 USDT",

                    ),
                  )
                ],
              ),
            )
          :
          // child:
          Scaffold(
              backgroundColor: const Color(0xff101011),
              appBar: AppBar(
                backgroundColor: Colors.white12,
                leading: const AppBackBtn(),
                automaticallyImplyLeading: false,
                title: const Image(
                  image: AssetImage(AviatorAssets.aviatorText),
                  fit: BoxFit.fitHeight,
                  width: 100,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AviatorAssets.howToPlay,
                        height: 35,
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Text(
                          context
                              .read<ProfileProvider>()
                              .totalWallet==null?'':
                        context
                            .read<ProfileProvider>()
                            .totalWallet
                            .toStringAsFixed(2),
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      const Text(
                        '₹',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              body: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    expansionWidget(),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: 'Round No :  ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${receiveData['period']}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              )),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.04,
                                width: width * 0.12,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 0),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Align icons in the center
                                    children: [
                                      // Icon(
                                      //   Icons.history,
                                      //   size: 18,
                                      //   color: Colors.grey.withOpacity(0.8),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5.0),
                                        child: Icon(
                                          isExpanded
                                              ? Icons.arrow_drop_up_rounded
                                              : Icons.arrow_drop_down_rounded,
                                          size: 35,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RichText(
                              text: const TextSpan(
                            text: 'Ping :  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "139ms",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: height * 0.44,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white12,
                            width: 4.0,
                            style: BorderStyle.solid), //Border.all
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: receiveData['status'] == 0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: height * 0.34,
                                  width: width * 0.98,
                                  child: Row(
                                    children: [
                                      Container(
                                          color: Colors.black,
                                          width: width * 0.05,
                                          height: height * 0.82,
                                          child: _rowMarquee()),
                                      Container(
                                        height: height * 0.82,
                                        width: width * 0.92,
                                        color: Colors.white,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: -width * 1.25,
                                              left: -width * 1.25,
                                              child: Container(
                                                  height: height * 2,
                                                  width: width * 2.5,
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  child: imageBg()),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: width * 0.05),
                                                child: Column(
                                                  children: [
                                                    AnimatedBuilder(
                                                        animation:
                                                            _controllerFan,
                                                        builder: (_, child) {
                                                          return Transform
                                                              .rotate(
                                                            angle:
                                                                _controllerFan
                                                                        .value *
                                                                    1 *
                                                                    math.pi,
                                                            child: Container(
                                                                height: 80,
                                                                width: 60,
                                                                decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            AviatorAssets.aviatorFanAviator)))),
                                                          );
                                                        }),
                                                    const Center(
                                                      child: Text(
                                                        'WAITING FOR NEXT ROUND',
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffea0b3e),
                                                            width: 1),
                                                      ),
                                                      child:
                                                          LinearProgressIndicator(
                                                        value: (receiveData[
                                                                'betTime'] *
                                                            0.01),
                                                        backgroundColor:
                                                            Colors.grey,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Color(
                                                                    0xffea0b3e)),
                                                        minHeight: 6,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      '00:${(receiveData['betTime'] * 0.01).toStringAsFixed(1)}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Image(
                                                        image: AssetImage(
                                                            AviatorAssets
                                                                .aviatorPlane),
                                                        height: 28,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.98,
                                  color: Colors.black,
                                  child: _buildMarquee(),
                                ),
                              ],
                            )
                          : receiveData['status'] == 1
                              ? Column(
                                  children: [
                                    // Text(
                                    //   "Period : ${receiveData['period']}",
                                    //   style:
                                    //       const TextStyle(color: Colors.white),
                                    // ),
                                    SizedBox(
                                      height: height * 0.34,
                                      width: width * 0.98,
                                      child: Row(
                                        children: [
                                          Container(
                                              color: Colors.black,
                                              width: width * 0.05,
                                              height: height * 0.82,
                                              child: _rowMarquee()),
                                          Container(
                                            height: height * 0.82,
                                            width: width * 0.92,
                                            color: Colors.white,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  bottom: -width * 1.25,
                                                  left: -width * 1.25,
                                                  child: Container(
                                                      height: height * 2,
                                                      width: width * 2.5,
                                                      color: Colors.black
                                                          .withOpacity(0.9),
                                                      child: imageBg()),
                                                ),
                                                SizedBox(
                                                  height: height * 0.92,
                                                  width: width * 0.94,
                                                  child: aviator(
                                                    height * 0.92,
                                                    width * 0.92,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${receiveData['timer']}X',
                                                    style: const TextStyle(
                                                        fontSize: 50,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.98,
                                      color: Colors.black,
                                      child: _buildMarquee(),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      "Period : '${receiveData['period']}X'",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: height * 0.34,
                                      width: width * 0.98,
                                      child: Row(
                                        children: [
                                          Container(
                                              color: Colors.black,
                                              width: width * 0.05,
                                              height: height * 0.82,
                                              child: _rowMarquee()),
                                          Stack(
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  height: height * 0.80,
                                                  width: width * 0.89,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SlideTransition(
                                                        position:
                                                            _animationFlew,
                                                        child: const Center(
                                                          child: Image(
                                                            image: AssetImage(
                                                                AviatorAssets
                                                                    .aviatorPlane),
                                                            height: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                              "Flew Away !",
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                      .white)),
                                                          Text(
                                                            '${receiveData['timer']}',
                                                            style: const TextStyle(
                                                                fontSize: 45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.06,
                                      width: width * 0.98,
                                      color: Colors.black,
                                      child: _buildMarquee(),
                                    ),
                                  ],
                                ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: betButton(),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: betButtonTwo(),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                        width: width,
                        decoration: const BoxDecoration(
                            color: Color(0xff1b1c1d),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            betHistory(),
                            _isSecondPage
                                ? const MyBetPage()
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "ALL BETS",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text(
                                          "326658",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Divider(
                                            height: height * 0.02,
                                            thickness: 2,
                                            color: const Color(0xff141516)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: width * 0.3,
                                                child: const Text("User",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: width * 0.3,
                                                child: const Text("Bet,₹ X",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: width * 0.3,
                                                child: const Text("Cash out, ₹",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 500,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              reverse: false,
                                              itemCount: dummyBets.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 2),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                        color: dummyBets[index]
                                                                    .color ==
                                                                0
                                                            ? Colors.black
                                                            : const Color(
                                                                0xff123304),
                                                        border: Border.all(
                                                            color: dummyBets[index]
                                                                        .color ==
                                                                    0
                                                                ? Colors.white60
                                                                : const Color(
                                                                    0xff406b1f),
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            height: 25,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            width: width * 0.3,
                                                            child: Text(
                                                                dummyBets[index]
                                                                    .name
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12))),
                                                        Container(
                                                            height: 25,
                                                            alignment: Alignment
                                                                .center,
                                                            width: width * 0.2,
                                                            child: Text(
                                                                dummyBets[index]
                                                                    .amount
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12))),
                                                        Container(
                                                            height: 25,
                                                            alignment: Alignment
                                                                .center,
                                                            width: width * 0.1,
                                                            child: Text(
                                                                dummyBets[index]
                                                                    .x
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12))),
                                                        Container(
                                                            height: 25,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            width: width * 0.2,
                                                            child: Text(
                                                                dummyBets[index]
                                                                    .winners
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12))),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ))
                  ],
                ),
              ),
            ),
    );
  }

  aviator(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        alignment: Alignment.bottomLeft,
        height: _animation.value,
        width: _animation.value,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              painter: MyPainter(_animation.value),
              size: Size(_animation.value, _animation.value / 1.5),
            ),
            Positioned(
                right: -width * 0.2,
                top: -height * 0.10,
                child: const Image(
                    image: AssetImage(AviatorAssets.aviatorPlane),
                    height: 40,
                    width: 100)),
          ],
        ),
      ),
    );
  }

  bool _isToggled = false;
  bool _isToggledTwo = false;
  bool bet = false;
  bool betTwo = false;
  bool autoBet = false;
  String changeColor = "";
  String changeColorTwo = "";
  bool autoCas = false;
  bool autoCasTwo = false;
  bool firstCome = false;
  bool betFind1 = false;
  bool betFind2 = false;
  bool autoPlay1 = true;
  bool autoPlay2 = true;
  void autoPlayButton1() {
    setState(() {
      autoPlay1 = !autoPlay1;
    });

  }
  void autoPlayButton2() {
    setState(() {
      autoPlay2 = !autoPlay2;
    });
  }

  TextEditingController amount = TextEditingController(text: '10');
  TextEditingController amountTwo = TextEditingController(text: '10');
  TextEditingController autoValue = TextEditingController(text: '1.10');
  TextEditingController autoValueTwo = TextEditingController(text: '1.10');

  final bool _useRtlText = false;
  bool isExpanded = false;
  bool _isSecondPage = false;
  List<BetList> betList = [];
  int value = 1;
  int value1 = 1;
  int selectedAmount = 10;
  int selectedAmount1 = 10;
  // bool cashOutOne=false;
  bool cashout = false;
  bool cashOutTwo = false;
  bool betplaced = false;
  bool betPlacedTwo = false;
  bool autoBetCashOut = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  bool first = true;
  void increment() {
    setState(() {
      value = value + 1;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (value > 0) {
        value = value - 1;
        deductAmount();
      }
    });
  }

  void selectAmount(int amount) {
    setState(() {
      selectedAmount = amount;
      value = 1;
    });
    deductAmount();
  }

  void deductAmount() {
    int amountToDeduct = selectedAmount * value;
    if (context.read<ProfileProvider>().totalWallet >= amountToDeduct) {
      setState(() {
        amount.text = (selectedAmount * value).toString();
      });
      context.read<ProfileProvider>().totalWallet;
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  void increment1() {
    setState(() {
      value1 = value1 + 1;
      deductAmount1();
    });
  }

  void decrement1() {
    setState(() {
      if (value1 > 0) {
        value1 = value1 - 1;
        deductAmount1();
      }
    });
  }

  void selectAmount1(int amount) {
    setState(() {
      selectedAmount1 = amount;
      value1 = 1;
    });
    deductAmount1();
  }

  void deductAmount1() {
    int amountToDeduct = selectedAmount1 * value1;
    if (context.read<ProfileProvider>().totalWallet >= amountToDeduct) {
      setState(() {
        amountTwo.text = (selectedAmount1 * value1).toString();
      });
      context.read<ProfileProvider>().totalWallet;
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  List<int> list = [10, 100, 500, 1000];
  List<int> list2 = [10, 100, 500, 1000];

  void _toggleSwitch(bool value) {
    setState(() {
      _isSecondPage = value;
    });
  }

  void _smallToggleSwitch(bool smallValue) {
    setState(() {
      _isToggled = smallValue;
      if(_isToggled==false){
        autoCas = false;
        autoPlay1=true;
      }
    });
  }

  void _smallToggleSwitchTwo(bool smallValueTwo) {
    setState(() {
      _isToggledTwo = smallValueTwo;
      if(_isToggledTwo==false){
        autoCasTwo = false;
        autoPlay2=true;
      }

    });
  }

  double timer = 0.0;
  int betTime = 0;
  Widget buildTime5sec(int time) {
    Duration myDuration = Duration(seconds: time);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard5sec(time: seconds[0].toString(), header: 'SECONDS'),
      const SizedBox(
        width: 15,
      ),
      buildTimeCard5sec(time: seconds[1].toString(), header: 'SECONDS'),
    ]);
  }

  late IO.Socket _socket;
  dynamic receiveData = {};
  bool _isMounted = false;
  autocashoutfun(String data) {
    if (cashout == false) {
      if (double.parse(data) >= double.parse(autoValue.text)) {
        setState(() {
          cashout = true;
          betplaced = false;
        });
        cashOut(betData1['bet'].toString(), autoValue.text, '1');
      }
    }
  }

  autocashoutfunTwo(String data) {
    if (cashOutTwo == false) {
      if (double.parse(data) >= double.parse(autoValueTwo.text)) {
        setState(() {
          cashOutTwo = true;
          betPlacedTwo = false;
        });
        cashOut(betData2['bet'].toString(),autoValueTwo.text, '2');
      }
    }
  }

  void connectToServer() {
    _socket = IO.io(
      // ApiUrl.aviatorWebSocket,
        context.read<ProfileProvider>().aviatorLink.toString(),
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    _socket.on('connect', (_) {
      if (kDebugMode) {
      }
    });
    _socket.onConnectError((data) {
      if (kDebugMode) {
      }
    });
    _socket.on(context.read<ProfileProvider>().aviatorEventName.toString(), (data) {
      if (_isMounted) {
        setState(() {
          receiveData = jsonDecode(data);
        });
      }
      if (_isMounted &&receiveData['status'] == 1) {


        if (_isMounted && autoValue.text != "1.01" && autoCas == true) {
          autocashoutfun(receiveData['timer'].toString());
          autocashoutfunTwo(receiveData['timer'].toString());

        }
        if (_isMounted && autoValue.text != "1.01" && autoCasTwo == true) {
          autocashoutfunTwo(receiveData['timer'].toString());
        }
        if (_isMounted) {
          setState(() {
            timer = double.parse(receiveData['timer'].toString());
            betplaced = false;
            betPlacedTwo = false;
          });
          demoBetRemove();
        }

      }
      if (receiveData['status'] == 1 && receiveData['timer'] == '1.00') {
        _controller.reset();
        dummyBet.clear();
        animationControl();
        bet == true ? changeColor = "1" : changeColor = "2";
        betTwo == true ? changeColorTwo = "1" : changeColorTwo = "2";
      }
      if (receiveData['status'] == 0) {
        if (_isMounted) {
          setState(() {
            betTime = receiveData['betTime'];
            autoBetCashOut = false;
            betplaced = true;
            betPlacedTwo = true;
          });
          demoBet();
          if(betTime==99){
            resultHistory();
            if(autoPlay2==false) {
              addBet(
                  amountTwo.text,
                  '2',
                  receiveData['period'].toString(),
                  receiveData['status'].toString());
            }
            if(autoPlay1==false) {
              addBet(
                  amount.text,
                  '1',
                  receiveData['period'].toString(),
                  receiveData['status'].toString());
            }
          }


        }
        // changeColor="0";
      }
      if (receiveData['status'] == 2) {
        bet = false;
        betTwo = false;
        dummyBet.clear();
        planFlew();

        if (_isMounted) {
          setState(() {
            betplaced = false;
            betPlacedTwo = false;
            cashout = false;
            cashOutTwo = false;
          });
        }
        if (betData1['period'].toString() == receiveData['period'].toString() && receiveData['betTime']==30) {
          if (_isMounted) {
            setState(() {
              betData1 = {
                "period": '',
                "bet": '',
              };
            });
          }
        }

        if (betData2['period'].toString() == receiveData['period'].toString() && receiveData['betTime']==30) {
          if (_isMounted) {
            setState(() {
              betData2 = {
                "period": '',
                "bet": '',
              };
            });
          }
        }
      }
    });
    _socket.connect();
  }

  Widget buildTimeCard5sec({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 40),
            ),
          )
        ],
      );

  Widget betHistory() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: SlidingSwitch(
          value: _isSecondPage,
          width: width * 0.8,
          onChanged: _toggleSwitch,
          height: height * 0.04,
          animationDuration: const Duration(milliseconds: 400),
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
          textOff: "All Bet",
          textOn: "My Bet",
          colorOn: Colors.white,
          colorOff: Colors.white,
          background: const Color(0xff141516),
          buttonColor: const Color(0xff2c2d30),
          inactiveColor: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget expansionWidget() {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: isExpanded
          ? const Text("Round History",
              style: TextStyle(fontSize: 12, color: Colors.white))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.05,
                  width: width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: number.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final double price = number[index].price;
                        Color textColor;
                        if (price > 1 && price < 2) {
                          textColor = Colors.blue;
                        } else if (price >= 2 && price < 10) {
                          textColor = Colors.purple;
                        } else {
                          textColor = Colors.pink;
                        }
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: height * 0.02,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xff080808),
                              // border: Border.all(
                              //     color: Colors.grey.withOpacity(0.2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Center(
                              child: Text(
                                '${number[index].price.toStringAsFixed(2)} X',
                                style:
                                    TextStyle(fontSize: 14, color: textColor),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      trailing: Container(
        alignment: Alignment.center,
        height: height * 0.04,
        width: width * 0.15,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                MainAxisAlignment.center, // Align icons in the center
            children: [
              Icon(
                Icons.history,
                size: 18,
                color: !isExpanded ? Colors.grey.withOpacity(0.8) : Colors.pink,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Icon(
                  isExpanded
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  size: 30,
                  color:
                      !isExpanded ? Colors.grey.withOpacity(0.8) : Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xff262830),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: number.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 2,
              childAspectRatio: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              final double price = number[index].price;
              Color textColor;
              if (price > 1 && price < 2) {
                textColor = Colors.blue;
              } else if (price >= 2 && price < 10) {
                textColor = Colors.purple;
              } else {
                textColor = Colors.pink;
              }
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: height * 0.02,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xff080808),

                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Center(
                    child: Text(
                      '${number[index].price.toStringAsFixed(2)} X',
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                  ),
                ),
              );
              //   Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: Container(
              //     height: height*0.2,
              //     padding: EdgeInsets.only(left: 8,right: 8),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: Colors.grey.withOpacity(0.1),
              //       border: Border.all(color: Colors.grey.withOpacity(0.2)),
              //       borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     ),
              //     child: Text(
              //       '${number[index].price} x',
              //       style: TextStyle(
              //           fontSize: 14, color: RandomColor().getColor()),
              //     ),
              //   ),
              // );
            },
          ),
        ),
      ],
    );
  }

  Widget betButton() {
    return Container(
      width: width,
      // height: height * 0.6,
      decoration: BoxDecoration(
          border: Border.all(
              color: changeColor == '0'
                  ? Colors.red
                  : changeColor == "1"
                      ? const Color(0xffd07206)
                      : Colors.transparent,
              width: 1),
          color: const Color(0xff1b1c1d),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: SmallSlidingSwitch(
                value: _isToggled,
                width: width * 0.70,
                onChanged: _smallToggleSwitch,
                contentSize: 18,
                height: height * 0.035,
                animationDuration: const Duration(milliseconds: 400),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
                textOff: "Bet",
                textOn: "Auto",
                colorOn: Colors.white,
                colorOff: Colors.white,
                background: const Color(0xff141516),
                buttonColor: const Color(0xff2c2d30),
                inactiveColor: Colors.grey.withOpacity(0.5),
              ),
            ),
            const Divider(
              color: Colors.transparent,
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: height * 0.042,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                            color: const Color(0xff080808),
                            // border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                  onTap: decrement,
                                  child: Image(
                                    image: const AssetImage(
                                      AviatorAssets.aviatorMinus,
                                    ),
                                    height: height * 0.024,
                                  )),
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: width * 0.280,
                              child: TextFormField(
                                controller: amount,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: InkWell(
                                  onTap: increment,
                                  child: Image(
                                      image: const AssetImage(
                                          AviatorAssets.aviatorPlus),
                                      height: height * 0.024)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 3,
                    ),
                    SizedBox(
                      // color: Colors.red,
                      height: height * 0.07,
                      width: width * 0.4,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 3.3,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAmount = list[index];
                                });
                                selectAmount(selectedAmount);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xff141516),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  // border: Border.all(
                                  //     color: Colors.grey.withOpacity(0.3)),
                                ),
                                child: Center(
                                  child: Text(
                                    ' ${list[index]}',
                                    style: const TextStyle(
                                        color: Color(0xff676869),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: widths * 0.03,
                ),

                if (betData1['period'].toString() == '' ||
                    int.parse(betData1['period'].toString()) <
                        int.parse(receiveData['period'].toString()))
                  InkWell(
                      onTap: () {
                        //
                        setState(() {
                          bet = true;
                          changeColor = "0";
                        });
                        if (amount.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              'Select Amount First..!', context, Colors.white);
                        } else if (amount.text == '0') {
                          Utils.flushBarErrorMessage(
                              'Select Amount First..!', context, Colors.white);
                        } else if (context
                                .read<ProfileProvider>()
                                .totalWallet ==
                            0) {
                          Utils.flushBarErrorMessage(
                              'Please recharge first', context, Colors.white);
                        } else {
                          addBet(
                              amount.text,
                              '1',
                              receiveData['period'].toString(),
                              receiveData['status'].toString());
                        }
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff84d571),
                                blurRadius: 2.0,
                                // offset: const Offset(4,4),/
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 1, color: Colors.white),
                            color: Color(0xff28a809)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BET',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text("${amount.text}.00₹",
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ],
                        ),
                      ))
                else if (betData1['period'].toString() != '' &&
                        (int.parse(betData1['period'].toString()) ==
                                int.parse(receiveData['period'].toString()) &&
                            receiveData['status'] < 1) ||
                    (int.parse(betData1['period'].toString()) ==
                        int.parse(receiveData['period'].toString()) + 1))
                  InkWell(
                      onTap: () {
                        cancelBet('1');
                        bet = false;
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffd42c41),
                                blurRadius: 2.0,
                                // offset: const Offset(4,4),/
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 1, color: Colors.white),
                            color: Colors.red),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ))
                else if (receiveData['status'] == 1 &&
                    betData1['period'].toString() ==
                        receiveData['period'].toString())
                  InkWell(
                      onTap: () {
                        cashOut(betData1['bet'].toString(),
                            receiveData['timer'], '1');
                        setState(() {
                          changeColor = "2";
                          bet = false;
                        });
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffd88a31),
                                blurRadius: 2.0,
                                // offset: const Offset(4,4),/
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 2, color: Colors.white),
                            color: Color(0xffd07206)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Cash Out',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                                (int.parse(betData1['bet'].toString()) *
                                        double.parse(receiveData['timer']))
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ],
                        ),
                      ))

              ],
            ),
            !_isToggled
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 3, right: 2),
                    child: Column(
                      children: [


                        const Divider(
                          color: Color(0xff141516),
                          height: 10,
                          thickness: 2,
                        ),
                        Row(
                          children: [

                            InkWell(
                              onTap: autoPlayButton1,
                              child:
                              autoPlay1==true?Container(
                                padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1d7aca),
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "AUTO PLAY  ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ):
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.btnColor,
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Stop Auto",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),

                            ),



                            const Text(
                              "      Auto Cash Out ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            CustomSwitch(
                              width: width * 0.1,
                              height: height * 0.025,
                              toggleSize: height * 0.015,
                              value: autoCas,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: Colors.white,
                              switchBorder: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              toggleBorder: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              activeColor: Colors.green,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              onToggle: (val) {
                                setState(() {
                                  autoCas = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Container(
                              height: height * 0.04,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                  color: const Color(0xff020202),
                                  borderRadius: BorderRadius.circular(40)),
                              child: TextFormField(
                                controller: autoValue,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  suffix: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            autoValue.clear();
                                          });
                                        },
                                        child: const Text(
                                          "x",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey),
                                        )),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                              // TextFormField(
                              //   enabled: autoCas,
                              //   controller: autoValue,
                              //   textAlign: TextAlign.center,
                              //   style: const TextStyle(
                              //       fontSize: 15, color: Colors.white),
                              //   textAlignVertical: TextAlignVertical.top,
                              //   keyboardType: TextInputType.number,
                              //   // style: RighteousMedium.copyWith(fontSize: heights * 0.019, color: Colors.white),
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.all(0),
                              //     suffix: InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             autoValue.clear();
                              //           });
                              //         },
                              //         child: const Icon(
                              //           Icons.cancel,
                              //           size: 22,
                              //         )),
                              //     enabledBorder: const OutlineInputBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(40.0)),
                              //       borderSide: BorderSide(
                              //           color: Colors.white, width: 1),
                              //     ),
                              //     focusedBorder: const OutlineInputBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(20.0)),
                              //       borderSide: BorderSide(
                              //           color: Colors.white, width: 1),
                              //     ),
                              //     border: const OutlineInputBorder(
                              //       borderSide: BorderSide(color: Colors.white),
                              //       borderRadius: BorderRadius.all(
                              //         Radius.circular(12.0),
                              //       ),
                              //     ),
                              //     focusedErrorBorder: const OutlineInputBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(15.0)),
                              //       borderSide:
                              //           BorderSide(color: Color(0xFFF65054)),
                              //     ),
                              //     errorBorder: const OutlineInputBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(12.0)),
                              //       borderSide:
                              //           BorderSide(color: Color(0xFFF65054)),
                              //     ),
                              //     hintStyle: const TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w400),
                              //     fillColor: Colors.grey.withOpacity(0.3),
                              //     filled: true,
                              //   ),
                              // ),
                            ),
                            // Positioned(
                            //   right: widths*0.02,
                            //     child: InkWell(
                            //   onTap: (){},
                            //   child: Icon(Icons.cancel_outlined),
                            // )),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget betButtonTwo() {
    return Container(
      width: width,
      // height: height * 0.6,
      decoration: BoxDecoration(
          border: Border.all(
              color: changeColorTwo == '0'
                  ? Colors.red
                  : changeColorTwo == "1"
                      ? const Color(0xffd07206)
                      : Colors.transparent,
              width: 1),
          color: const Color(0xff1b1c1d),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: SmallSlidingSwitch(
                value: _isToggledTwo,
                width: width * 0.70,
                onChanged: _smallToggleSwitchTwo,
                contentSize: 18,
                height: height * 0.035,
                animationDuration: const Duration(milliseconds: 400),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
                textOff: "Bet",
                textOn: "Auto",
                colorOn: Colors.white,
                colorOff: Colors.white,
                background: const Color(0xff141516),
                buttonColor: const Color(0xff2c2d30),
                inactiveColor: Colors.grey.withOpacity(0.5),
              ),
            ),
            const Divider(
              color: Colors.transparent,
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: height * 0.042,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                            color: const Color(0xff080808),
                            // border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                  onTap: decrement1,
                                  child: Image(
                                    image: const AssetImage(
                                      AviatorAssets.aviatorMinus,
                                    ),
                                    height: height * 0.024,
                                  )),
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: width * 0.280,
                              child: TextFormField(
                                controller: amountTwo,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: InkWell(
                                  onTap: increment1,
                                  child: Image(
                                      image: const AssetImage(
                                          AviatorAssets.aviatorPlus),
                                      height: height * 0.024)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 3,
                    ),
                    SizedBox(
                      // color: Colors.red,
                      height: height * 0.07,
                      width: width * 0.4,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 3.3,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAmount1 = list2[index];
                                });
                                selectAmount1(selectedAmount1);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xff141516),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  // border: Border.all(
                                  //     color: Colors.grey.withOpacity(0.3)),
                                ),
                                child: Center(
                                  child: Text(
                                    ' ${list2[index]}',
                                    style: const TextStyle(
                                        color: Color(0xff676869),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  width: widths * 0.03,
                ),
                if (betData2['period'].toString() == '' ||
                    int.parse(betData2['period'].toString()) <
                        int.parse(receiveData['period'].toString()))
                  InkWell(
                      onTap: () {
                        //
                        setState(() {
                          betTwo = true;
                          changeColorTwo = "0";
                        });
                        if (amountTwo.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              'Select Amount First..!', context, Colors.white);
                        } else if (amountTwo.text == '0') {
                          Utils.flushBarErrorMessage(
                              'Select Amount First..!', context, Colors.white);
                        } else if (context
                                .read<ProfileProvider>()
                                .totalWallet ==
                            0) {
                          Utils.flushBarErrorMessage(
                              'Please recharge first', context, Colors.white);
                        } else {
                          addBet(
                              amountTwo.text,
                              '2',
                              receiveData['period'].toString(),
                              receiveData['status'].toString());
                        }
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff84d571),
                                blurRadius: 2.0,
                                // offset: const Offset(4,4),/
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 1, color: Colors.white),
                            color: Color(0xff28a809)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BET',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text("${amountTwo.text}.00₹",
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ],
                        ),
                      ))
                else if (betData2['period'].toString() != '' &&
                        (int.parse(betData2['period'].toString()) ==
                                int.parse(receiveData['period'].toString()) &&
                            receiveData['status'] < 1) ||
                    (int.parse(betData2['period'].toString()) ==
                        int.parse(receiveData['period'].toString()) + 1))
                  InkWell(
                      onTap: () {
                        cancelBet('2');
                        betTwo = false;
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffd42c41),
                                blurRadius: 2.0,
                                // offset: const Offset(4,4),/
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 1, color: Colors.white),
                            color: Colors.red),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ))
                else if (receiveData['status'] == 1 &&
                    betData2['period'].toString() ==
                        receiveData['period'].toString())
                  InkWell(
                      onTap: () {
                        cashOut(betData2['bet'].toString(),
                            receiveData['timer'], '2');
                        setState(() {
                          changeColorTwo = "2";
                          betTwo = false;
                        });
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffd88a31),
                                blurRadius: 2.0,
                                // offset: const Offset(4,4),/
                              ),
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 2, color: Colors.white),
                            color: Color(0xffd07206)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Cash Out',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                                (int.parse(betData2['bet'].toString()) *
                                        double.parse(receiveData['timer']))
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ],
                        ),
                      ))
              ],
            ),
            !_isToggledTwo
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 3, right: 2),
                    child: Column(
                      children: [
                        const Divider(
                          color: Color(0xff141516),
                          height: 10,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: autoPlayButton2,
                              child:
                              autoPlay2==true?Container(
                                padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1d7aca),
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "AUTO PLAY  ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ):
                              Container(
                                padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.btnColor,
                                    // border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Stop Auto",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),

                            ),

                            const Text(
                              "      Auto Cash Out ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            CustomSwitch(
                              width: width * 0.1,
                              height: height * 0.025,
                              toggleSize: height * 0.015,
                              value: autoCasTwo,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: Colors.white,
                              switchBorder: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              toggleBorder: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              activeColor: Colors.green,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              onToggle: (val) {
                                setState(() {
                                  autoCasTwo = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Container(
                              height: height * 0.04,
                              width: width * 0.25,
                              decoration: BoxDecoration(
                                  color: const Color(0xff020202),
                                  borderRadius: BorderRadius.circular(40)),
                              child: TextFormField(
                                controller: autoValueTwo,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  suffix: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            autoValue.clear();
                                          });
                                        },
                                        child: const Text(
                                          "x",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.grey),
                                        )),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   right: widths*0.02,
                            //     child: InkWell(
                            //   onTap: (){},
                            //   child: Icon(Icons.cancel_outlined),
                            // )),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarquee() {
    return CustomMarquee(
      key: Key("$_useRtlText"),
      text: '🏐',
      style: const TextStyle(
          fontWeight: FontWeight.w900, fontSize: 4, color: Colors.white),
      velocity: 30.0,
      blankSpace: width * 0.15,
    );
  }

  Widget imageBg() {
    return AnimatedBuilder(
        animation: _controllers,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controllers.value * 170 * math.pi,
            child: const Image(
              image: AssetImage(AviatorAssets.aviatorChakra),
            ),
          );
        });
  }

  Widget _rowMarquee() {
    return CustomMarquee(
      key: Key("$_useRtlText"),
      text: '.',
      style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 30,
          color: Colors.blueAccent.shade700),
      velocity: 30.0,
      textDirection: TextDirection.rtl,
      scrollAxis: Axis.vertical,
      blankSpace: height * 0.02,
    );
  }

  double widths = 0;

  Aviator(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        alignment: Alignment.bottomLeft,
        height: _animation.value,
        width: _animation.value,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            first == true
                ? CustomPaint(
                    painter: MyPainter(_animation.value),
                    size: Size(_animation.value, _animation.value / 1.5),
                  )
                : CustomPaint(
                    painter: MyPainter(_animation.value),
                    size: Size(widths + (widths - _animation.value),
                        _animation.value / 1.5),
                  ),
            Positioned(
                right: -width * 0.2,
                top: -height * 0.10,
                child: const Image(
                    image: AssetImage(AviatorAssets.aviatorPlane),
                    height: 40,
                    width: 100)),
          ],
        ),
      ),
    );
  }

  var rnd = Random();

  List<Demo> dummyBet = [];

  Future cashOut(String amount, String times, String betNo) async {

    if((betNo == '1' && betFind1 == true) || (betNo == '2' && betFind2 == true))  {
      UserModel user = await userProvider.getUser();
      String userid = user.id.toString();
      var gameNo = receiveData['period'].toString();
      if (betNo == '1') {
        setState(() {
          betFind1 = false;
          betData1 = {
            "period": '',
            "bet": '',
          };
        });
      } else {
        setState(() {
          betFind2 = false;
          betData2 = {
            "period": '',
            "bet": '',
          };
        });
      }
      Map<String, dynamic> data2 = {
        "uid": userid,
        "multiplier": times,
        "game_sr_num": gameNo,
        "number": betNo
      };
      String jsonData = jsonEncode(data2);
      String encodedData = base64.encode(utf8.encode(jsonData));

      final response =
      await http.get(Uri.parse('${ApiUrl.aviatorBetCashOut}$encodedData'));
      final data = jsonDecode(response.body);

      if (data["status"] == 200) {
        context.read<ProfileProvider>().fetchProfileData();
        setState(() {
          autoBetCashOut = true;
        });
        Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
      } else {
        Utils.flushBarErrorMessage(data['message'], context, Colors.black);
      }
    }
  }

  Future cancelBet(String betNo) async {
    if (betNo == '1') {
      setState(() {
        betFind1=false;
        betData1 = {
          "period": '',
          "bet": '',
        };
      });
    } else {
      setState(() {
        betFind2=false;
        betData2 = {
          "period": '',
          "bet": '',
        };
      });
    }
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    var gameNo = receiveData['period'];
    final response = await http.get(Uri.parse(
        '${ApiUrl.aviatorBetCancel}$userid&gamesno=$gameNo&number=$betNo'));
    final data = jsonDecode(response.body);
    if (data["status"] == 200) {
      context.read<ProfileProvider>().fetchProfileData();
      Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  addBet(String amount, String betNo, String period, String status) async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    String perios = period;
    if (status != '1') {
      if (betNo == '1') {
        setState(() {
          betFind1=true;

          betData1 = {
            "period": period,
            "bet": amount,
          };
        });
      } else {
        setState(() {
          betFind2=true;
        betData2 = {
            "period": period,
            "bet": amount,
          };
        });
      }
    } else {
      setState(() {
        perios = (int.parse(period) + 1).toString();
      });
      if (betNo == '1') {
        setState(() {
          betFind1=true;
          betData1 = {
            "period": perios,
            "bet": amount,
          };
        });
      } else {
        setState(() {
          betFind2=true;

          betData2 = {
            "period": perios,
            "bet": amount,
          };
        });
      }
    }

    final response = await http.get(Uri.parse(
        '${ApiUrl.aviatorBet}$userid&number=$betNo&amount=$amount&game_id=5&game_sr_num=$perios'));
    final resData = jsonDecode(response.body);
    if (resData["status"] == 200) {
      context.read<ProfileProvider>().fetchProfileData();
      Utils.flushBarSuccessMessage(resData['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(resData['message'], context, Colors.black);
    }
  }

  demoBet() async {
    int memId = rnd.nextInt(2000);
    int amount = rnd.nextInt(9);
    // await Future.delayed(const Duration(milliseconds: 500));
    if (betTime % 2 != 0 && amount != 0) {
      dummyBet.add(Demo(
          name: 'MemberId$memId',
          amount: double.parse((amount * 10).toString()),
          x: '',
          winners: '',
          color: 0));
      setState(() {});
    }
  }

  demoBetRemove() async {

    int memId = rnd.nextInt(2000);
    int amount = rnd.nextInt(9);
    if (timer.toStringAsFixed(2).split('.').last.split('').last == '5' ||
        timer.toStringAsFixed(2).split('.').last.split('').last == '0') {
      double amountnew = double.parse((amount * 10).toString());
      dummyBet.add(Demo(
          name: 'MemberId$memId',
          amount: amountnew,
          x: timer.toStringAsFixed(2),
          winners: (timer * amountnew).toStringAsFixed(2),
          color: 1));
      setState(() {});
    }
  }

  @override
  void dispose() {
    _socket.disconnect();
    _isMounted = false;
    _controller.dispose();
    _controllerFlew.dispose();
    Audio.audioPlayers.stop();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }

  List<ResultHistoryModel> number = [];
  Future<void> resultHistory() async {
    context.read<ProfileProvider>().fetchProfileData();
    const url = ApiUrl.aviatorResult;
    //'https://admin.aviatorays.in/api/aviator/last_five_result';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        number = responseData.map((data) => ResultHistoryModel.fromJson(data)).toList();
      });

    } else if (response.statusCode == 400) {
      // Handle 400 status code
    } else {
      setState(() {
        number = [];
      });
      throw Exception('Failed to load data');
    }
  }

  UserViewProvider userProvider = UserViewProvider();
}


class Demo {
  String name;
  double amount;
  String x;
  String winners;
  int color;
  Demo(
      {required this.name,
      required this.amount,
      required this.x,
      required this.winners,
      required this.color});
}

class MyPainter extends CustomPainter {
  final double animationValue;

  MyPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final path = drawPath(size.width, size.height, animationValue);

    final paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.red.shade900 // Change border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Change border width

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Path drawPath(double canvasWidth, double chartHeight, double animationValue) {
  final path = Path();
  final segmentWidth = canvasWidth / 2 / 2;
  path.moveTo(0, chartHeight);
  path.cubicTo(
    segmentWidth,
    chartHeight,
    4 * segmentWidth,
    80,
    canvasWidth,
    0,
  );
  path.lineTo(canvasWidth, chartHeight);
  path.close();

  return path;
}

class BetList {
  final String name;
  final int amount;
  final double cashOut;
  BetList({required this.name, required this.amount, required this.cashOut});
}
