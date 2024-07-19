import 'package:theluckywin/generated/assets.dart';
import 'package:theluckywin/main.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'package:theluckywin/res/components/app_bar.dart';
import 'package:theluckywin/res/components/text_widget.dart';
import 'package:theluckywin/res/helper/api_helper.dart';
import 'package:theluckywin/res/provider/aboutus_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theluckywin/view/account/about_us_screen/about_new.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  void initState() {
    fetchDataAboutus();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
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
            text: 'About Us',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.white,
          ),
          gradient: AppColors.primaryGradient),
      body:Column(
        children: [
          Container(
            height: height * 0.2,
            width: width,
            // color: Colors.red,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryUnselectedGradient,
              image: DecorationImage(
                image: AssetImage(Assets.imagesAboutus),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15),
            child: Column(
              children: [
               ListTile(
                  leading: Image.asset(Assets.iconsAboutus,height: height*0.05,),
                  title: textWidget(
                    text: 'About Us',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.primaryTextColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutNewPage(
                        name:"About Us",type:"1"
                      )));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.gradientFirstColor,size: 15,),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: AppColors.gradientFirstColor,
                  endIndent: 20,
                  indent: 20,
                ),
                ListTile(
                  leading: Image.asset(Assets.iconsPrivacy,height: height*0.05,),
                  title:textWidget(
                    text: 'Confidentiality Agreement',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.primaryTextColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutNewPage(
                          name:"Confidentiality Agreement",type:"5"
                      )));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.gradientFirstColor,
                      size: 15,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: AppColors.gradientFirstColor,
                  endIndent: 20,
                  indent: 20,
                ),
                ListTile(
                  leading: Image.asset(Assets.iconsRisk,height: height*0.05,),
                  title: textWidget(
                    text: 'Risk Disclosure Agreement',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.primaryTextColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutNewPage(
                          name:"Risk Disclosure Agreement",type:"6"

                      )));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.gradientFirstColor,size: 15,),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: AppColors.gradientFirstColor,
                  endIndent: 20,
                  indent: 20,
                ),
                ListTile(
                  leading: Image.asset(Assets.iconsBigGuide,height: height*0.05,),
                  title: textWidget(
                    text: 'Terms & Condition',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.primaryTextColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutNewPage(
                          name:"Terms & Condition",type:"2"
                      )));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.gradientFirstColor,size: 15,),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: AppColors.gradientFirstColor,
                  endIndent: 20,
                  indent: 20,
                ),
                ListTile(
                  leading: Image.asset(Assets.iconsRisk,height: height*0.05,),
                  title: textWidget(
                    text: 'theluckywin FAQs',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.primaryTextColor,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutNewPage(
                          name:"theluckywin FAQs",type:"7"

                      )));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.gradientFirstColor,size: 15,),
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: AppColors.gradientFirstColor,
                  endIndent: 20,
                  indent: 20,
                ),

              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<void> fetchDataAboutus() async {
    try {
      final AbouttDataa = await baseApiHelper.fetchaboutusData();

      if (AbouttDataa != null) {
        Provider.of<AboutusProvider>(context, listen: false)
            .setUser(AbouttDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }
}
// class ListItem {
//   String? image;
//   String? name;
//   VoidCallback? onTap;
//
//   ListItem({
//     this.image,
//     this.name,
//     this.onTap,
//   });
// }
