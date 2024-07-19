// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/result_game_history.dart';
import 'package:theluckywin/model/user_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/api_urls.dart';
import 'package:theluckywin/res/components/audio.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/profile_provider.dart';
import 'package:theluckywin/res/provider/user_view_provider.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/Image_tost.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/dragonTost.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/dragon_tiger_Assets.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/fade_animation.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/glory_border.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/coin/single_coin.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/dragon_game_history.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/random_person.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/stroke_test.dart';
import 'package:theluckywin/view/home/dragon_tiger_new/widgets/updown_border.dart';
import 'coin/distribute_coin.dart';
import 'widgets/dragon_tiger_timer.dart';
import 'package:http/http.dart' as http;

class DragonTiger extends StatefulWidget {
  final String gameId;
  const DragonTiger({Key? key, required this.gameId}) : super(key: key);

  @override
  State<DragonTiger> createState() => _DragonTigerState();
}

class _DragonTigerState extends State<DragonTiger> {
  int selectedIndex = 0;
  late int coinVal;
  int setTimeValue = 0;

  bool _isActionExecuted = false;
  bool _apiActionExecuted = false;
  bool _isResultView = false;
  bool _startBet = false;
  bool _stopBet = false;
  bool _isFrontTwo = false;
  bool _isFrontone = false;
  int dragonUserSum = 0;
  int tigerUserSum = 0;
  int tieUserSum = 0;

  @override
  void initState() {
    coinVal = chipList[selectedIndex].value;
    _globalKey = List.generate(chipList.length, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((c) {
      _endOffset = (_globalKey[selectedIndex].currentContext!.findRenderObject()
              as RenderBox)
          .localToGlobal(Offset.zero);
    });
    Audio.DragonbgSound();
    standingPeople();
    super.initState();
    fetchData();
  }


  List<ChipModel> chipList = [
    ChipModel(value: 1, image: Assets.chips10),
    ChipModel(value: 5, image: Assets.chips50),
    ChipModel(value: 10, image: Assets.chips100),
    ChipModel(value: 50, image: Assets.chips500),
    ChipModel(value: 100, image: Assets.chips1000),
    ChipModel(value: 500, image: Assets.chips5000),
    ChipModel(value: 1000, image: Assets.chips10000),
  ];

  List<PeopleModel> peopleList = [];

  void standingPeople() {
    final randomIndices = _getRandomIndices(dragonTigerJson['data'].length);
    setState(() {
      peopleList.clear();
      for (final i in randomIndices) {
        peopleList.add(PeopleModel(
          name: dragonTigerJson['data'][i]['user'],
          image: dragonTigerJson['data'][i]['image'],
          border: dragonTigerJson['data'][i]['border'],
        ));
      }
    });
  }

  List<int> _getRandomIndices(int length) {
    final random = Random();
    final List<int> indices = [];
    while (indices.length < 6) {
      final randomIndex = random.nextInt(length);
      if (!indices.contains(randomIndex)) {
        indices.add(randomIndex);
      }
    }
    return indices;
  }

  bool firstCome = false;
  late Offset _endOffset;
  late List<GlobalKey> _globalKey = [];


  @override
  Widget build(BuildContext context) {
    final userData = context.read<ProfileProvider>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/dragontiger/dr_ti_bg.gif"), fit: BoxFit.fill)),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding:  EdgeInsets.all(5.0),
                      child: Icon(Icons.arrow_back,color: Colors.orange,),
                    )),
                const Spacer(),

