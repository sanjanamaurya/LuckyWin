import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/provider/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController feed = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final feedbackk = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'Feedback',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.white,),

          gradient: AppColors.primaryGradient),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  maxLines: 10,
                  controller: feed,
                  style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.primaryTextColor),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: AppColors.primaryTextColor),
                    hintText: 'Welcome to feedback, please give feedback-please describe the problem in detail when providing feedback, preferably attach a screenshot of the problem you encountered, we will immediately process your feedback!',
                    contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white.withOpacity(0.5)),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    disabledBorder: const OutlineInputBorder(
                        borderSide:  BorderSide(width: 1, color: AppColors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:  BorderSide(width: 1, color:AppColors.white),
                        borderRadius:BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    fillColor:AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            textWidget(
              text: 'Send helpful feedback',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.primaryTextColor,),

            SizedBox(height: height*0.01,),
            textWidget(
              text: 'Change to win Mystery Rewards',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.primaryTextColor,),
            SizedBox(height: height*0.02,),
            Container(
              height: height*0.3,
              width: width*0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.imagesFeedbackImg))
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
              child: AppBtn(
                title: 'Submit',
                fontSize: 20,
                hideBorder: true,
                titleColor: AppColors.white,
                onTap: () {
                  feedbackk.Feedbacksubmit(context, feed.text);

                },
                gradient: AppColors.primaryGradient,
              ),
            ),


          ],
        ),
      ),
    );

  }

}

