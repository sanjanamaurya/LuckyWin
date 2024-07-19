import 'dart:math';
import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';


class EarningChart extends StatefulWidget {


  const EarningChart({super.key});

  @override
  _EarningChartState createState() => _EarningChartState();
}

class _EarningChartState extends State<EarningChart> {
  List<String> names = [
    'Mem***xbw', 'Mem***ayz', 'Mem***qwe', 'Wdx***esw', 'Ser***xbw', 'Qax***arz', 'Cde***hrs', 'Rfv***mjy',
    'Plm***abc', 'Hjk***def', 'Oiu***ghi', 'Asd***jkl', 'Zxc***vbn', 'Qwe***rty', 'Mnb***uio', 'Lkj***poi',
    'Bnm***yui', 'Vfr***tgb', 'Cft***hnu', 'Xse***plo', 'Edr***hyu', 'Tgb***vfr', 'Yhn***mju', 'Ujm***nbg',
    'Iko***plm', 'Pla***swz', 'Opr***vds', 'Mnq***bgr'
  ];

  List<String> amounts = [
    '₹63,88.00', '₹75,23.00', '₹52,19.00', '₹64,58.00', '₹99,23.21', '₹87,53.00', '₹78,43.00', '₹77,33.00',
    '₹69,45.00', '₹54,32.00', '₹88,71.00', '₹92,45.00', '₹63,21.00', '₹74,19.00', '₹81,53.00', '₹95,12.00',
    '₹82,64.00', '₹70,34.00', '₹56,98.00', '₹67,45.00', '₹60,73.00', '₹84,29.00', '₹91,38.00', '₹53,47.00',
    '₹79,85.00', '₹66,90.00', '₹93,56.00', '₹85,12.00'
  ];

  List<String> personImages = [
    Assets.person1, Assets.person2, Assets.person3, Assets.person4, Assets.person5, Assets.personPerson6, Assets.personPerson7, Assets.personPerson8,
    Assets.personPerson9, Assets.personPerson10, Assets.personPerson11, Assets.personPerson12, Assets.personPerson13, Assets.personPerson14, Assets.personPerson15, Assets.personPerson16,
    Assets.personPerson17, Assets.personPerson18, Assets.personPerson19, Assets.personPerson20,
  ];
  List<String> rankBgImages = [Assets.personRankbg1, Assets.personRankbg2, Assets.personRankbg3];

  late String name1, name2, name3, name4, name5;
  late String amount1, amount2, amount3, amount4, amount5;
  late String personImage1, personImage2, personImage3,personImage4, personImage5;
  late String rankBgImage1, rankBgImage2, rankBgImage3;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    final random = Random();
    name1 = names[random.nextInt(names.length)];
    name2 = names[random.nextInt(names.length)];
    name3 = names[random.nextInt(names.length)];
    name4 = names[random.nextInt(names.length)];
    name5 = names[random.nextInt(names.length)];

    amount1 = amounts[random.nextInt(amounts.length)];
    amount2 = amounts[random.nextInt(amounts.length)];
    amount3 = amounts[random.nextInt(amounts.length)];
    amount4 = amounts[random.nextInt(amounts.length)];
    amount5 = amounts[random.nextInt(amounts.length)];

    personImage1 = personImages[random.nextInt(personImages.length)];
    personImage2 = personImages[random.nextInt(personImages.length)];
    personImage3 = personImages[random.nextInt(personImages.length)];
    personImage4 = personImages[random.nextInt(personImages.length)];
    personImage5 = personImages[random.nextInt(personImages.length)];

    rankBgImage1 = rankBgImages[0]; // You can change logic as needed
    rankBgImage2 = rankBgImages[1]; // You can change logic as needed
    rankBgImage3 = rankBgImages[2]; // You can change logic as needed
  }

  Widget textWidget({required String text, required double fontSize, required FontWeight fontWeight, required Color color}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.3,
          width: width * 0.99,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.12,
                      width: width * 0.9,
                    ),
                    Container(
                      height: height * 0.18,
                      width: width * 0.9,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(Assets.personStage)
                          ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.02,),
                          Column(
                            children: [
                              SizedBox(height: height * 0.09,),
                              textWidget(
                                  text: name1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff4287ff)),
                              SizedBox(height: height * 0.01,),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.028,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  gradient: AppColors.boxGradient,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text(
                                  amount1,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.06,),
                          Column(
                            children: [
                              SizedBox(height: height * 0.06,),
                              textWidget(
                                  text: name2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff4287ff)),
                              SizedBox(height: height * 0.01,),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.028,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                    gradient: AppColors.boxGradient,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text(
                                  amount2,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.055,),
                          Column(
                            children: [
                              SizedBox(height: height * 0.09,),
                              textWidget(
                                  text: name3,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff4287ff)),
                              SizedBox(height: height * 0.01,),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.028,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                    gradient: AppColors.boxGradient,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text(
                                  amount3,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
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
              // Positioning CircleAvatars and Images for ranks
              Positioned(
                  bottom: height * 0.12,
                  left: width * 0.12,
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage(rankBgImage2),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(personImage1),),
                  )),
              Positioned(
                  bottom: height * 0.17,
                  left: width * 0.065,
                  child: Image(
                    image: const AssetImage(Assets.personNo2), height: height * 0.07,
                  ),
              ),
              Positioned(
                  bottom: height * 0.1,
                  left: width * 0.13,
                  child: Image(image: const AssetImage(Assets.personNo2badge), height: height * 0.02,)),
              Positioned(
                  bottom: height * 0.15,
                  left: width * 0.42,
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage(rankBgImage1),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(personImage2),),
                  )),
              Positioned(
                  bottom: height * 0.135,
                  left: width * 0.435,
                  child: Image(image: const AssetImage(Assets.personNo1badge), height: height * 0.02,)),
              Positioned(
                  bottom: height * 0.2,
                  left: width * 0.37,
                  child: Image(image: const AssetImage(Assets.personNo1), height: height * 0.07,)),
              Positioned(
                  bottom: height * 0.12,
                  right: width * 0.12,
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage(rankBgImage3),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(personImage3),),
                  )),
              Positioned(
                  bottom: height * 0.17,
                  right: width * 0.19,
                  child: Image(image: const AssetImage(Assets.personNo3), height: height * 0.07,)),
              Positioned(
                  bottom: height * 0.1,
                  right: width * 0.13,
                  child: Image(image: const AssetImage(Assets.personNo3badge), height: height * 0.02,)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0, left: 15, right: 15),
          child: Container(
              height: height * 0.09,
              width: width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textWidget(
                      text: '4',
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w900),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(personImage4),

                  ),
                  textWidget(
                      text: name4,
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                  Container(
                    height: 30,
                    width: width*0.3,
                    decoration: BoxDecoration(
                        gradient : AppColors.boxGradient,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text(
                        amount4,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 15, right: 15),
          child: Container(
              height: height * 0.09,
              width: width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textWidget(
                      text: '5',
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w900),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(personImage5),

                  ),
                  textWidget(
                      text: name5,
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                  Container(
                    height: 30,
                    width: width*0.3,
                    decoration: BoxDecoration(
                        gradient : AppColors.boxGradient,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text(
                        amount5,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ],
    );
  }
}
