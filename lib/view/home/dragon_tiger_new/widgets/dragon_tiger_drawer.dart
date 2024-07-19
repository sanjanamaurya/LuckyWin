// import 'package:flutter/material.dart';
// import 'package:theluckywin/generated/assets.dart';
// import 'package:theluckywin/res/aap_colors.dart';
// import 'package:theluckywin/res/components/text_widget.dart';
// import 'dr_ti_setting.dart';
// import 'how_to_play.dart';
//
// class DragonTigerDrawer extends StatelessWidget {
//   const DragonTigerDrawer({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DrawerDesign(
//             imageData: Assets.iconsLeaveTable,
//             title: 'Leave Table',
//             onTap: () {
//               Navigator.pop(context);
//             }),
//         DrawerDesign(
//             imageData: Assets.iconsSettings,
//             title: 'Settings',
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return const DrTiSetting();
//                 },
//               );
//             }),
//         DrawerDesign(
//             imageData: Assets.iconsDetails,
//             title: 'Details',
//             onTap: () {
//               // Navigator.pushNamed(context, RoutesName.transaction);
//             }),
//         DrawerDesign(
//             imageData: Assets.iconsHowToPlay,
//             title: 'How To Play',
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return const HowToPlay();
//                 },
//               );
//             }),
//         const SizedBox(
//           height: 30,
//         ),
//         DrawerDesign(
//             imageData: Assets.iconsActivity,
//             title: 'Activity',
//             setColor: true,
//             onTap: () {
//               // showDialog(
//               //   context: context,
//               //   builder: (BuildContext context) {
//               //     return const WingoActivity();
//               //   },
//               // );
//             }),
//         DrawerDesign(
//             imageData: Assets.iconsTigerKing,
//             title: 'Tiger King',
//             setColor: true,
//             onTap: () {}),
//       ],
//     );
//   }
// }
//
// class DrawerDesign extends StatelessWidget {
//   final Function()? onTap;
//   final String imageData;
//   final String title;
//   final bool? setColor;
//   const DrawerDesign(
//       {Key? key,
//       this.onTap,
//       required this.imageData,
//       required this.title,
//       this.setColor = false})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 50,
//         padding: const EdgeInsets.only(left: 10),
//         decoration: BoxDecoration(
//             color: setColor == false
//                 ? AppColors.appConFirstColor
//                 : AppColors.appConSecondColor,
//             border: Border(
//                 bottom: BorderSide(
//                     width: 1,
//                     color: setColor == false
//                         ? Colors.blueGrey.withOpacity(0.5)
//                         : Colors.black))),
//         child: Row(
//           children: [
//             Image(
//               image: AssetImage(imageData),
//               width: 30,
//             ),
//             const SizedBox(width: 10),
//             textWidget(
//                 text: title,
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w900,
//                 fontSize: 18),
//           ],
//         ),
//       ),
//     );
//   }
// }
