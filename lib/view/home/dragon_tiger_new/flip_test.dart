// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:win_play/generated/assets.dart';
// import 'package:win_play/library/fade_animation.dart';
// import 'package:win_play/res/text_widget.dart';
//
// import '../../library/glowy_border.dart';
// import '../../view_model/dr_ti_view_model.dart';
//
// class FlipTest extends StatefulWidget {
//   const FlipTest({Key? key}) : super(key: key);
//
//   @override
//   State<FlipTest> createState() => _FlipTestState();
// }
//
// class _FlipTestState extends State<FlipTest> {
//   bool _showFrontSide = false;
//   @override
//   void initState() {
//     final drTiResultViewModel =
//         Provider.of<DrTiResultViewModel>(listen: false, context);
//     Map data = {"game_id": "2"};
//     drTiResultViewModel.drTiResultApi(data, context);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final drTiResultViewModel = Provider.of<DrTiResultViewModel>(context);
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 600),
//                 transitionBuilder: __transitionBuilder,
//                 child: _showFrontSide
//                     ? _buildFrontOne(drTiResultViewModel)
//                     : FadeInRight(child: _buildBack()),
//               ),
//               const SizedBox(width: 15),
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 600),
//                 transitionBuilder: __transitionBuilder,
//                 child: _showFrontSide
//                     ? _buildFrontTwo(drTiResultViewModel)
//                     : FadeInLeft(child: _buildBack()),
//               )
//             ],
//           ),
//           ElevatedButton(
//               onPressed: () => setState(() => _showFrontSide = !_showFrontSide),
//               child: textWidget(text: 'Flip'))
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFrontOne(drTiResultViewModel) {
//     final data = cardImage
//         .where((element) =>
//             element['cardColor'] ==
//                 drTiResultViewModel.drTiResultList.last.dragonCardType &&
//             element['cardNumber'] ==
//                 drTiResultViewModel.drTiResultList.last.dragonCardNum)
//         .first;
//     return AnimatedGradientBorder(
//       borderSize: drTiResultViewModel.drTiResult == '60' ||
//               drTiResultViewModel.drTiResult == '80'
//           ? 3
//           : 0,
//       gradientColors: const [
//         Color(0xfffaee72),
//         Colors.transparent,
//         Color(0xfffaee72),
//       ],
//       borderRadius: const BorderRadius.all(
//         Radius.circular(5),
//       ),
//       child: Container(
//         // key: key,
//         height: 110,
//         width: 80,
//         decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(5.0),
//             image: DecorationImage(
//                 image: AssetImage(
//                   data['cardImage'],
//                 ),
//                 fit: BoxFit.fill)),
//       ),
//     );
//
//     // _buildFrontLayout(
//     //   key: const ValueKey('front_one'),
//     //   imageData: data['cardImage'],
//     //   drTiResultViewModel: drTiResultViewModel);
//   }
//
//   Widget _buildFrontTwo(drTiResultViewModel) {
//     final data = cardImage
//         .where((element) =>
//             element['cardColor'] ==
//                 drTiResultViewModel.drTiResultList.last.tigerCardType &&
//             element['cardNumber'] ==
//                 drTiResultViewModel.drTiResultList.last.tigerCardNum)
//         .first;
//     return AnimatedGradientBorder(
//       borderSize: drTiResultViewModel.drTiResult == '70' ||
//               drTiResultViewModel.drTiResult == '80'
//           ? 3
//           : 0,
//       gradientColors: const [
//         Color(0xfffaee72),
//         Colors.transparent,
//         Color(0xfffaee72),
//       ],
//       borderRadius: const BorderRadius.all(
//         Radius.circular(5),
//       ),
//       child: Container(
//         // key: key,
//         height: 110,
//         width: 80,
//         decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(5.0),
//             image: DecorationImage(
//                 image: AssetImage(
//                   data['cardImage'],
//                 ),
//                 fit: BoxFit.fill)),
//       ),
//     );
//
//     // _buildFrontLayout(
//     //   key: const ValueKey('front_two'),
//     //   imageData: data['cardImage'],
//     //   drTiResultViewModel: drTiResultViewModel);
//   }
//
//   Widget _buildBack() {
//     return Container(
//       height: 110,
//       width: 80,
//       decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(5.0),
//           image: const DecorationImage(
//               image: AssetImage(
//                 Assets.cardFireCard,
//               ),
//               fit: BoxFit.fill)),
//     );
//
//     //   _buildBackLayout(
//     //   key: const ValueKey('back_one'),
//     //   imageData: Assets.cardFireCard,
//     // );
//   }
//
//   Widget __transitionBuilder(Widget child, Animation<double> animation) {
//     final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
//     return AnimatedBuilder(
//       animation: rotateAnim,
//       child: child,
//       builder: (context, child) {
//         final isUnder = (ValueKey(_showFrontSide) != child!.key);
//         final value =
//             isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
//         return Transform(
//           transform: Matrix4.rotationY(value),
//           alignment: Alignment.center,
//           child: child,
//         );
//       },
//     );
//   }
// }
