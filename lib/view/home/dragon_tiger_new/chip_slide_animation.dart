// import 'package:flutter/material.dart';
// import '../../generated/assets.dart';
// import '../../main.dart';
// import '../../res/up_down_border.dart';
// import 'coin/single_coin.dart';
//
//
// class AlignAnimationExample extends StatefulWidget {
//   const AlignAnimationExample({super.key});
//
//   @override
//   _AlignAnimationExampleState createState() => _AlignAnimationExampleState();
// }
//
// class _AlignAnimationExampleState extends State<AlignAnimationExample> {
//   int selectedIndex = 0;
//   late int coinVal;
//   List<ChipModel> chipList = [
//     ChipModel(value: 5, image: Assets.chip50),
//     ChipModel(value: 10, image: Assets.chip100),
//     ChipModel(value: 50, image: Assets.chip500),
//     ChipModel(value: 100, image: Assets.chip1000),
//   ];
//
//   late Offset _endOffset;
//   late List<GlobalKey> _globalKey;
//
//   @override
//   void initState() {
//     coinVal = chipList[selectedIndex].value;
//     _globalKey = List.generate(chipList.length, (index) => GlobalKey());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((c) {
//       _endOffset = (_globalKey[selectedIndex].currentContext!.findRenderObject()
//               as RenderBox)
//           .localToGlobal(Offset.zero);
//     });
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Builder(builder: (context) {
//             return GestureDetector(
//               onTap: () {
//                 var overlayEntry = OverlayEntry(builder: (_) {
//                   RenderBox? box = context.findRenderObject() as RenderBox?;
//                   var offset = box!.localToGlobal(const Offset(170, 50));
//                   return EasyCartAnimation(
//                     startPosition: _endOffset,
//                     endPosition: offset,
//                     height: 30,
//                     width: 30,
//                     child: Image.asset(
//                       chipList[selectedIndex].image,
//                       height: heights / 13,
//                     ),
//                   );
//                 });
//                 Overlay.of(context).insert(overlayEntry);
//                 Future.delayed(const Duration(seconds: 2), () {
//                   overlayEntry.remove();
//                 });
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 10, left: 10),
//                 color: Colors.red,
//                 height: heights * 0.15,
//                 width: widths,
//               ),
//             );
//           }),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Builder(builder: (context) {
//                 return GestureDetector(
//                   onTap: () {
//                     var overlayEntry = OverlayEntry(builder: (_) {
//                       RenderBox? box = context.findRenderObject() as RenderBox?;
//                       var offset = box!.localToGlobal(const Offset(70, 120));
//                       return EasyCartAnimation(
//                         startPosition: _endOffset,
//                         endPosition: offset,
//                         height: 30,
//                         width: 30,
//                         child: Image.asset(
//                           chipList[selectedIndex].image,
//                           height: heights / 13,
//                         ),
//                       );
//                     });
//                     // Show Overlay
//                     Overlay.of(context).insert(overlayEntry);
//                     // wait for the animation to end
//                     Future.delayed(const Duration(seconds: 2), () {
//                       overlayEntry.remove();
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(left: 10, top: 10),
//                     color: Colors.red,
//                     height: heights * 0.3,
//                     width: widths / 2.2,
//                   ),
//                 );
//               }),
//               Builder(builder: (context) {
//                 return GestureDetector(
//                   onTap: () {
//                     var overlayEntry = OverlayEntry(builder: (_) {
//                       RenderBox? box = context.findRenderObject() as RenderBox?;
//                       var offset = box!.localToGlobal(const Offset(70, 120));
//                       return EasyCartAnimation(
//                         startPosition: _endOffset,
//                         endPosition: offset,
//                         height: 30,
//                         width: 30,
//                         child: Image.asset(
//                           chipList[selectedIndex].image,
//                           height: heights / 13,
//                         ),
//                       );
//                     });
//                     // Show Overlay
//                     Overlay.of(context).insert(overlayEntry);
//                     // wait for the animation to end
//                     Future.delayed(const Duration(seconds: 3), () {
//                       overlayEntry.remove();
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(right: 10, top: 10),
//                     color: Colors.red,
//                     height: heights * 0.3,
//                     width: widths / 2.2,
//                   ),
//                 );
//               }),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Container(
//             alignment: Alignment.center,
//             height: heights / 12,
//             width: widths,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemCount: chipList.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == chipList.length) {
//                   return InkWell(
//                     onTap: () {},
//                     child: Image.asset(
//                       Assets.buttonsReBet,
//                       height: heights / 12,
//                     ),
//                   );
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: UpDownBorder(
//                     borderWidth: index == selectedIndex ? 5 : 0,
//                     borerColor: Colors.lightGreenAccent.shade400,
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           coinVal = chipList[index].value;
//                           selectedIndex = index;
//                         });
//                       },
//                       child: Image.asset(
//                         key: _globalKey[index],
//                         chipList[index].image,
//                         height: heights / 13,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class ChipModel {
//   final int value;
//   final String image;
//   ChipModel({required this.value, required this.image});
// }
//
//
