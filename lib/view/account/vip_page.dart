// import 'dart:convert';
//
// import 'package:theluckywin/generated/assets.dart';
// import 'package:theluckywin/main.dart';
// import 'package:theluckywin/res/aap_colors.dart';
// import 'package:theluckywin/res/components/app_bar.dart';
// import 'package:theluckywin/res/components/app_btn.dart';
// import 'package:theluckywin/res/components/text_widget.dart';
// import 'package:theluckywin/res/provider/profile_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart'as http;
// import 'package:theluckywin/view/home/mini/Aviator/progressbar.dart';
//
// class VipScreen extends StatefulWidget {
//   const VipScreen({super.key});
//
//   @override
//   State<VipScreen> createState() => _VipScreenState();
// }
//
// class _VipScreenState extends State<VipScreen> {
//   List<BenefitsLevel> levelList = [
//     BenefitsLevel(
//       image: Assets.iconsVipgift,
//       title: 'Level up rewards',
//       subTitle: 'Each account can only receive 1 time\n',
//       tralingText: '690',
//       tralingIcon: Assets.iconsDepoWallet,
//       tralingText1: '0',
//       tralingIcon1: Assets.iconsViplove,
//       myBenefitImage: Assets.iconsVipwelfare1,
//     ),
//     BenefitsLevel(
//       image: Assets.iconsVipstarcoin,
//       title: 'Monthly rewards',
//       subTitle: 'Each account can only receive 1 time per month',
//       tralingText: '290',
//       tralingIcon: Assets.iconsDepoWallet,
//       tralingText1: '0',
//       tralingIcon1: Assets.iconsViplove,
//       myBenefitImage: Assets.iconsVipwelfare2,
//     ),
//     BenefitsLevel(
//       image: Assets.iconsVipcamera,
//       title: 'Safe',
//       subTitle: 'Increase the extra income of safe',
//       tralingText: '0.15%',
//       tralingIcon: Assets.iconsVault,
//       myBenefitImage: Assets.iconsVipwelfare4,
//     ),
//     BenefitsLevel(
//       image: Assets.iconsVipcoins,
//       title: 'Rebate rate',
//       subTitle: 'Increase income of rebate',
//       tralingText: '0.6%',
//       tralingIcon: Assets.iconsVipweal,
//       myBenefitImage: Assets.iconsVipwelfare5,
//     )
//   ];
//   List<VipRule> ruleData = [
//     VipRule(
//       title: 'Upgrade standard',
//       discription: "The IP member's experience points (valid bet amount) that meet the requirements of the corresponding rank will be promoted to the corresponding VIP level, the member's VIP data statistics period starts from 00:00:00 days VIP system launched.VIP level calculation is refreshed every 10 minutes! The corresponding experience level is calculated according to valid odds 1:1 !",
//     ),
//     VipRule(
//       title: 'Upgrade order',
//       discription: "The VIP level that meets the corresponding requirements can be promoted by one level every day, but the VIP level cannot be promoted by leapfrogging."
//     ),
//     VipRule(
//         title: 'Level maintenance',
//         discription: 'VIP members need to complete the maintenance requirements of the corresponding level within 30 days after the "VIP level change"; if the promotion is completed during this period, the maintenance requirements will be calculated according to the current level.'
//     ),
//     VipRule(
//         title: 'Downgrade standard',
//         discription: "If a VIP member fails to complete the corresponding level maintenance requirements within 30 days, the system will automatically deduct the experience points corresponding to the level. If the experience points are insufficient, the level will be downgraded, and the corresponding discounts will be adjusted to the downgraded level accordingly."
//     ),
//     VipRule(
//         title: 'Upgrade Bonus',
//         discription: "The upgrade benefits can be claimed on the VIP page after the member reaches the VIP membership level, and each VIP member can only get the upgrade reward of each level once."
//     ),
//     VipRule(
//         title: 'Monthly reward',
//         discription: "VIP members can earn the highest level of VIP rewards once a month.Can only be received once a month. Prizes cannot be accumulated. And any unclaimed rewards will be refreshed on the next settlement day. When receiving the highest level of monthly rewards this month Monthly Rewards earned in this month will be deducted e.g. when VIP1 earns 500 and upgrades to VIP2 to receive monthly rewards 500 will be deducted."
//     ),
//     VipRule(
//         title: 'Real-time rebate',
//         discription: "The higher the VIP level, the higher the return rate, all the games are calculated in real time and can be self-rewarded!"
//     ),
//     VipRule(
//         title: 'Safe',
//         discription: "VIP members who have reached the corresponding level will get additional benefits on safe deposit based on the member's VIP level."
//     ),
//
//   ];
//
//   List<VipLevel> vipLevel = [
//     VipLevel(
//       bgImage: Assets.iconsVipbg1,
//       title: 'Vip1',
//       achievedImg: Assets.iconsViptick,
//       topImg: Assets.iconsViptop1,
//       levelImage: Assets.iconsVip1,
//       targetNumber: '60',
//       achievedNumber: '60',
//       completePercentage: '100.00',
//       bottomColor: AppColors.vip1,
//       status: '1',
//       backGroundColor: AppColors.vipColor1,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg2,
//       title: 'Vip2',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip2,
//       targetNumber: '30000',
//       achievedNumber: '70',
//       completePercentage: '80.0',
//       bottomColor: AppColors.vip2,
//       status: '0',
//       backGroundColor: AppColors.vipColor2,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg3,
//       title: 'Vip3',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip3,
//       targetNumber: '40000',
//       achievedNumber: '70',
//       completePercentage: '30.0',
//       bottomColor: AppColors.vip3,
//       status: '0',
//       backGroundColor: AppColors.vipColor3,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg4,
//       title: 'Vip4',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip4,
//       targetNumber: '50000',
//       achievedNumber: '70',
//       completePercentage: '10.0',
//       bottomColor: AppColors.vip4,
//       status: '0',
//       backGroundColor: AppColors.vipColor4,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg5,
//       title: 'Vip5',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip5,
//       targetNumber: '75000',
//       achievedNumber: '70',
//       completePercentage: '8.2',
//       bottomColor: AppColors.vip5,
//       status: '0',
//       backGroundColor: AppColors.vipColor5,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg6,
//       title: 'Vip6',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip6,
//       targetNumber: '80000',
//       achievedNumber: '70',
//       completePercentage: '7.6',
//       bottomColor: AppColors.vip6,
//       status: '0',
//       backGroundColor: AppColors.vipColor6,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg7,
//       title: 'Vip7',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip7,
//       targetNumber: '78000',
//       achievedNumber: '70',
//       completePercentage: '6.0',
//       bottomColor: AppColors.vip7,
//       status: '0',
//       backGroundColor: AppColors.vipColor7,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg8,
//       title: 'Vip8',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip8,
//       targetNumber: '82000',
//       achievedNumber: '70',
//       completePercentage: '10.0',
//       bottomColor: AppColors.vip8,
//       status: '0',
//       backGroundColor: AppColors.vipColor8,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg9,
//       title: 'Vip9',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip9,
//       targetNumber: '87000',
//       achievedNumber: '00',
//       completePercentage: '0.0',
//       bottomColor: AppColors.vip9,
//       status: '0',
//       backGroundColor: AppColors.vipColor9,
//     ),
//     VipLevel(
//       bgImage: Assets.iconsVipbg10,
//       title: 'Vip10',
//       achievedImg: Assets.iconsVipununlocked,
//       topImg: Assets.iconsViptop2,
//       levelImage: Assets.iconsVip10,
//       targetNumber: '970000',
//       achievedNumber: '00',
//       completePercentage: '0.0',
//       bottomColor: AppColors.vip10,
//       status: '0',
//       backGroundColor: AppColors.vipColor10,
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final userData = context.read<ProfileProvider>();
//     return Scaffold(
//       backgroundColor: AppColors.scaffolddark,
//       appBar: GradientAppBar(
//           title: textWidget(text: 'VIP', fontSize: 25, color: Colors.white),
//           leading: const AppBackBtn(),
//           centerTitle: true,
//           gradient: AppColors.primaryGradient),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           Stack(
//             children: [
//               Container(
//                   height: height * 0.22,
//                   width: width,
//                   decoration: const BoxDecoration(
//                     gradient: AppColors.primaryGradient,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                          CircleAvatar(
//                           radius: 50,
//                           backgroundImage: NetworkImage(userData.userImage.toString()),
//                         ),
//                         const SizedBox(width: 15),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 20),
//                             Image(
//                               image: const AssetImage(Assets.iconsProfilevip1),
//                               height: height * 0.04,
//                             ),
//                             const SizedBox(height: 10),
//                             textWidget(
//                                 text: userData.userName == null?
//                                     "MEMBERNGKC"
//                                 : userData.userName.toString(),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.white),
//                             SizedBox(
//                               height: height * 0.01,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )),
//               Padding(
//                 padding: EdgeInsets.only(top: height * 0.19),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     topContainer('19185 ', 'Exp', 'My Experience',
//                         AppColors.gradientFirstColor, FontWeight.w500),
//                     topContainer('24 ', 'days', 'Payout time',
//                         AppColors.primaryTextColor, FontWeight.w900),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.all(13),
//             height: height * 0.05,
//             decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.primaryTextColor, width: 1),
//                 borderRadius: BorderRadius.circular(5)),
//             child: textWidget(
//                 text:
//                     'VIP level rewards are settled at 2:00 am on the 1st of every month',
//                 color: Colors.grey,
//                 fontSize: 11,
//                 fontWeight: FontWeight.w500),
//           ),
//           SizedBox(
//             height: height * 0.25,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemCount: vipLevel.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding: const EdgeInsets.all(8),
//                   margin: const EdgeInsets.all(5),
//                   height: height * 0.18,
//                   width: width * 0.8,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: vipLevel[index].bottomColor,
//                       image:  DecorationImage(
//                           image: AssetImage(vipLevel[index].bgImage.toString()),
//                           fit: BoxFit.cover)),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: height * 0.1,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               height: height * 0.1,
//                               width: width * 0.52,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                        Image(
//                                         image: AssetImage(vipLevel[index].topImg.toString()),
//                                         height: 30,
//                                       ),
//                                       textWidget(
//                                           text: vipLevel[index].title.toString(),
//                                           color: const Color(0xFFFFFFFF),
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700),
//                                        Image(
//                                         image: AssetImage(vipLevel[index].achievedImg.toString()),
//                                         height: 18,
//                                       ),
//                                       textWidget(
//                                           text: vipLevel[index].status=='1'?'Achieved':'Not opened yet',
//                                           color: const Color(0xFFFFFFFF),
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400),
//                                     ],
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     height: height * 0.03,
//                                     width: width * 0.32,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.white),
//                                         borderRadius: BorderRadius.circular(5)),
//                                     child: textWidget(
//                                         text: ' Dear ${vipLevel[index].title.toString()} customer',
//                                         color: Colors.white),
//                                   ),
//                                   vipLevel[index].status=='0'?
//                                   textWidget(
//                                       text: 'Level maintenance',
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 12):Container(),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: height * 0.1,
//                               width: width * 0.22,
//                               child:  Image(
//                                 image: AssetImage(vipLevel[index].levelImage.toString()),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 5,),
//                       vipLevel[index].status!='1'?
//                       SizedBox(
//                         height: height * 0.1,
//                         // color: Colors.purpleAccent,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   alignment: Alignment.center,
//                                   height: 20,
//                                   width: width * 0.2,
//                                   decoration: BoxDecoration(
//                                       color: Colors.black.withOpacity(0.5),
//                                       borderRadius: BorderRadius.circular(5)),
//                                   child: textWidget(
//                                       text: '${vipLevel[index].achievedNumber}/${vipLevel[index].targetNumber}', color: Colors.white),
//                                 ),
//                                 textWidget(
//                                     text: '${vipLevel[index].completePercentage}% Completed',
//                                     color: Colors.white),
//                               ],
//                             ),
//                             const SizedBox(height: 10,),
//                             Container(
//                               alignment: Alignment.center,
//                               child: LinearPercentIndicator(
//                                 animation: true,
//                                 animationDuration: 1000,
//                                 lineHeight: 9.0,
//                                 percent: double.parse(vipLevel[index].completePercentage.toString() ) / 100,
//                                 progressColor: Colors.yellow[400],
//                                 backgroundColor: vipLevel[index].backGroundColor,
//                               ),
//                             ),
//                             textWidget(
//                                 text:
//                                     '   Incomplete will be deducted by the system',
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700)
//                           ],
//                         ),
//                       ):
//                       textWidget(
//                           text:
//                           'Received ${vipLevel[index].title} level bonus',
//                           color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700)
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(14, 14, 0, 5),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             const Image(
//                               image: AssetImage(Assets.iconsVipdiamond),
//                               height: 25,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             textWidget(
//                                 text: 'VIP1 Benefits level',
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 20,
//                                 )
//                           ],
//                         ),
//                         const Divider(
//                           indent: 30,
//                           thickness: 1,
//                           endIndent: 20,
//                           color: AppColors.constColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: levelList.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: SizedBox(
//                             height: height * 0.08,
//                             width: width * 0.17,
//                             child: Image(
//                               image: AssetImage(levelList[index].image),
//                             ),
//                           ),
//                           title: textWidget(
//                               text: levelList[index].title,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 18,
//                               ),
//                           subtitle: textWidget(
//                               text: levelList[index].subTitle,
//                               color: Colors.grey),
//                           trailing: index == 2 || index == 3
//                               ? vipBenefit(levelList[index].tralingText,
//                                   levelList[index].tralingIcon)
//                               : Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     vipBenefit(levelList[index].tralingText,
//                                         levelList[index].tralingIcon),
//                                     vipBenefit(
//                                         levelList[index]
//                                             .tralingText1
//                                             .toString(),
//                                         levelList[index]
//                                             .tralingIcon1
//                                             .toString()),
//                                   ],
//                                 ),
//                         );
//                       })
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(14, 14, 0, 5),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             const Image(
//                               image: AssetImage(Assets.iconsVipcrown),
//                               height: 25,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             textWidget(
//                                 text: 'My benefits',
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 20,
//                                 )
//                           ],
//                         ),
//                         const Divider(
//                           indent: 30,
//                           thickness: 1,
//                           endIndent: 20,
//                           color: AppColors.constColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 8.0,
//                                 mainAxisSpacing: 0.4,
//                                 childAspectRatio: 0.6),
//                         shrinkWrap: true,
//                         itemCount: levelList.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Center(
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: height * 0.29,
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(10),
//                                         topLeft: Radius.circular(10)),
//                                     color: Colors.white,
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: height * 0.2,
//                                         decoration: const BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(10),
//                                               topLeft: Radius.circular(10)),
//                                           gradient: AppColors.loginSecondryGrad,
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               height: height * 0.17,
//                                               decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image: AssetImage(
//                                                           levelList[index]
//                                                               .myBenefitImage
//                                                               .toString()))),
//                                             ),
//                                             Container(
//                                               height: height * 0.03,
//                                               decoration: const BoxDecoration(
//                                                 gradient:
//                                                     AppColors.buttonGradient2,
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Image.asset(
//                                                     levelList[index]
//                                                         .tralingIcon,
//                                                     height: 14,
//                                                   ),
//                                                   textWidget(
//                                                     text: levelList[index]
//                                                         .tralingText,
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: AppColors
//                                                         .primaryTextColor,
//                                                     maxLines: 1,
//                                                   ),
//                                                   const Spacer(),
//                                                   index == 2 || index == 3
//                                                       ? Container()
//                                                       : Image.asset(
//                                                           levelList[index]
//                                                               .tralingIcon1
//                                                               .toString(),
//                                                           height: 14,
//                                                         ),
//                                                   index == 2 || index == 3
//                                                       ? Container()
//                                                       : textWidget(
//                                                           text: levelList[index]
//                                                               .tralingText1
//                                                               .toString(),
//                                                           fontSize: 13,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: AppColors
//                                                               .primaryTextColor,
//                                                           maxLines: 1,
//                                                         ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0, top: 8),
//                                         child: textWidget(
//                                           text:
//                                               levelList[index].title.toString(),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w900,
//                                           color: AppColors.primaryTextColor,
//                                           maxLines: 1,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0, top: 8),
//                                         child: textWidget(
//                                           text: levelList[index]
//                                               .subTitle
//                                               .toString(),
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w700,
//                                           color: AppColors.dividerColor,
//                                           maxLines: 2,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//
//                                 AppBtn(
//                                   title: 'Received',
//                                   fontSize: 20,
//                                   onTap: () {},
//                                   hideBorder: true,
//                                   gradient: AppColors.buttonGradient,
//                                   height: 40,
//                                   width: width,
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Container(
//                   height: height * 0.07,
//                   width: width,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildInkWell(21, 'History'),
//                       buildInkWell(22, 'Rules'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * 0.01,
//                 ),
//                 selectedIndex == 21
//                     ? Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white),
//                         child: Column(
//                           children: [
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: 2,
//                               physics: const BouncingScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Center(
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: SizedBox(
//                                       width: width,
//                                       child: Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             8, 15, 8, 0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Text(
//                                               'Experience Bonus',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 17,
//                                                   color: Colors.blue),
//                                             ),
//                                             SizedBox(
//                                               height: height * 0.02,
//                                             ),
//                                             const Text(
//                                               'Betting EXP',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 12,
//                                                   color:
//                                                       AppColors.dividerColor),
//                                             ),
//                                             SizedBox(
//                                               height: height * 0.02,
//                                             ),
//                                             const Row(
//                                               children: [
//                                                 Text(
//                                                   '2024-05-04 15:00:29',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       fontSize: 12,
//                                                       color: AppColors
//                                                           .dividerColor),
//                                                 ),
//                                                 Spacer(),
//                                                 Text(
//                                                   '122 EXP',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       fontSize: 12,
//                                                       color: Colors.green),
//                                                 ),
//                                               ],
//                                             ),
//                                             const Divider(
//                                               color:
//                                                   AppColors.secondaryTextColor,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.fromLTRB(20, 15, 20, 10),
//                               child: AppBtn(
//                                 title: 'View All',
//                                 fontSize: 20,
//                                 titleColor: AppColors.gradientFirstColor,
//                                 onTap: () {},
//                                 gradient: AppColors.whitegradient,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: height * 0.02,
//                             ),
//                             Center(
//                                 child: textWidget(
//                                     text: 'VIP privileges',
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.gradientFirstColor)),
//                             SizedBox(
//                               height: height * 0.01,
//                             ),
//                             Center(
//                                 child: textWidget(
//                                     text: 'VIP rule description',
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 15,
//                                     color: AppColors.btnColor)),
//                             SizedBox(
//                               height: height * 0.02,
//                             ),
//                             ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: ruleData.length,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: Stack(
//                                       clipBehavior: Clip.none,
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 1.2),
//                                           child: Container(
//                                             padding: const EdgeInsets.all(16),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: Border.all(
//                                                     color:Colors.blue,
//                                                     width: 0.5),
//                                                 //  gradient: AppColors.primaryUnselectedGradient,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       8, 30, 8, 20),
//                                               child: textWidget(
//                                                   text:ruleData[index].discription.toString(),
//                                                   fontSize: 15,
//                                                   color: AppColors
//                                                       .primaryTextColor,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           top: -20,
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 1),
//                                             child: Container(
//                                               height: height * 0.09,
//                                               width: width * 0.884,
//                                               decoration:  BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(10),
//                                                   image: DecorationImage(
//                                                       image: AssetImage(Assets
//                                                           .iconsViprulehead),
//                                                       fit: BoxFit.fill,
//                                                     colorFilter: ColorFilter.mode(
//                                                       Colors.blue,
//                                                       BlendMode.color,
//                                                     ),)
//                                               ),
//                                               child:  Center(
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       bottom: 15.0),
//                                                   child: Text(
//                                                     ruleData[index].title.toString(),
//                                                     style: const TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         fontSize: 14,
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 })
//                           ],
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<List<BenefitsLevel>> fetchLevelListFromAPI() async {
//     final response = await http.get(Uri.parse('YOUR_API_ENDPOINT_HERE'));
//
//     if (response.statusCode == 200) {
//       // Parse the JSON response
//       final List<dynamic> data = jsonDecode(response.body);
//
//       List<BenefitsLevel> levelList = data.map((item) {
//         return BenefitsLevel(
//           image: item['image'],
//           title: item['title'],
//           subTitle: item['subTitle'],
//           tralingText: item['tralingText'],
//           tralingIcon: item['tralingIcon'],
//           tralingText1: item['tralingText1'],
//           tralingIcon1: item['tralingIcon1'],
//           myBenefitImage: item['myBenefitImage'],
//         );
//       }).toList();
//
//       return levelList;
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }
//
//   vipBenefit(String title, String imagePath) {
//     return Container(
//       alignment: Alignment.center,
//       height: height * 0.03,
//       width: width * 0.22,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(color: AppColors.gradientFirstColor)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image(
//               image: AssetImage(imagePath),
//               height: 16,
//             ),
//             textWidget(
//                 text: title, color: AppColors.gradientFirstColor, fontSize: 15)
//           ],
//         ),
//       ),
//     );
//   }
//
//   topContainer(String title, String title1, String subTitle, titleColor,
//       FontWeight fontWeight) {
//     return Container(
//       height: height * 0.08,
//       width: width * 0.45,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadiusDirectional.circular(5)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               textWidget(
//                   text: title,
//                   fontSize: 15,
//                   fontWeight: fontWeight,
//                   color: titleColor),
//               textWidget(
//                   text: title1,
//                   fontSize: 14,
//                   //fontWeight: FontWeight.w900, // Example use of FontWeight.w900
//                   color: titleColor),
//             ],
//           ),
//           textWidget(
//               text: subTitle,
//               fontSize: 12,
//               fontWeight: FontWeight.w900,
//               color: AppColors.primaryTextColor),
//         ],
//       ),
//     );
//   }
//
//   int selectedIndex = 21;
//   buildInkWell(int index, String title) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Center(
//         child: Container(
//           height: height * 0.07,
//           width: width * 0.477,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               gradient: index == selectedIndex
//                   ? AppColors.boxGradient
//                   : AppColors.whitegradient),
//           child: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                   color: index == selectedIndex
//                       ? Colors.white
//                       : Colors.grey),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class BenefitsLevel {
//   final String image;
//   final String title;
//   final String subTitle;
//   final String tralingText;
//   final String tralingIcon;
//   final String? tralingText1;
//   final String? tralingIcon1;
//   final String? myBenefitImage;
//
//   BenefitsLevel({
//     required this.image,
//     required this.title,
//     required this.subTitle,
//     required this.tralingText,
//     required this.tralingIcon,
//     this.tralingText1,
//     this.tralingIcon1,
//     this.myBenefitImage,
//   });
// }
// class VipRule {
//   final String discription;
//   final String title;
//
//
//   VipRule({
//     required this.discription,
//     required this.title,
//
//   });
// }
//
//
// class VipLevel {
//   final String bgImage;
//   final String title;
//   final String achievedImg;
//   final String levelImage;
//   final String targetNumber;
//   final String? achievedNumber;
//   final String? completePercentage;
//   final Color? bottomColor;
//   final Color? backGroundColor;
//   final String? status;
//   final String? topImg;
//   final String? id;
//
//   VipLevel({
//     required this.bgImage,
//     required this.title,
//     required this.achievedImg,
//     required this.levelImage,
//     required this.targetNumber,
//     required this.achievedNumber,
//     required this.completePercentage,
//     required this.bottomColor,
//     required this.backGroundColor,
//     required this.status,
//     required this.topImg,
//      this.id,
//   });
// }
