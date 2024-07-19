// // ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
//
// import 'package:flutter/material.dart';
//
// class CommonBottomSheet extends StatefulWidget {
//   final List<Color>? colors;
//   final String colorName;
//   final String predictionType;
//
//   const CommonBottomSheet({
//     super.key,
//     this.colors,
//     required this.colorName,
//     required this.predictionType,
//   });
//
//   @override
//   State<CommonBottomSheet> createState() => _CommonBottomSheetState();
// }
//
// var h;
// var w;
//
// class _CommonBottomSheetState extends State<CommonBottomSheet> {
//
//
//   @override
//   void initState() {
//     amount.text=selectedIndex.toString();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   int value = 1;
//   int selectedAmount = 0;
//   int? walletApi;
//   int? wallbal;
//   int selectedIndex = 10;
//   TextEditingController amount = TextEditingController();
//
//   void increment() {
//     setState(() {
//       value = value + 1;
//       deductAmount();
//     });
//   }
//
//   void decrement() {
//     setState(() {
//       if (value > 0) {
//         value = value - 1;
//         deductAmount();
//       }
//     });
//   }
//
//   void selectam(int amount) {
//     setState(() {
//       selectedAmount = amount;
//       value = 1;
//     });
//     deductAmount();
//   }
//
//   void deductAmount() {
//     if (wallbal! >= selectedAmount * value) {
//       walletApi = wallbal;
//     }
//     int amountToDeduct = selectedAmount * value;
//     if (walletApi! >= amountToDeduct) {
//       setState(() {
//         amount.text = (selectedAmount * value).toString();
//         walletApi = (walletApi! - amountToDeduct).toInt();
//       });
//     } else {
//       // Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
//     }
//   }
//
//   List<int> list = [
//     10,
//     50,
//     100,
//     500,
//   ];
//
//
//
//
//
//
//
//   String gametitle='Wingo';
//   String subtitle='1 Min';
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//     h = MediaQuery.of(context).size.height;
//     w = MediaQuery.of(context).size.width;
//     LinearGradient gradient = LinearGradient(
//         colors: widget.colors ?? [Colors.white, Colors.black],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         tileMode: TileMode.mirror);
//     return Scaffold(
//       body: SizedBox(
//         height: h / 1.9,
//         width: w,
//         child: Column(
//           children: [
//             Container(
//               height: 25,
//               width: w,
//               decoration: BoxDecoration(
//                 color:
//                 widget.colors == null ? Colors.white : widget.colors!.first,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(28),
//                   topRight: Radius.circular(28),
//                 ),
//               ),
//               alignment: Alignment.center,
//               child:  const Text('gg')
//             ),
//             Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 SizedBox(
//                     width: w,
//                     child: SizedBox(
//                       width: 200,
//                       height: 200,
//                       child: widget.predictionType == "1"
//                           ? ShaderMask(
//                         shaderCallback: (Rect bounds) {
//                           return gradient.createShader(bounds);
//                         },
//                         blendMode: BlendMode.srcATop,
//                         child: CustomPaint(
//                           painter: _InvertedTrianglePainterSingle(),
//                         ),
//                       )
//                           : Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SizedBox(
//                             height: 200,
//                             width: w,
//                             child: ShaderMask(
//                               shaderCallback: (Rect bounds) {
//                                 return gradient.createShader(bounds);
//                               },
//                               blendMode: BlendMode.srcATop,
//                               child: CustomPaint(
//                                 painter: _InvertedTrianglePainterSingle(),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 35,
//                             bottom: 65,
//                             child: Transform.rotate(
//                               angle: -0.18,
//                               child: SizedBox(
//                                 height: 200,
//                                 width: w,
//                                 child: CustomPaint(
//                                   painter: _InvertedTrianglePainterDouble(
//                                       widget.colors),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(top: 5),
//                       alignment: Alignment.center,
//                       width: widget.predictionType == "1" ? w / 2 : w / 1.5,
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Text(
//                         "Select:  ${widget.colorName}",
//                         style: const TextStyle(color: Colors.black, fontSize: 20),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(5),
//                       width: w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Balance",
//                             style: TextStyle(fontSize: 18),
//                           ),
//
//                           SizedBox(
//                             width: 200,
//                             height: 30,
//                             child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemCount: list.length,
//
//                                 itemBuilder: (context, int index){
//                                   return InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedIndex=list[index];
//                                         });
//                                         selectam(selectedIndex);
//                                       },
//                                       child: Container(
//                                           margin: const EdgeInsets.only(right: 5),
//                                           padding: const EdgeInsets.all(5),
//                                           color:selectedIndex==list[index]?widget.colors!.first:Colors.white,
//                                           child: Text(list[index].toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 18,
//                                                 color:Colors.black
//                                             ),
//                                           )));
//                                 }),
//                           )
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(5),
//                       width: w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Quantity",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InkWell(
//                                   onTap: decrement,
//                                   child: Container(
//                                     width: 35,
//                                     alignment: Alignment.center,
//                                     margin: const EdgeInsets.only(right: 5),
//                                     padding: const EdgeInsets.all(5),
//                                     color: widget.colors!.first,
//                                     child: const Text("--",
//                                         style: TextStyle(
//                                             fontSize: 18, color: Colors.white)),
//                                   ),
//                                 ),
//
//                                 Container(
//                                     height: 35,
//                                     alignment: Alignment.center,
//                                     padding: const EdgeInsets.all(4),
//                                     width: 75,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(2),
//                                       border: Border.all(
//                                           width: 1, color: Colors.grey.shade500),
//                                     ),
//                                     child: TextField(
//                                       controller: amount,
//                                       readOnly: true,
//                                       textAlign: TextAlign.center,
//                                       decoration: const InputDecoration(
//                                           border: InputBorder.none
//                                       ),
//                                       style: const TextStyle(fontSize: 18, color: Colors.black),
//                                     )
//                                 ),
//
//                                 InkWell(
//                                   onTap: increment,
//                                   child: Container(
//                                     width: 35,
//                                     alignment: Alignment.center,
//                                     margin: const EdgeInsets.only(left: 5),
//                                     padding: const EdgeInsets.all(5),
//                                     color:widget.colors!.first,
//                                     child: const Text("+",
//                                         style: TextStyle(
//                                             fontSize: 18, color: Colors.white)),
//                                   ),
//                                 ),
//
//                               ]),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Row(
//               children: [
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Icon(
//                   Icons.check_circle,
//                   color: Colors.red,
//                 ),
//                 Text(" I agree"),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text(
//                   "(Pre sale rule)",
//                   style: TextStyle(color: Colors.red),
//                 )
//               ],
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     color: Colors.black.withOpacity(0.7),
//                     width: w / 3,
//                     height: 45,
//                     child: const Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: (){
//                     // Betprovider.Colorbet(context,amount.text,widget.predictionType,widget.gameid );
//
//                   },
//                   child: Center(
//                     child: Container(
//                       alignment: Alignment.center,
//                       color: widget.colors!.first,
//                       width: w / 1.5,
//                       height: 45,
//                       child: Text(
//                         "Total amount ${amount.text}",
//                         style: const TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
// }
//
// class _InvertedTrianglePainterSingle extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..strokeWidth = 3.0
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill;
//
//     final Path path = Path();
//     path.moveTo(size.width / -1.8, 0);
//     path.lineTo(size.width * 1.5, 0);
//     path.lineTo(size.width / 2, size.height / 2.8);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class _InvertedTrianglePainterDouble extends CustomPainter {
//   final List<Color>? color;
//
//   _InvertedTrianglePainterDouble(this.color);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint1 = Paint()
//       ..strokeWidth = 3.0
//       ..strokeCap = StrokeCap.round
//       ..color = color!.last
//       ..style = PaintingStyle.fill;
//
//     final Path path1 = Path();
//     path1.moveTo(size.width / 5, -5);
//     path1.lineTo(size.width * 15, 0);
//     path1.lineTo(size.width / 2, size.height / 2.8);
//
//     canvas.drawPath(path1, paint1);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
//
//
// }