                // InkWell(
                //     onTap: () {
                //       // Navigator.pushNamed(
                //       //     context, RoutesName.accountScreen);
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Container(
                //         height: height*0.05,
                //         width: width*0.13,
                //         decoration:  const BoxDecoration(
                //
                //           image: DecorationImage(
                //             image: AssetImage(Assets.dragontigerAddIconNew),
                //           ),
                //         ),
                //         child: const DualRingAnimation(
                //           color: Color(0xffECC64E),
                //           size: 40.0,
                //           lineWidth: 1,
                //         ),
                //       ),
                //     )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AnimatedSwitcher(
                //   duration: const Duration(milliseconds: 600),
                //   transitionBuilder: __transitionBuilder,
                //   child:
                //   _showFrontSide
                //       ? _buildFrontOne(ResultGameHistory)
                //       : FadeInRight(child: _buildBack()),
                // ),
                // const SizedBox(width: 15),
                // AnimatedSwitcher(
                //   duration: const Duration(milliseconds: 600),
                //   transitionBuilder: __transitionBuilder,
                //   child: FadeInLeft(child: _buildBack()),
                //   // _showFrontSide
                //   //     ? _buildFrontTwo(drTiResultViewModel)
                //   //     : FadeInLeft(child: _buildBack()),
                // )
                _isFrontone
                    ? AnimatedGradientBorder(
                    borderSize: WinResult=='1'?3:WinResult=='3'?3:0,
                    gradientColors: const [
                      Color(0xfffaee72),
                      Colors.transparent,
                      Color(0xfffaee72),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(1),),
                    child: CardImage1==null?
                    Container(
                      height: height*0.1,
                      width: width*0.12,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image:AssetImage(AppAssets.imageFireCard,
                          ),
                              fit: BoxFit.fill
                          )
                      ),
                    ):

