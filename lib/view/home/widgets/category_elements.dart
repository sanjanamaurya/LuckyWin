import 'dart:async';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/utils/routes/routes_name.dart';
import 'package:theluckywin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:theluckywin/view/home/mini/Aviator/home_page_aviator.dart';

class CategoryElement extends StatefulWidget {
  final int selectedCategoryIndex;
  const CategoryElement({super.key, required this.selectedCategoryIndex});

  @override
  State<CategoryElement> createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  int countdownSeconds = 60;
  Timer? countdownTimer;
  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();

    int initialSeconds = 60 - now.second; // Calculate initial remaining seconds
    setState(() {
      countdownSeconds = initialSeconds;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 60) {
      } else if (countdownSeconds == 1) {
        // Do something
      }
      countdownSeconds = (countdownSeconds - 1) % 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MiniGameModel> miniGameList = [
      MiniGameModel(
          image: Assets.categoryAvaitorimagenew,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GameAviator()));
          }),
      // MiniGameModel(
      //     image: Assets.categoryPlinko,
      //     onTap: () {
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> MyGameWidget(game: PlinkoMains()),));
      //     }),

    ];

    List<RummylistModel> Rummylist = [
      RummylistModel(
          image: Assets.imagesAviatorFirst,
          onTap: () {
            Utils.showImageComming(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const DragonTiger(gameId: '10')));
          }),
    ];
    return widget.selectedCategoryIndex == 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: AppColors.gradientFirstColor,
                      size: 30,
                    ),
                    Text(
                      " Popular  Lottery".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     // Utils.showImageComming(context);
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const TrxScreen()));
                    //
                    //   },
                    //   child: Container(
                    //     height: height * 0.18,
                    //     width: width * 0.472,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         image: AssetImage(
                    //           Assets.categoryNewimg1,
                    //         ),
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const SizedBox(
                    //           height: 15,
                    //         ),
                    //         textWidget(
                    //           text: '     Trx 1Min',
                    //           fontWeight: FontWeight.w900,
                    //           fontSize: 15,
                    //           color: AppColors.white,
                    //         ),
                    //         textWidget(
                    //           text: '      Countdown to Lottery',
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 12,
                    //           color: AppColors.white,
                    //         ),
                    //         SizedBox(
                    //           height: height * 0.01,
                    //         ),
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               width: width * 0.05,
                    //             ),
                    //             Container(
                    //               height: height * 0.045,
                    //               width: width * 0.25,
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                   image: AssetImage(
                    //                     Assets.categoryNewimgcalender,
                    //                   ),
                    //                   fit: BoxFit.fill,
                    //                 ),
                    //               ),
                    //               child: Center(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.only(top: 10.0),
                    //                   child: Text(
                    //                     '00           $countdownSeconds',
                    //                     style: const TextStyle(
                    //                       fontWeight: FontWeight.w900,
                    //                       color: Colors.cyan,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.winGoScreen);
                      },
                      child: Container(
                        height: height * 0.18,
                        width: width * 0.472,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  Assets.categoryNewimg2,
                                ),
                                fit: BoxFit.fill)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            textWidget(
                                text: '     WinGo 1Min',
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color: AppColors.white),
                            textWidget(
                                text: '      Countdown to Lottery',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppColors.white),
                             SizedBox(
                              height: height*0.01,
                            ),
                            Row(
                              children: [
                                 SizedBox(
                                  width: width*0.05,
                                ),
                                Container(
                                  height: height*0.045,
                                  width: width*0.25,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            Assets.categoryNewimgcalender,
                                          ),
                                          fit: BoxFit.fill)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      '00           $countdownSeconds',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.deepPurpleAccent),
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                        height: height * 0.05,
                        width: width * 0.05,
                        child: const VerticalDivider(
                          thickness: 3,
                          color: AppColors.gradientFirstColor,
                        )),
                    Text(
                      " Lottery".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                lotteryContainer(
                  height, width, "Win Go", // title
                  "Thought the platform WIN GO Hash lottery seed as the result of the lottery", // subtitle
                  () {
                    Navigator.pushNamed(context, RoutesName.winGoScreen);
                  },
                  Assets.categoryWingocoin1,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                // lotteryContainer(
                //   height, width, "trx", // title
                //   "Thought the platform WIN GO Hash lottery seed as the result of the lottery", // subtitle
                //   () {
                //    Navigator.push(context, MaterialPageRoute(builder: (context)=>const TrxScreen()));
                //   },
                //   Assets.categoryTrxcoin1,
                // ),
                SizedBox(
                  height: height * 0.03,
                ),
                // lotteryContainer(
                //   height, width, "5D", // title
                //   "Thought the platform 5D Lottery seed as the result of the lottery", // subtitle
                //       () {
                //     Utils.showImageComming(context);
                //   },
                //   Assets.categoryTrxcoin1,
                // ),
                // SizedBox(
                //   height: height * 0.03,
                // ),
                // lotteryContainer(
                //   height, width, "K3", // title
                //   "Thought the platform K3 lottery seed as the result of the lottery", // subtitle
                //       () {
                //         Utils.showImageComming(context);
                //   },
                //   Assets.categoryTrxcoin1,
                // ),
                // SizedBox(
                //   height: height * 0.03,
                // ),
              ],
            ),
          )
        : widget.selectedCategoryIndex == 1
            ? Padding(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: height * 0.05,
                            width: width * 0.05,
                            child: const VerticalDivider(
                              thickness: 3,
                              color: AppColors.gradientFirstColor,
                            )),
                        Text(
                          " Original".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      height: height * 0.24,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 2.0,
                          // childAspectRatio: 1.6
                        ),
                        shrinkWrap: true,
                        itemCount: miniGameList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: miniGameList[index].onTap,
                            child: Center(
                              child: Container(
                                height: height * 0.25,
                                width: width * 0.5,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        miniGameList[index].image,
                                      ),
                                    )),
                                //  color: Colors.deepPurpleAccent,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : widget.selectedCategoryIndex == 2
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Container(
                      height: height*0.27,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Rummylist.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: height * 0.05,
                                        width: width * 0.05,
                                        child: const VerticalDivider(
                                          thickness: 3,
                                          color: AppColors.gradientFirstColor,
                                        )),
                                    Text(
                                      " Dragon Tiger".toUpperCase(),
                                      style: const TextStyle(

                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                GestureDetector(
                                  onTap: Rummylist[index].onTap,
                                  child: Container(
                                    height: height * 0.17,
                                    decoration: const BoxDecoration(

                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage(Assets.categoryLimbo)
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                : Image.asset(
                  Assets.imagesCommingsoon,
                  fit: BoxFit.cover,
                  color: Color(0xff4287ff),
                  height: height * 0.25,
                   width: width*0.8,
                );
  }

  lotteryContainer(double height, double width, String title, String subtitle,
      VoidCallback onTap, String imagePath) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.2,
        width: width * 0.9,
        decoration: BoxDecoration(
            gradient: AppColors.boxGradient,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.24,
              decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(imagePath),
            ),
            SizedBox(
              height: height * 0.15,
              width: width * 0.55,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Container(
                        height: height * 0.04,
                        width: width * 0.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            gradient: AppColors.loginSecondryGrad,
                        ),
                        child: const Center(
                          child: Text("GO →",style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.52,
                      decoration: BoxDecoration(
                          gradient: AppColors.gameGradient,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "   The Hightest bonus in history",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 8),
                          ),
                          Container(
                            height: height * 0.03,
                            width: width * 0.005,
                            color: Colors.white,
                          ),
                          const Text(
                            "0.00",
                            style: TextStyle(
                                color: AppColors.gradientFirstColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.02,
                        width: width * 0.005,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: width * 0.48,
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9),
                        ),
                      ),
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
}

class LotteryModel {
  final String titleText;
  final String subTitleText;
  final String gameText;
  final String? member;
  final String? memberImage;
  final String decorationImage;
  final String? decoImage;
  final String? winAmount;
  final VoidCallback? onTap;
  LotteryModel(
      {required this.titleText,
      required this.subTitleText,
      required this.gameText,
      this.member,
      this.memberImage,
      required this.decorationImage,
      this.decoImage,
      this.winAmount,
      this.onTap});
}

class MiniGameModel {
  final String image;
  final VoidCallback? onTap;
  MiniGameModel({required this.image, this.onTap});
}

class RummylistModel {
  final String image;
  final VoidCallback? onTap;
  RummylistModel({required this.image, this.onTap});
}
