import 'package:flutter/material.dart';
import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_btn.dart';

class PreRules extends StatefulWidget {
  const PreRules({super.key});

  @override
  State<PreRules> createState() => _PreRulesState();
}

class _PreRulesState extends State<PreRules> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: height*0.55,
        child: Column(
          children: [
            Container(
              height: height*0.08,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(
                  Assets.imagesPreSaleBg
                ),fit: BoxFit.fill)
              ),
              child:  Center(
                child: Text(
                  "《Pre-sale rules》",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: height*0.35,
                child: SingleChildScrollView(
                  child: Text("1 minutes 1 issue, 45 seconds to order, 15 s econds waiting for the draw. It opens all day. \n"
                      "The total number of trade is 1440 issues. \n\n"
                      "If you spend 100 to trade, after deducting 2 service fee, your contract amount is 98: \n\n"
                      "1. Select green: if the result shows 1,3,7,9 you will get (98*2) 196; lf the result shows 5, you will get (98*1.5) 147 \n\n"
                      "2. Select red: if the result shows 2,4,6,8 you will get (98*2) 196;lf the result shows 0, you will get (98*1.5) 147 \n\n"
                      "3. Select violet: if the result shows 0 or 5, you will get (98*4.5) 441 \n\n"
                      "4. Select number: if the result is the same as the number you selected, you will get (98*9) 882 \n\n"
                      "5. Select big: if the result shows 5,6,7,8,9 you will get (98*2) 196 \n\n"
                      "6. Select small: if the result shows 0,1,2,3,4 you will get (98 * 2) 196",
                   ),
                ),
              ),
            ),
            AppBtn(
              height: height*0.065,
              width: width*0.55,
              title: 'I know',
              fontSize: 20,
              titleColor: Colors.white,
              hideBorder: true,
              onTap: () {
                Navigator.pop(context);
              },
              gradient: AppColors.loginSecondryGrad,
            ),
          ],
        ),
      ),
    );
  }
}
