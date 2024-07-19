import 'package:flutter/material.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/model/Slider_model.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/app_btn.dart';

class ActivityDetails extends StatefulWidget {
  final SliderModel bannerdata;
  const ActivityDetails({super.key, required this.bannerdata});

  @override
  State<ActivityDetails> createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: const GradientAppBar(
          title: Text(
            "Activity Details",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: AppBackBtn(),
          gradient: AppColors.primaryGradient),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox( height: height * 0.02,),
          Container(
            height: 150,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    widget.bannerdata.image.toString()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox( height: height * 0.01,),
          Center(
            child: Text(widget.bannerdata.name.toString(),style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),
          widget.bannerdata.activity_image == null?const SizedBox()
          :Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height*0.90,
              width: width,
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      widget.bannerdata.activity_image.toString()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