                    Container(
                      height: height*0.1,
                      width: width*0.12,
                      decoration:  BoxDecoration(
                          image: DecorationImage(image:AssetImage("assets/cards/$CardImage1.png"
                          ), fit: BoxFit.fill
                          )
                      ),
                    )
                ):
                      FadeInLeftBig(
                    child: Container(
                      height: height*0.1,
                      width: width*0.12,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image:AssetImage(AppAssets.imageFireCard,
                          ),
                              fit: BoxFit.fill
                          )
                      ),
                    )),

                SizedBox(width: width*0.11,),

                _isFrontTwo
                    ? AnimatedGradientBorder(
                  borderSize: WinResult=='2'?3:WinResult=='3'?3:0,
                  gradientColors: const [
                    Color(0xfffaee72),
                    Colors.transparent,
                    Color(0xfffaee72),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(1),),
                  child: CardImage1==null?
                  Container(
                    height: height*0.1,
                    width: width*0.12,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image:AssetImage(AppAssets.imageFireCard,
                        ),
                            fit: BoxFit.fill
                        )
                    ),
                  ):
                  Container(
                    height: height*0.1,
                    width: width*0.12,
                    decoration: BoxDecoration(
                        image: DecorationImage(image:AssetImage("assets/cards/$CardImage2.png",
                        ),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                )
                    : FadeInRightBig(
                    child: Container(
                      height: height*0.1,
                      width: width*0.12,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image:AssetImage(AppAssets.imageFireCard,
                          ),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
              ],
            ),

            Padding(
              padding:  EdgeInsets.only(top: height*0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DragonTigerTimer(
                    onTimerTick: (int val) {
                      _updateTimerValue(val, context, ResultGameHistory);
                    },
                  ),
                  SizedBox(height: height*0.012,),
                  SizedBox(
                    height: height*0.04,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: items.length + 1,
                      itemBuilder: (context, index) {
                        if (index == items.length)
                        {
                          return InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print('history');
                              }
                            },
                            child: Center(
                              child: Container(
                                width: width * 0.061,
                                height: height*0.03,
                                decoration: BoxDecoration(
                                    image:  const DecorationImage(
                                        image: AssetImage(Assets.dragontigerIcArrowZigzag),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            // 60 dragon
                            // 70 tiger
                            // 80 tie
                            items[index].number == 1
                                ? Assets.dragontigerIcDtD
                                : items[index].number == 2
                                ? Assets.dragontigerIcDtT:
                            Assets.dragontigerIcDtTie,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

             // DrTiResultWidget(gameId:widget.gameId),


            Stack(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: height*0.05),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: width * 0.7,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 0.65
                  ),
                  itemCount: peopleList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(peopleList[index].border),
                          child: CircleAvatar(
                            radius: 19,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(peopleList[index].image),

                          ),
                        ),
                        Container(
                          height: height*0.025,
                          width: width*0.20,
                          margin:  const EdgeInsets.only(bottom: 5),
                          padding:  const EdgeInsets.only(right: 5, left: 5),
                          decoration: BoxDecoration(
                              color: Colors.black87.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: textWidget(
                                text: peopleList[index].name,
                                maxLines: 1,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding:  EdgeInsets.only(top: height*0.07),
                  child: Column(
                    children: [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            //80 tie
                            if (userData.totalWallet >= coinVal) {
                              if (setTimeValue > 10) {
                                bettingApi('3',coinVal.toString());
                                setState(() {
                                  tieUserSum += coinVal;
                                  firstCome = true;
                                });
                                var overlayEntry = OverlayEntry(builder: (_) {
                                  RenderBox? box = context.findRenderObject()
                                  as RenderBox?;
                                  var offset = box!.localToGlobal(const Offset(170, 50));
                                  return EasyCartAnimation(
                                    startPosition: _endOffset,
                                    endPosition: offset,
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      chipList[selectedIndex].image,
                                      height: height / 13,
                                    ),
                                  );
                                });
                                Overlay.of(context).insert(overlayEntry);
                                Future.delayed(const Duration(seconds: 2),
                                        () {
                                      overlayEntry.remove();
                                    });
                              }
                            } else {
                              ///add money page
                            }
                          },
                          child: Stack(

                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                  height: height * 0.12,
                                  width: width * 0.70,
                                  color: Colors.transparent,
                                  alignment: Alignment.bottomCenter,
                                  child: StrokeText(
                                    text: tieUserSum.toString(),
                                    strokeColor: AppColors.btnTextColor,
                                    textColor: AppColors.goldColor,
                                    strokeWidth: 2,
                                    fontSize: 18,
                                  )),
                              Positioned(
                                  left: -width*0.40,
                                  top: height*0.02,
                                  child: Stack(
                                    children: coins3,
                                  )),
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: height*0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                // 60 dragon
                                if (userData.totalWallet >= coinVal) {
                                  if (setTimeValue > 10) {
                                    bettingApi('1',coinVal.toString());
                                    setState(() {
                                      dragonUserSum += coinVal;
                                      firstCome = true;
                                    });
                                    var overlayEntry =
                                    OverlayEntry(builder: (_) {
                                      RenderBox? box = context
                                          .findRenderObject() as RenderBox?;
                                      var offset = box!.localToGlobal(
                                          const Offset(70, 120));
                                      return EasyCartAnimation(
                                        startPosition: _endOffset,
                                        endPosition: offset,
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          chipList[selectedIndex].image,
                                          height: height / 13,
                                        ),
                                      );
                                    });
                                    // Show Overlay
                                    Overlay.of(context).insert(overlayEntry);
                                    Future.delayed(const Duration(seconds: 2),
                                            () {
                                          overlayEntry.remove();
                                        });
                                  }
                                } else {
                                 ///redirexct to add money
                                }
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                      height: height * 0.3,
                                      width: width * 0.4,
                                      color: Colors.transparent,
                                      alignment: Alignment.bottomCenter,
                                      child:
                                      // (drTiResultViewModel.drTiResult == '60') &&
                                        StrokeText(
                                        text: dragonUserSum.toString(),
                                        strokeColor:
                                        AppColors.btnTextColor,
                                        textColor: AppColors.goldColor,
                                        strokeWidth: 2,
                                        fontSize: 18,
                                      )),
                                  Positioned(
                                      left: -width*0.37,
                                      top: height*0.01,
                                      child: Stack(
                                        children: coins1,
                                      )),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(width: 15),
                          Builder(builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                //70 tiger
                                if (userData.totalWallet >= coinVal) {
                                  if (setTimeValue > 10) {
                                     bettingApi('2',coinVal.toString());
                                    setState(() {
                                      tigerUserSum += coinVal;
                                      firstCome = true;
                                    });
                                    var overlayEntry =
                                    OverlayEntry(builder: (_) {
                                      RenderBox? box = context
                                          .findRenderObject() as RenderBox?;
                                      var offset = box!.localToGlobal(
                                          const Offset(70, 120));
                                      return EasyCartAnimation(
                                        startPosition: _endOffset,
                                        endPosition: offset,
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          chipList[selectedIndex].image,
                                          height: height / 13,
                                        ),
                                      );
                                    });
                                    // Show Overlay
                                    Overlay.of(context).insert(overlayEntry);
                                    // wait for the animation to end
                                    Future.delayed(const Duration(seconds: 2),
                                            () {
                                          overlayEntry.remove();
                                        });
                                  }
                                } else {
                            Utils.flushBarErrorMessage('insufficient fund', context, Colors.white);
                                }
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                      left: -width*0.37,
                                      top: height*0.01,
                                      child: Stack(
                                        children: coins2,
                                      )),
                                  Container(
                                      height: height * 0.3,
                                      width: width * 0.4,
                                      color: Colors.transparent,
                                      alignment: Alignment.bottomCenter,
                                      child:
                                      // (drTiResultViewModel.drTiResult == '70') &&
                                         StrokeText(
                                        text: tigerUserSum.toString(),
                                        strokeColor:
                                        AppColors.btnTextColor,
                                        textColor: AppColors.goldColor,
                                        strokeWidth: 2,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),
            SizedBox(
              height: height*0.18,
              // color: Colors.red.withAlpha(40),
              child: Column(
                children: [
                Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                              text: 'Period',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                           SizedBox(width: width*0.02),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                    width: 0.5, color: Colors.grey.shade600)),
                            child: textWidget(
                                // text: drTiResultViewModel.drTiPeriod,
                                text: gamesNo.toString(),
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          )
                        ],
                      ),
                  Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DragonTigerHistory(gameid:widget.gameId)));
                                context.read<ProfileProvider>().fetchProfileData();
                              },
                              child: Image.asset(Assets.iconsBetHistory, height: height*0.04,)),
                          SizedBox(width: width*0.10,),
                          SizedBox(
                              width: width * 0.20,
                              height: height*0.035,
                              // color: Colors.teal,
                              child: Center(
                                child: textWidget(
                                    text: '₹${userData.totalWallet.toStringAsFixed(2)?? 0}',
                                    color: AppColors.goldColor,
                                    fontWeight: FontWeight.w600),
                              )),
                          SizedBox(width: width*0.04,),
                          Image.asset(Assets.dragontigerIcOnlineUser, height: height*0.05,),
                          Padding(
                            padding:  EdgeInsets.only(bottom: height*0.01,left: 10),
                            child: textWidget(
                                text: randomPeople.toString(),
                                color: AppColors.goldColor,
                                fontWeight: FontWeight.w600),
                          )

                        ],
                      ),
                  SizedBox(
                    height: height*0.07,
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height*0.065,
                          // color: Colors.yellowAccent,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: chipList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0,top: 10),
                                child: UpDownBorder(
                                  borderWidth: index == selectedIndex ? 5 : 0,
                                  borerColor: Colors.lightGreenAccent.shade400,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        coinVal = chipList[index].value;
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Image.asset(
                                      key: _globalKey[index],
                                      chipList[index].image,
                                      height: height / 10,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )



          ],
        ),
      ),
    );
  }


  bool _showFrontSide = false;


  void _updateTimerValue(int value, context, drTiResultViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // Audio.audioPlayers.dispose();
        // Audio.DragonbgSound();

        setTimeValue = value;
        if (value == 6 && !_apiActionExecuted) {



          _apiActionExecuted = true;
          _isResultView = false;
        }
        if (value == 1 && !_startBet) {
          _isFrontone= false;
          _isFrontTwo= false;

          generateRandomCoin();

          Utils.showImageToast(
            imagePath: Assets.dragontigerStartbetting,
            context: context,
            width: width,
            height: height * 0.1,
          );

          standingPeople();
          _addCoins();
          _startBet = true;
          _stopBet = false;
          dragonUserSum = 0;
          tigerUserSum = 0;
          tieUserSum = 0;
        }
        if (value == 10 && !_stopBet) {
          Utils.showImageToast(
            imagePath: Assets.dragontigerStopbetting,
            context: context,
            width: width,
            height: height * 0.1,
          );
         //  if (dragonUserSum == 0 && tigerUserSum == 0 && tieUserSum == 0) {
         //    // All counts are 0
         //  } else {
         //    bettingApi();
         // }

          _stopBet = true;
          _startBet = false;
        }
        if (value < 5 && !_isActionExecuted) {
          coins2.clear();
          coins1.clear();
          coins3.clear();
          _showFrontWidgets();
          lastresultview();
          _isActionExecuted = true;
        }else if (value >= 5 && _isActionExecuted) {
          _showBackWidget();
          fetchData();

          _isResultView = true;
          _isActionExecuted = false;
          _apiActionExecuted = false;
        }
      });
    });
  }

  void _showFrontWidgets() {
    setState(() {
      _showFrontSide = true;
    });
  }

  void _showBackWidget() {
    setState(() {
      _showFrontSide = false;
    });
  }

  List<Widget> coins1 = [];
  List<Widget> coins2 = [];
  List<Widget> coins3 = [];

  int randomCoin = 0;
  int randomPeople = 0;
  void generateRandomCoin() {
    setState(() {
      randomCoin = Random().nextInt(90) + 10;
      randomPeople = Random().nextInt(989) + 10;
    });
  }

  void _addCoins() {
    var rng = Random();
    int count = rng.nextInt(11) + 10;
    for (int i = 0; i < count; i++) {
      Timer(Duration(milliseconds: i * 500), () {
        setState(() {
          coins1.add(
            const AnimatedCoin(
              type: 1,
            ),
          );

          coins2.add(
            const AnimatedCoin(
              type: 2,
            ),
          );
          coins3.add(
            const AnimatedCoin(
              type: 3,
            ),
          );
        });
      });
    }
  }



  var WinResult;
  var CardImage1;
  var CardImage2;
  var gamesNo;

  Future<void> lastresultview() async {
    var gameIds = widget.gameId;
    try {
      final url = Uri.parse('${ApiUrl.resultList}$gameIds&limit=1');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"][0];
        setState(() {
          WinResult = responseData["number"];

          final List<dynamic> cardImage = json.decode(responseData["json"]);
          CardImage1= cardImage[0];
          CardImage2=  cardImage[1];
        });
        context.read<ProfileProvider>().fetchProfileData();
        WinResult==1?
        ImageToast.show(
            imagePath: AppAssets.gif_dragon_animated,
            height: 300,
            context: context):
        WinResult==2?
        ImageToast.show(
            imagePath: AppAssets.gif_tiger_animated,
            height: 300,
            context: context):
        TextToast.show(
            context: context, message: 'Game Tie');

        if (kDebugMode) {
          print('Successfully fetched contact data');
          print(gamesNo);
          print('gjjjjjjjjjjj');
        }

        _isFrontone= true;
        _isFrontTwo= true;
      } else {
        throw Exception("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data. $e");
    }
  }


  ////dt api
  List<ResultGameHistory> items = [];

  Future<void> fetchData() async {
    var gameIds = widget.gameId;
    if (kDebugMode) {
      print(gameIds);
      print('gameIds');
    }
    final response = await http.get(Uri.parse("${ApiUrl.resultList}$gameIds&limit=10"));
    if (kDebugMode) {
      print("${ApiUrl.resultList}$gameIds&limit=10");
      print('yyyyyyyyyy');
    }

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      final responseData1 = json.decode(response.body)["data"][0];
      setState(() {
        items = responseData.map((item) => ResultGameHistory.fromJson(item)).toList();
        gamesNo = int.parse(responseData1["gamesno"].toString()) + 1;
      });
      // items.clear();
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

  @override
  void dispose() {
    Audio.audioPlayers.stop();
    super.dispose();
  }

  UserViewProvider userProvider = UserViewProvider();


  Future<void> bettingApi(String number, String amount,) async {
    try {
      if (kDebugMode) {
        print("bet lgi");
      }
      UserModel user = await userProvider.getUser();
      String token = user.id.toString();
      final betList = [
        {'number': number, 'amount': amount},
      ];

      final response = await http.post(
        Uri.parse(ApiUrl.dragonBet),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userid": token,
          "game_id": widget.gameId,
          "json": betList,
        }),
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        print("data: $data");
        print("betList: $betList");
      }

      if (data["status"] == 200) {
        context.read<ProfileProvider>().fetchProfileData();
        ImageToast.show(
          imagePath: AppAssets.bettingplaceds,
          height: 100,
          context: context,
        );
      } else {
        Utils.flushBarErrorMessage(
            data['msg'].toString() ?? "Unknown error", context, Colors.black);
        dragonUserSum = 0 ;
        tigerUserSum = 0 ;
        tieUserSum = 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      Utils.flushBarErrorMessage(e.toString(), context, Colors.black);
    }
  }


}

class ChipModel {
  final int value;
  final String image;
  ChipModel({required this.value, required this.image});
}

class PeopleModel {
  final String name;
  final String image;
  final String border;
  PeopleModel({
    required this.name,
    required this.image,
    required this.border,
  });
}
