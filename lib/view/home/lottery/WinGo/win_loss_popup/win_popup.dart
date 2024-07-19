import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/text_widget.dart';


class WinPopupPage extends StatefulWidget {

      String subtext;
  String subtext1;
      String subtext2;
  String subtext3;
      String subtext4;

   WinPopupPage( {super.key,required this.subtext,required this.subtext1, required this.subtext2,required this.subtext3,required this.subtext4, });

  @override
  State<WinPopupPage> createState() => _WinPopupPageState();
}

class _WinPopupPageState extends State<WinPopupPage> {
  @override
  Widget build(BuildContext context) {
    List<Color> colors;

    if (widget.subtext == 0) {
        colors = [
          Colors.red,
          Colors.purple,
        ];
      } else if (widget.subtext == 5) {
        colors = [
          const Color(0xFF40ad72),
          Colors.purple

        ];
      } else {
        int number = int.parse(
            widget.subtext.toString());
        colors = number.isOdd
            ? [
          const Color(0xFF40ad72),
          const Color(0xFF40ad72),
        ]
            : [
          Colors.red,
          Colors.red,
        ];
      }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 450,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(Assets.imagesWinredpopup),
              ),
            ),
            child: Column(
              children: [
               // SizedBox(height: height*0.17,),
                const SizedBox(height: 120,),
                textWidget(
                  text: "Congratulation",
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
               // SizedBox(height: height*0.07,),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: width*0.04,),
                    textWidget(
                      text: "Lottery result",
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 5,),
                    Container(
                      width: width*0.2,
                      height: height*0.03,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                          colors: colors,
                          stops: const [0.5, 0.5],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Center(
                        child: textWidget(
                          text: widget.subtext.toString() == '10' ? 'Green' :
                          widget. subtext.toString() == '20' ? 'Violet' :
                          widget.subtext.toString() == '30' ? 'Red' :
                          widget.subtext.toString() == '0' ? 'Red Violet' :
                          widget.subtext.toString() == '5' ? 'Green Violet' :
                          (widget.subtext.toString() == '1' || widget.subtext.toString() == '3' || widget.subtext.toString() == '7' || widget.subtext.toString() == '9') ? 'green' :
                          'White',
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Container(
                      width:  width*0.04,
                      height: height*0.03,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: colors,
                          stops: const [0.5, 0.5],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child:  Center(
                        child: textWidget(
                          text: widget.subtext.toString(),
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),

                    Container(
                      width:  width*0.08,
                      height: height*0.03,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                          colors: colors,
                          stops: const [0.5, 0.5],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child:  Center(
                        child: textWidget(
                          text:   int.parse(widget.subtext.toString()) < 5
                              ? 'Small'
                              : 'Big',
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            //    SizedBox(height: height*0.05,),
                const SizedBox(height: 40,),
                textWidget(
                  text: "Bonus",
                  fontSize: 25,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w900,
                ),
                //  SizedBox(height: height*0.01,),
                textWidget(
                  text:'₹${widget.subtext2}',
                  fontSize: 25,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w900,
                ),
                //SizedBox(height: height*0.02,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                      text: "Period : ",
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                    textWidget(
                      text:  widget.subtext4 == "1"
                          ? "1 min"
                          : widget.subtext4 == "2"
                          ? "3 min"
                          : widget.subtext4 == "3"
                          ? "5 min"
                          : widget.subtext4 == "4"
                          ? "10 min"
                          : widget.subtext4 == "6"
                          ? "1 min"
                          : widget.subtext4 == "7"
                          ? "3 min"
                          : widget.subtext4 == "8"
                          ? "5 min":"10 min",
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.w900,
                    ),
                    const SizedBox(width: 10,),
                    textWidget(
                      text: widget.subtext3.toString(),
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
              ],
            ),

          ),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.cancel_outlined,size: 40,color: Colors.white,))
        ],
      ),
    );
  }
}
